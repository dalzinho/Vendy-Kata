class Items

  attr_reader :price, :stock_count
  
  def initialize(price)
    @price = price
    @stock_count = 10
  end

  def reduce_stock_count(quantity)
    @stock_count -= quantity
  end

  def has_stock?
    return @stock_count > 0
  end

  def replenish
    @stock_count = 10
  end

end