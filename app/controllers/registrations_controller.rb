class RegistrationsController < Devise::RegistrationsController
  def new
    @signup = Signup.new
    super
  end

  def create
    @signup = Signup.new(params[:signup])

    respond_to do |format|
      if @signup.save
        format.html do
          sign_in(:user, @signup.user)
          flash[:notice] = I18n.t('devise.registrations.signed_up')

          redriect_to(slugged_channel_url(@signup.channel.slug))
        end
      else
        format.html do
          flash[:error] = I18n.t('devise.registrations.failed')
          render(action: :new, status: 400)
        end
      end
    end
  end

  def update
    super
  end
end
