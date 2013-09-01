require File.expand_path('../../test_helper', __FILE__)

class CustomFieldTest < ActiveSupport::TestCase
  fixtures :projects
  fixtures :members
  fixtures :issues 
  fixtures :trackers
  fixtures :users
  fixtures :enabled_modules
  
  def setup
  	@project = Project.first
    @issue = @project.issues.first
  
    @custom_field = IssueCustomField.new(:name => 'custom_field', :field_format => 'user', :searchable => true)
    assert @custom_field.save
  end
  
  def test_notify_if_user_is_assignee
  	pending
  end
  
  def test_do_not_notify_if_notify_set_to_false
		pending  
  end
  
  def test_notify_if_notify_set_to_true
    @custom_field.notify_user = true
    assert @custom_field.save
    pending
  end
  
end
