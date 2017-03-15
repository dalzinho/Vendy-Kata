require 'minitest/autorun'
require 'minitest/rg'

require './Vendy.rb'
require './Coins.rb'
require './Items.rb'

class TestVendy < MiniTest::Test

  def setup
    @vendy = Vendy.new
    @coin = Coins.new
    @aero = Items.new(65)
    @bourneville = Items.new(100)
    @caramac = Items.new(150)
  end

  def test_vendyInitialisesWithZeroBalance
    assert_equal(0, @vendy.transaction_balance)
  end

  def test_insertDimeChangesBalanceToTen
    @vendy.insert(@coin.dime)
    assert_equal(10, @vendy.transaction_balance)
  end

  def test_insertNickelAndDimeChangeBalanceToFifteen
    @vendy.insert(@coin.dime)
    @vendy.insert(@coin.nickel)
    assert_equal(15, @vendy.transaction_balance)
  end

  def test_refundResetsTransactionBalanceToZero
    @vendy.insert(@coin.quarter)
    @vendy.insert(@coin.dollar)
    @vendy.issue_refund
    assert_equal(0, @vendy.transaction_balance)
  end

  def test_purchaseAeroDeductsSixtyFiveFromTransactionBalance
    @vendy.insert(@coin.quarter)
    @vendy.insert(@coin.quarter)
    @vendy.insert(@coin.dime)
    @vendy.insert(@coin.nickel)

    @vendy.purchase(@aero)
    assert_equal(0, @vendy.transaction_balance)
  end

  def test_purchaseAeroAddsSixtyFivePenceToCashBalance
    @vendy.insert(@coin.dollar)
    @vendy.purchase(@aero)
    assert_equal(65, @vendy.cash_balance)
  end

  def test_purchaseReturnsChangeAndResetsTransactionBalanceToZero
    @vendy.insert(@coin.dollar)
    assert_equal(35, @vendy.purchase(@aero))
    assert_equal(0, @vendy.transaction_balance)
  end

  def test_purchaseAeroReducesStockByOne
    @vendy.insert(@coin.dollar)
    @vendy.purchase(@aero)
    assert_equal(9, @aero.stock_count)
  end

  def test_cannotPurchaseIfInsufficientFunds
    @vendy.purchase(@aero)
    assert_equal(10, @aero.stock_count)
  end

  def test_cannotPurchaseIfNoStock
    @vendy.insert(@coin.dollar)
    @aero.reduce_stock_count(10)

    assert_equal("Out of Stock", @vendy.purchase(@aero))
  end

  def test_canReplenishStock
    @vendy.insert(@coin.dollar)
    @vendy.purchase(@aero)
    @aero.replenish
    assert_equal(10, @aero.stock_count)
  end
  
end