class UserStocksController < ApplicationController

  def create
    stock = Stock.lookup(params[:ticket])
    stock.users << current_user
    stock.save
    flash[:notice] = "Stock #{stock.ticket} was successfully added to your portifolio"
    redirect_to portifolio_path
  end
end
