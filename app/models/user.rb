class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :recieved_friendship, class_name: 'Friendship', foreign_key: 'reciever_user_id'
  has_many :recieved_friendship, inverse_of: :reciever_user, dependent: :destroy
  has_many :requested_friendship, class_name: 'Friendship', foreign_key: 'requester_user_id'
  has_many :requested_friendship, inverse_of: :requester_user, dependent: :destroy

  def friends
    friends = []
    Friendship.all.each do |request|
      if request.status == true
        if request.requester_user_id == id
          friends << User.find(request.reciever_user_id)
        elsif request.reciever_user_id == id
          friends << User.find(request.requester_user_id)
        end
      end
    end
    friends
  end

  def pending_requests
    pending_friend = []
    Friendship.all.each do |pending|
      next unless pending.status.nil?

      pending_friend << pending if pending.reciever_user_id == id
    end
    pending_friend
  end

  def friend_requests
    requests = []
    Friendship.all.each do |request|
      next unless request.status.nil?

      requests << request if request.requester_user_id == id
    end
    requests
  end

  def accept_friend_request(user)
    friendship_request = Friendship.find_by(requester_user_id: user.id, reciever_user_id: id, status: nil)
    friendship_request.update(status: true)
  end

  def reject_friend_request(user)
    friendship_request = Friendship.find_by(requester_user_id: user.id, reciever_user_id: id, status: nil)
    friendship_request.update(status: false)
  end

  def confirmed_friend_request
    requests = []
    Friendship.all.each do |request|
      next unless request.status == true

      requests << request if request.reciever_user_id == id
    end
    requests
  end

  def friend?(user)
    friends.include?(user)
  end
end
