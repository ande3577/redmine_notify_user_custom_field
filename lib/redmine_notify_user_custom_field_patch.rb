module RedmineNotifyUserCustomFieldPatch
  def self.included(base)
    unloadable
    
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
    end
  end
  
  module ClassMethods
  end
  
  module InstanceMethods
    def notify_user?
      return self.notify_user
    end
  end
  
end

CustomField.send(:include, RedmineNotifyUserCustomFieldPatch)
