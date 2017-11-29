class Admin::Base < ApplicationController
  before_action :authorize
  before_action :check_account


  private
  def current_administrator
    if session[:administrator_id]
      @current_administrator ||=
        Administrator.find_by(id: session[:administrator_id])
    end
  end

  helper_method :current_administrator

  def authorize
    unless current_administrator
      flash.alert = '管理者としてログインしてください'
      redirect_to :admin_login
    end
  end

  def check_account
    if current_administrator && !current_staff_member.active?
      session.delete(:administrator_id)
      flash.alert = 'アカウントが無効になりました'
      redirect_to :admin_root
  end
end
