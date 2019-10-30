class HomeController < ApplicationController
  def index
    @user_accounts = Account::User.order('created_at desc').first(3)
    @team_accounts = Account::Team.order('created_at desc').first(3)
    @stock_accounts = Account::Stock.order('created_at desc').first(3)
  end
end