class UsersController < ApplicationController
  def portifolio
    @stocks = current_user.stocks
  end
end
