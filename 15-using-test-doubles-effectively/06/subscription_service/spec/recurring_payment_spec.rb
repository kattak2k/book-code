require 'recurring_payment'

Card = Struct.new(:type, :number)
Subscription = Struct.new(:name, :credit_card, :amount)

RSpec.describe RecurringPayment do
  it 'charges the credit card for each subscription' do
    card_1 = Card.new(:visa, '1234 5678 9012 3456')
    card_2 = Card.new(:mastercard, '9876 5432 1098 7654')

    subscriptions = [
      Subscription.new('John Doe', card_1, 19.99),
      Subscription.new('Jane Doe', card_2, 29.99)
    ]

    expect(CashCow).to receive(:charge_card).with(card_1, 19.99, :excess_arg)
    expect(CashCow).to receive(:charge_card).with(card_2, 29.99, :excess_arg)

    RecurringPayment.process_subscriptions(subscriptions)
  end
end
