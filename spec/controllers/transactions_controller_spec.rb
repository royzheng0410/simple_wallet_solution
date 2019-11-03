require 'rails_helper'

describe TransactionsController, :type => :controller do 
  render_views
  before do
    @user_account1 = FactoryGirl.create :user_account, first_name: 'Tom', last_name: 'Cruise'
    @user_account2 = FactoryGirl.create :user_account, first_name: 'Brad', last_name: 'Pitt'
  end

  describe '#new' do
    it 'should render form' do
      get :new, params: {account_id: @user_account1.id}
      expect(assigns(:account).first_name).to eq 'Tom'
      expect(response).to render_template 'new'
    end

    it 'should update transaction count by 1 upon creation' do
      transaction = transaction_params
      expect{
        post :create, params: {transaction: transaction}
      }.to change(Transaction, :count).by(1)
      expect(response).to redirect_to transaction_path(assigns(:transaction), account_id: @user_account1.id)
    end

    it 'should process credit transaction' do
      transaction = transaction_params
      post :create, params: {transaction: transaction}
      @user_account1.reload
      @user_account2.reload
      expect(@user_account1.balance.to_i).to eq 90
      expect(@user_account2.balance.to_i).to eq 110
    end

    it 'should process debit transaction' do
      transaction = transaction_params
      transaction['transaction_type'] = Transaction::VALID_TYPE[:debit]
      post :create, params: {transaction: transaction}
      @user_account1.reload
      @user_account2.reload
      expect(@user_account1.balance.to_i).to eq 110
      expect(@user_account2.balance.to_i).to eq 90
    end

    it 'should render new page if validation fail' do
      transaction = transaction_params
      transaction['amount'] = 150
      expect{
        post :create, params: {transaction: transaction}
      }.to change(Transaction, :count).by(0)
      @user_account1.reload
      @user_account2.reload
      expect(@user_account1.balance.to_i).to eq 100
      expect(@user_account2.balance.to_i).to eq 100
      expect(response).to render_template 'new'
    end
  end

  describe '#display' do
    before do 
      @transaction1 = FactoryGirl.create :transaction, transaction_params
      @transaction2 = FactoryGirl.create :transaction, transaction_params
      @transaction3 = FactoryGirl.create :transaction, transaction_params
    end

    it 'should list all transactions' do
      get :index
      expect(assigns(:transactions).count).to eq 3
      expect(response).to render_template 'index'
    end

    it 'should list all transactions for an account' do
      @user_account3 = FactoryGirl.create :user_account, first_name: 'Brad', last_name: 'Pitt'
      transaction = transaction_params
      transaction['sender_id'] = @user_account2.id
      transaction['receiver_id'] = @user_account3.id
      @transaction4 = FactoryGirl.create :transaction, transaction
      get :index, params: {account_id: @user_account1.id}
      expect(assigns(:transactions).count).to eq 3
      expect(response).to render_template 'index'
    end

    it 'should show a single transaction' do
      get :show, params: {id: @transaction1.id}
      expect(assigns(:transaction).amount).to eq 10
      expect(response).to render_template 'show'
    end
  end

  def transaction_params
    transaction = FactoryGirl.attributes_for(:transaction)
    transaction['sender_id'] = @user_account1.id
    transaction['receiver_id'] = @user_account2.id
    transaction['amount'] = 10.0
    transaction['transaction_type'] = Transaction::VALID_TYPE[:credit]
    transaction
  end
end