module Auth
  class SessionsController < Devise::SessionsController
    # before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    def create
      resource = resource_class.find_by(email: sign_in_params[:email])
      if resource.present?
        set_cookies
        self.resource = warden.authenticate!(auth_options)
        authenticate(resource, :signed_in)
      else
        register(sign_in_params)
      end
    end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end

    def build_resource(hash = {})
      self.resource = resource_class.new_with_session(hash, session)
    end

    def register(sign_up_params)
      build_resource(sign_up_params)
      set_cookies
      resource.save
      yield resource if block_given?
      if resource.persisted?
        authenticate(resource, :signed_up)
      else
        render_validation_errors
      end
    end

    def set_cookies
      cookies[:signed_email] = sign_in_params[:email]
    end

    def cleanup_cookies
      cookies.delete :signed_email
    end

    def render_validation_errors
      flash[:error] = resource.errors.full_messages.first
      clean_up_passwords resource
      set_minimum_password_length
      redirect_to root_path
    end

    def authenticate(resource, kind)
      set_flash_message! :notice, kind
      sign_in(resource_name, resource)
      cleanup_cookies
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end
end
