class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks
  validates :name, :ticket, presence: true

  def self.new_lookup(ticket_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:publishable_token],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
    new(ticket: ticket_symbol, name: client.company(ticket_symbol).company_name, last_price: client.price(ticket_symbol));
  end
end
