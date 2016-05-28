class RegistrationsController < Devise::RegistrationsController
  def new
    @signup = Signup.new
    super
  end

  def create
    @signup = Signup.new(signup_params)

    respond_to do |format|
      if @signup.save
        format.html do
          sign_in(:user, @signup.user)
          flash[:notice] = I18n.t('devise.registrations.signed_up')

          redirect_to(edit_channel_path(primary_channel))
        end
      else
        format.any do
          flash[:error] = I18n.t('devise.registrations.failed')
          render(action: :new, status: 400, format: :html)
        end
      end
    end
  end

  def signup_params
    params.fetch(:signup, {}).permit(:email, :password, :full_name, :channel_name)
  end

  def update
    super
  end
end
