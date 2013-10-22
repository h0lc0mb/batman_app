class AddStripeToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :stripe_customer_token, :string
  end
end
