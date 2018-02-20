module UserHelper
  def money_transaction_css_class(amount)
    type = amount >= 0 ? "positive" : "negative"
    "money-transaction transaction-#{type}"
  end
end
