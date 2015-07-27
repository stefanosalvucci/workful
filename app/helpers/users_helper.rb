module UsersHelper
  def avatar(user, custom_css = '')
    # if user.avatar?
    #  image_tag user.avatar
    # else
    # default_url = "#{root_url}images/guest.png"
    return image_tag('http://fellowship.ycombinator.com/images/ycombinator-logo-fb889e2e.png', :style => "width: 19px;
    margin: 0 6px 2px 0;") if user.email == 'hello@ycombinator.com'

    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    image_tag "http://gravatar.com/avatar/#{gravatar_id}.png?s=23&d=identicon", class: custom_css
    # end
  end
end
