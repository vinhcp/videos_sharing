class CustomFailure < Devise::FailureApp
  def redirect_url
    # new_user_session_url(:subdomain => 'secure')
    root_path
  end

  # You need to override respond to eliminate recall
  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end
