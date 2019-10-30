class StockAccountsController < ApplicationController
  def index
    @stock_accounts = Account::Stock.order('created_at desc').all
  end

  def show
    @stock_account = Account::Stock.find params[:id]
  end
end