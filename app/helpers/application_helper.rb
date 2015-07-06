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
end
