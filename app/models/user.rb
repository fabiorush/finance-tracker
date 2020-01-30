class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def not_tracking_stock?(ticket)
    stocks.find_by(ticket: ticket).nil?
  end

  def stock_under_limit?
    stocks.count < 10
  end

  def can_track_stock?(ticket)
    stock_under_limit? && not_tracking_stock?(ticket)
  end
end
