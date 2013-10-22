class Contribution < ActiveRecord::Base
  attr_accessible :amount, :stripe_card_token, :user_id
  belongs_to :user

  validates :user_id, presence: true
  PROPER_DECIMAL_REGEX = /^\d+??(?:\.\d{0,2})?$/
  validates :amount, presence: true, format: { with: PROPER_DECIMAL_REGEX, message: "please enter a valid decimal amount" }, 
  																	 numericality: { greater_than: 0, less_than: 10000 }

  attr_accessor :stripe_card_token

  def save_with_payment
  	if valid?
  		customer = Stripe::Customer.create(description: user_id, 
                                         #email: @email,
                                         card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!

      charge = Stripe::Charge.create(amount: (amount * 100).to_i,
                                     currency: "usd",
                                     customer: stripe_customer_token)
  	end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end