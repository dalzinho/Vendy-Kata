require 'minitest/autorun'
require 'minitest/rg'

require './Vendy.rb'
require './Coins.rb'
require './Items.rb'

class TestVendy < MiniTest::Test

  def setup
    @vendy = Vendy.new
    @coin = Coins.new
    @item = Items.new
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
    @vendy.insert(@coin.dollar)
    @vendy.purchase(@item.aero)
    assert_equal(35, @vendy.transaction_balance)
  end

  def test_purchaseAeroAddsSixtyFivePenceToCashBalance
    @vendy.insert(@coin.dollar)
    @vendy.purchase(@item.aero)
    assert_equal(65, @vendy.cash_balance)
  end
  
end