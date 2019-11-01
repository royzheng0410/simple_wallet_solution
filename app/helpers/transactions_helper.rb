module TransactionsHelper
  def index_title
    title = "Transaction History"
    if @account.present?
      title += " (#{@account.account_number})" 
    end
    title.html_safe
  end

  def transaction_count
    "Total record: #{@transactions.count}".html_safe if @transactions.present?
  end

  def back_path
    html = ""
    if @account.present?
      case @account.type
      when "Account::User"
        html += link_to 'Back', user_account_path(@account), class: 'btn btn-primary'
      when "Account::Team"
        html += link_to 'Back', team_account_path(@account), class: 'btn btn-primary'
      when "Account::Stock"
        html += link_to 'Back', stock_account_path(@account), class: 'btn btn-primary'
      end
    end
    return html.html_safe
  end
end