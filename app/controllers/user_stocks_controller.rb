class UserStocksController < ApplicationController

  def create
    stock = Stock.lookup(params[:ticket])
    stock.users << current_user
    stock.save
    flash[:notice] = "Stock #{stock.ticket} was successfully added to your portifolio"
    redirect_to portifolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    UserStock.destroy_by(user_id: current_user.id, stock_id: params[:id])
    flash[:notice] = "Stock #{stock.ticket} was successfully removed from your portifolio"
    redirect_to portifolio_path
  end
end
