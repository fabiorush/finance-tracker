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

  def create
    friend = User.find(params[:friend_id])
    current_user.friends << friend
    flash[:notice] = "You have start following #{friend.full_name}"
    redirect_to friendships_path
  end

  def destroy
    friend = User.find(params[:id])
    Friendship.destroy_by(user_id: current_user.id, friend_id: params[:id])
    flash[:notice] = "You have stop following #{friend.full_name}"
    redirect_to friendships_path
  end
end
