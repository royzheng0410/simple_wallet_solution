class UserAccountsController < ApplicationController
  def index
    @user_accounts = Account::User.order('created_at desc').all
  end

  def show
    @user_account = Account::User.find params[:id]
  end
end