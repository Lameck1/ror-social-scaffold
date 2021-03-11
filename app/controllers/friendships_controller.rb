class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friendship, only: %i[create destroy]

  def create
    if @friendship.nil?
      @friend_request = current_user.friendships.build(user_id: current_user.id, friend_id: params[:id],
                                                       state: Friendship::REQUEST)
      if @friend_request.save
        flash[:notice] = 'Friend Request Sent!'
      else
        flash[:alert] = 'Something Went Wrong!'
      end
    else
      flash[:notice] = 'Sorry! you already have a pending friend request with this user!'
    end
    redirect_to users_path
  end

  def update
    @friend_request = Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
    @friend_request.confirm_friend
    redirect_to users_path
  rescue StandardError
    flash[:alert] = 'Something Went Wrong!'
    redirect_to users_path
  end

  def destroy
    @friendship.unfriend
    flash[:notice] = 'Friend removed!'
    redirect_to users_path
  rescue StandardError
    redirect_to users_path
  end

  private

  def set_friendship
    @friendship = Friendship.find_by(user_id: params[:id], friend_id: current_user.id) ||
                  Friendship.find_by(user_id: current_user.id, friend_id: params[:id])
  end
end
