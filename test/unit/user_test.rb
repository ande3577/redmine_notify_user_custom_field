require File.expand_path('../../test_helper', __FILE__)

class UserTest < ActiveSupport::TestCase
  fixtures :projects, :users, :members, :member_roles, :roles,
           :issues, :trackers, :users, :enabled_modules,
           :custom_fields, :custom_fields_projects, :custom_fields_trackers,
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
  
  def test_should_notify_if_user_assignee
    user = User.find(3)
    user.members.update_all ["mail_notification = ?", false]
    user.update_attribute :mail_notification, 'only_assigned'
      
    assert user.notify_about?(@issue)
  end
  
  def test_should_not_notify_if_notify_set_to_false
    assert  !@user.notify_about?(@issue)
  end
  
  def test_notify_if_notify_set_to_true
    @custom_field.notify_user = true
    assert @custom_field.save
    @issue.reload
    
    assert  @user.notify_about?(@issue)
  end
  
  def test_notify_if_multicolumn
    @custom_field.notify_user = true
    @custom_field.multiple = true
    assert @custom_field.save
    
    assert @issue.available_custom_fields.include?(@custom_field)
    @issue.custom_field_values = { @custom_field.id => [3, @user.id] }
    @issue.save!
    @issue.reload
    
    assert  @user.notify_about?(@issue)
  end
  
end
