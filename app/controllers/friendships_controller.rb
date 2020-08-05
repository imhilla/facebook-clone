class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def new; end

  def create
    User.find(params[:user_id]).send_friend_request(User.find(params[:friend_id]))
    redirect_to users_path
  end

  def edit
    Friendship.find(params[:id]).update(confirmed: true)
    user_id = Friendship.find(params[:id]).friend_id
    friend_id = Friendship.find(params[:id]).user_id
    Friendship.create(user_id: user_id, friend_id: friend_id, confirmed: true)
    redirect_to users_path
  end

  def destroy
    Friendship.find(params[:id]).destroy
    redirect_to users_path
  end
end
