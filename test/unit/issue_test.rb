require File.expand_path('../../test_helper', __FILE__)

class IssueTest < ActiveSupport::TestCase
  fixtures :projects, :users, :members, :member_roles, :roles,
            :issues, :trackers, :users, :enabled_modules,
            :issue_statuses
  
  def setup
    @issue = Issue.find(2)
  
    @custom_field = IssueCustomField.new(:name => 'custom_field', :field_format => 'user', :searchable => true, :is_for_all => true)
    @custom_field.trackers = [@issue.tracker]
    assert @custom_field.save
    
    @user = User.logged.first
    @user.members.update_all ["mail_notification = ?", false]
    @user.update_attribute :mail_notification, 'only_assigned'
      
    assert @issue.available_custom_fields.include?(@custom_field)
    @issue.custom_field_values = { @custom_field.id => @user.id }
    @issue.save!
    @issue.reload
  end
  
  def test_should_notify_if_user_is_previous_assignee
    user = User.find(3)
    user.members.update_all ["mail_notification = ?", false]
    user.update_attribute :mail_notification, 'only_assigned'

    @issue.assigned_to = nil
    assert_include user.mail, @issue.recipients
    @issue.save!
    assert !@issue.recipients.include?(user.mail)
  end
  
  def test_should_not_notify_if_notify_set_to_false
    assert  !@issue.recipients.include?(@user.mail)
  end
  
  def test_notify_if_notify_set_to_true
    @custom_field.notify_user = true
    assert @custom_field.save
    
    assert_include @user.mail, @issue.recipients
  end
  
  def test_notify_if_custom_value_is_multi_user
    @custom_field.notify_user = true
    @custom_field.multiple = true
    assert @custom_field.save
    
    assert @issue.available_custom_fields.include?(@custom_field)
    @issue.custom_field_values = { @custom_field.id => [3, @user.id] }
    @issue.save!
    @issue.reload
    assert_include @user.mail, @issue.recipients
  end
  
end
