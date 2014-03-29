class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :check_login
  rescue_from CanCan::AccessDenied do |exception|
    render status: 403, text: '您没有权限访问这个页面'
  end

  private

  #建议改为 current_account 不会那么容易混淆
  def current_user
    session[:account]
  end

  def check_login
    redirect_to(controller: :login, action: :index) if current_user.nil?
  end
end
