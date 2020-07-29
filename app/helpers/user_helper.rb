module UserHelper
  def friends(user)
    friend = []
    Friendship.all.each do |request|
    	if request.status == true 
    		if request.requester_user_id == user.id
    			friend << User.find( request.reciever_user_id )
    		else request.reciever_user_id == user.id 
    			friend << User.find(request.requester_user_id)
    		end
    	end
    end
    friend
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

  def accept_friend_request(user)
     
  end

  def reject_friend_request
  end

 

  def approved_requests
  end
end
