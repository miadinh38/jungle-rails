require 'rails_helper'

RSpec.describe Product, type: :model do
  before (:each) do
    @category = Category.create(name: 'Example Category')
  end 
  
  describe 'Validations' do
    it 'saves a product with all fields set' do
      @product = Product.new(name:'Example Product', price_cents: 1000, quantity: 10, category: @category)
      @product.save
      expect(@product).to be_present
    end 
    
    it 'validates the presence of name' do
      @product = Product.new(name:nil, price_cents: 1000, quantity: 10, category: @category)
      @product.valid?
      expect(@product.errors.full_messages_for(:name)).to include("Name can't be blank")
    end

    it 'validates the presence of price' do
      @product = Product.new(name:'Example Name', price_cents: nil, quantity: 10, category: @category)
      @product.valid?
      expect(@product.errors.full_messages_for(:price)).to include("Price can't be blank")
    end

    it 'validates the presence of quantity' do
      @product = Product.new(name:'Example Name', price_cents: 2000, quantity: nil, category: @category)
      @product.valid?
      expect(@product.errors.full_messages_for(:quantity)).to include("Quantity can't be blank")
    end

    it 'validates the presence of category' do
      @product = Product.new(name:'Example Name', price_cents: 2000, quantity: 50, category: nil)
      @product.valid?
      expect(@product.errors.full_messages_for(:category)).to include("Category can't be blank")
    end
  end
end