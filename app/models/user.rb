class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
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

  def full_name
    if first_name and last_name
      "#{first_name} #{last_name}"
    else
      "John Doe"
    end
  end
end
