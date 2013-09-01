module RedmineNotifyUserUserPatch
  def self.included(base)
    unloadable
    
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :notify_about?, :custom_field_notification
    end
  end
  
  module ClassMethods
  end
  
  module InstanceMethods
  end
  
  def notify_about_with_custom_field_notification?(object)
    notify = notify_about_without_custom_field_notification?(object)
    #if already notifying user, don't bother
    unless notify
      if mail_notification == 'all'
  
      elsif mail_notification.blank? || mail_notification == 'none'
  
      else
        case object
        when Issue
          notify |= object.notification_custom_users.include?(self)
        end
      end
    end
    
    return notify 
  end
  
end

User.send(:include, RedmineNotifyUserUserPatch)
