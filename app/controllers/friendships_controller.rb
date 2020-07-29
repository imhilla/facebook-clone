class FriendshipsController < ApplicationController
  def new
  end

  def create
    @friend_request = current_user.frienship_requests.build(:requester_user_id => params[:requester_user_id])
  end

  def destroy
  end
end
