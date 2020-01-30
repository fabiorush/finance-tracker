class StocksController < ApplicationController
  def search
    if params[:stock].present?
      begin
        @stock = Stock.new_lookup(params[:stock])
        respond_to do |f|
          f.js { render partial: 'users/result' }
        end
      rescue => exception
        respond_to do |f|
          flash.now[:alert] = "Plese enter a valid symbol to search"
          f.js { render partial: 'users/result' }
        end
      end
    else
      respond_to do |f|
        flash.now[:alert] = "Plese enter a symbol to search"
        f.js { render partial: 'users/result' }
      end
    end
  end
end
