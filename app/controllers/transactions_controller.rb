class TransactionsController < ApplicationController
  before_action :get_account, except: [:create]
  def index
    @transactions = @account.present? ? Transaction.for_account(@account).order('created_at desc') : Transaction.all.order('created_at desc')
    @pagied_transactions = @transactions.page(params[:page]).per(20)
  end

  def new
    unless @account.present?
      flash[:alert] = 'Invalid account'
      redirect_to root_path and return 
    end
    @transaction = Transaction.new(sender_id: @account.id)
  end

  def create
    @transaction = Transaction.new transaction_params
    begin
      Transaction.transaction do
        if @transaction.save
          flash[:notice] = 'Success'
          redirect_to transaction_path(@transaction, account_id: transaction_params[:sender_id])
        else
          @account = Account::Base.find_by_id transaction_params[:sender_id]
          render :new
        end
      end
    rescue => e
      logger.error e.message
      #could send an email to admin here
      flash[:error] = "Oops, something went wrong"
      redirect_to root_path
    end
  end

  def show
    @transaction = Transaction.find params[:id]
  end

  private

  def transaction_params
    params.require(:transaction).permit(:sender_id, :receiver_id, :amount, :transaction_type)
  end

  def get_account
    @account = Account::Base.find_by_id params[:account_id]
  end
end