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
    refund = @transaction_balance
    @transaction_balance = 0
    return refund
  end

  def sufficient_funds?(item)
    return transaction_balance >= item.price
  end

  def purchase(item)
    if !sufficient_funds?(item)
      return "Insufficient Funds"
    elsif !item.has_stock?
      return "Out of Stock"
    else
      @transaction_balance -= item.price
      @cash_balance += item.price
      item.reduce_stock_count(1)
      issue_refund
    end    
  end



end