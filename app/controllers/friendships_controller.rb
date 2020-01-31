class FriendshipsController < ApplicationController
  def search
    if params[:name_email].present?
      @users = User.search(params[:name_email]).reject { |user| user.id == current_user.id }
      respond_to do |f|
        if @users.empty?
          flash.now[:alert] = "friend not found"
        end
        f.js { render partial: 'friendships/result' }
      end
    else
      respond_to do |f|
        flash.now[:alert] = "Please enter a friend name or email to search"
        f.js { render partial: 'friendships/result' }
      end
    end
  end

  def index
    @friends = current_user.friends
  end
end
