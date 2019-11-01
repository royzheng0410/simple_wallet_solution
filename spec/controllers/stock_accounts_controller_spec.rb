require 'rails_helper'

describe StockAccountsController, :type => :controller do 
  render_views
  before do
    @stock_account1 = FactoryGirl.create :stock_account, stock_name: 'google'
    @stock_account2 = FactoryGirl.create :stock_account, stock_name: 'apple'
    @stock_account3 = FactoryGirl.create :stock_account, stock_name: 'facebook'
  end

  describe '#show' do
    it 'should list all user accounts' do
      get :index
      expect(assigns(:stock_accounts).count).to eq 3
      expect(response).to render_template 'index'
    end

    it 'should show a single user account' do
      get :show, params: {id: @stock_account2.id}
      expect(assigns(:stock_account).stock_name).to eq 'apple'
      expect(response).to render_template 'show'
    end
  end
end