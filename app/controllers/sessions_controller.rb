class SessionsController < ApplicationController

  def new
    #debugger
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or @user
      # ログイン直後に、micropostを作成できる画面を表示。最終的にはこちらの方が良い
      # が、それまでのテストがパスしなくなる
      # redirect_to root_path
      else
        message = "Account not activated."
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out  if logged_in?
    redirect_to root_url
  end
end
