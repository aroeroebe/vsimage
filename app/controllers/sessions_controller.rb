class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to @user
      #remember_meにチェックが入って入れば記憶トークン等を登録、チェックが無ければ記憶トークン等を削除
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)

    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
  
  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
