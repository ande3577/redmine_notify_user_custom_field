module RedmineNotifyUserCustomFields
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_custom_fields_form_upper_box, :partial => 'custom_fields/notify_user'
  end
end
