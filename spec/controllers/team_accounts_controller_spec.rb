require 'rails_helper'

describe TeamAccountsController, :type => :controller do 
  render_views
  before do
    @team_account1 = FactoryGirl.create :team_account, team_name: 'accounting'
    @team_account2 = FactoryGirl.create :team_account, team_name: 'it'
    @team_account3 = FactoryGirl.create :team_account, team_name: 'human resource'
  end

  describe '#show' do
    it 'should list all user accounts' do
      get :index
      expect(assigns(:team_accounts).count).to eq 3
      expect(response).to render_template 'index'
    end

    it 'should show a single user account' do
      get :show, params: {id: @team_account2.id}
      expect(assigns(:team_account).team_name).to eq 'it'
      expect(response).to render_template 'show'
    end
  end
end