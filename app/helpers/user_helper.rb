module UserHelper
  def friends(user)
    friends = []
    Friendship.all.each do |request|
    	if request.status == true 
    		if request.requester_user_id == user.id
    			friends << User.find( request.reciever_user_id )
    		elsif request.reciever_user_id == user.id 
    			friends << User.find(request.requester_user_id)
    		end
    	end
    end
    friends
  end

  def pending_requests(user)
    pending_friend = []
    Friendship.all.each do |pending|
      if pending.status == nil
        if pending.reciever_user_id == user.id
          pending_friend << pending
        end
      end
    end
    pending_friend
  end

  def friend_requests(user)
    requests = []
    Friendship.all.each do |request|
      if request.status == nil
        if request.requester_user_id == user.id
          requests << request
        end
      end
    end
    requests
  end

  def accept_friend_request(friendship_request)
    friendship_request.update(status: true)     
  end

  def reject_friend_request(friendship_request)
    friendship_request.update(status: false)     
  end

  def friend?(user,user2)
    friends(user).include?(user2)
  end
end
