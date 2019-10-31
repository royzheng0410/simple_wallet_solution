require 'rails_helper'

describe UserAccountsController, :type => :controller do 
  render_views
  before do
    @user_account1 = FactoryGirl.create :user_account, first_name: 'Tom', last_name: 'Cruise'
    @user_account2 = FactoryGirl.create :user_account, first_name: 'Brad', last_name: 'Pitt'
    @user_account3 = FactoryGirl.create :user_account, first_name: 'Orlando', last_name: 'Bloom'
  end

  describe '#show' do
    it 'should list all user accounts' do
      get :index
      expect(assigns(:user_accounts).count).to eq 3
      expect(response).to render_template 'index'
    end

    it 'should show a single user account' do
      get :show, params: {id: @user_account2.id}
      expect(assigns(:user_account).first_name).to eq 'Brad'
      expect(response).to render_template 'show'
    end
  end
end