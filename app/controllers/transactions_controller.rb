class TransactionsController < ApplicationController
  def index
    @account = Account::Base.find_by_id params[:account_id]
    @transactions = @account.present? ? Transaction.for_account(@account).order('created_at desc') : Transaction.all.order('created_at desc')
    @pagied_transactions = @transactions.page(params[:page]).per(20)
  end

  def new
    @sender = Account::Base.find_by_id params[:sender_id]
    unless @sender.present?
      flash[:alert] = 'Invalid account'
      redirect_to root_path and return 
    end
    @transaction = Transaction.new(sender_id: @sender.id)
  end

  def create
    @transaction = Transaction.new transaction_params
    begin
      Transaction.transaction do
        if @transaction.save
          flash[:notice] = 'Success'
          redirect_to transaction_path(@transaction, account_id: transaction_params[:sender_id])
        else
          @sender = Account::Base.find_by_id transaction_params[:sender_id]
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
    @account = Account::Base.find_by_id params[:account_id]
    @transaction = Transaction.find params[:id]
  end

  private

  def transaction_params
    params.require(:transaction).permit(:sender_id, :receiver_id, :amount, :transaction_type)
  end
end