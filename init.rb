require_dependency 'redmine_notify_user_custom_field_patch'
require_dependency 'redmine_notify_user_custom_field_hooks'


Redmine::Plugin.register :redmine_notify_user_custom_field do
  
  project_module :notify_user_custom_field do
  end
  
  name 'Redmine Notify Users Custom Field plugin'
  author 'David S Anderson'
  description 'A plugin that adds email notification to users mentioned in a custom field'
  version '0.0.1'
  url 'https://github.com/ande3577/redmine_notify_user_custom_field_patch'
  author_url 'https://github.com/ande3577/'
end
