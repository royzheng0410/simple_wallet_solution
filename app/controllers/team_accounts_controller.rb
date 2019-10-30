class TeamAccountsController < ApplicationController
  def index
    @team_accounts = Account::Team.order('created_at desc').all
  end

  def show
    @team_account = Account::Team.find params[:id]
  end
end