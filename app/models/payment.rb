class Payment < ApplicationRecord
  attr_accessor :card_number, :card_cvv, :card_expires_month, :card_expires_year

  belongs_to :user

  def self.month_options
    Date::MONTHNAMES.compact.each_with_index.map { |name, i| ["#{i + 1} - #{name}", i + 1] }
  end

  def self.year_options
    (Date.today.year..(Date.today.year + 10)).to_a
  end

  def process_payment
    customer = Stripe::Customer.create(email: email, card: token)

    starter_subcription = Stripe::Product.create(
      name: 'Photo app',
      description: 'Premium subscription'
    )

    Stripe::Price.create(
      currency: 'usd',
      unit_amount: 1000,
      recurring: { interval: 'month' },
      product: starter_subcription['id'],
      customer: customer.id
      # description: 'Premium',
    )
  end
end
