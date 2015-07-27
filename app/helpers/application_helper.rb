module ApplicationHelper
  def body_class
    class_name = []
    class_name << "#{ controller_name }-#{ controller.action_name }"
    # class_name << 'mobile' if mobile_device?

    class_name << content_for(:body_class) if content_for?(:body_class)

    class_name.join(' ')
  end

  def display_next_month
    (Date.today + 1.month).strftime("%b %Y")
  end

  def display_full_next_month
    (Date.today + 1.month).strftime("%B")
  end

  def custom_dashboard_path
    return '/yc_fellowship' if current_user.email == 'hello@ycombinator.com'
    dashboard_path
  end

end
