module DeviseHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new.tap do |user|
      user.email = cookies[:signed_email]
      cookies.delete :signed_email
    end
  end

  def resource_class
    User
  end
end
