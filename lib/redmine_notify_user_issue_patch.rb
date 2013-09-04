module RedmineNotifyUserIssuePatch
  def self.included(base)
    unloadable
    
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :notified_users, :custom_field_notification
    end
  end
  
  module ClassMethods
  end
  
  module InstanceMethods
    def notification_custom_users
      values = self.custom_field_values.select { |f| f.custom_field.field_format == 'user' and f.custom_field.notify_user }.map{ |v| v.value }
      users = []
      values.each do |v|
        v = [ v ] unless v.is_a?(Array)
        v.each do |uid|
          user = User.where(:id => uid).first
          users << user if user
        end
      end
      users
    end
  end
  
  def notified_users_with_custom_field_notification
    notified = notified_users_without_custom_field_notification
    
    notified |= self.notification_custom_users.select {|u| u.active? && u.notify_about?(self)}
    
    notified.uniq!
    # Remove users that can not view the issue
    notified.reject! {|user| !visible?(user)}
    notified
  end
  
end

Issue.send(:include, RedmineNotifyUserIssuePatch)
