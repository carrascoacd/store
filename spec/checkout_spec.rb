require 'spec_helper'
require 'checkout'
require 'two_for_one'
require 'bulk_purchase'

RSpec.describe Checkout do

  before :each do
    two_for_one = TwoForOne.new
    two_for_one.register_product 'CN'
    bulk_purchase = BulkPurchase.new
    bulk_purchase.register_product 'PT'
    pricing_rules = [bulk_purchase, two_for_one]
    @checkout = Checkout.new pricing_rules
  end

  it "returns the correct total" do
    @checkout.scan 'CN'
    @checkout.scan 'PT'
    @checkout.scan 'VT'
    expect(@checkout.total).to eq 19.34
  end

  it "returns the correct total" do
    @checkout.scan 'CN'
    @checkout.scan 'PT'
    @checkout.scan 'CN'
    @checkout.scan 'CN'
    @checkout.scan 'VT'
    expect(@checkout.total).to eq 22.45
  end
  
  it "returns the correct total" do
    @checkout.scan 'CN'
    @checkout.scan 'CN'
    expect(@checkout.total).to eq 3.11
  end

  it "returns the correct total" do
    @checkout.scan 'PT'
    @checkout.scan 'PT'
    @checkout.scan 'VT'
    @checkout.scan 'PT'
    expect(@checkout.total).to eq 24.73
  end

  it "returns the correct total" do
    @checkout.scan 'PT'
    @checkout.scan 'PT'
    @checkout.scan 'PT'
    @checkout.scan 'PT'
    @checkout.scan 'PT'
    @checkout.scan 'PT'
    expect(@checkout.total).to eq 18.00
  end

  # it "throw an error when scanning a non valid product" do
  #   # @checkout.scan 'invalid_code'
  #   # expect{Object.non_existent_message}.to raise_error(NameError)
  # end

end