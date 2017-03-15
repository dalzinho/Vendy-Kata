class Vendy

  attr_reader :transaction_balance, :cash_balance

  def initialize
    @transaction_balance = 0
    @cash_balance = 0
  end

  def insert(coin_value)
    @transaction_balance += coin_value
  end

  def issue_refund
    @transaction_balance = 0
  end

  def purchase(item_value)
    @transaction_balance -= item_value
    @cash_balance += item_value
  end

end