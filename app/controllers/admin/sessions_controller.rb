class Admin::SessionsController < Admin::Base
  skip_before_action :authorize

  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Staff::LoginForm.new(params[:admin_login_form])
    if @form.email.present?
      administrator = Administrator.find_by(email_for_index: @form.email.downcase)
    end
    if administrator
      if administrator.suspended?
        flash.now.alert = 'アカウントが停止されています'
        redirect_to action: 'new'
      else
        session[:administrator_id] = administrator.id
        flash.notice = 'ログインしました'
        redirect_to :admin_root
      end
    else
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません'
      redirect_to action: 'new'
    end
  end

  def destroy
    session(:administrator_id).destroy
    flash.notice = 'ログアウトしました'
    redirect_to :admin_root
  end
end
