class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
  # rubocop:disable Layout/LineLength
  def send_friend_request(user)
    friendships.create(friend_id: user.id) unless Friendship.all.find_by(user_id: id, friend_id: user.id) || Friendship.all.find_by(user_id: user.id, friend_id: id)
  end
  # rubocop:enable Layout/LineLength

  def friends
    friends = []
    Friendship.all.each do |request|
      if request.confirmed == true
        if request.user_id == id
          friends << User.find(request.friend_id)
        elsif request.friend_id == id
          friends << User.find(request.user_id)
        end
      end
    end
    friends
  end

  def pending_requests
    pending_friend = []
    Friendship.all.each do |pending|
      next unless pending.confirmed == false

      pending_friend << pending if pending.friend_id == id
    end
    pending_friend
  end

  def friend_requests
    requests = []
    Friendship.all.each do |request|
      next unless request.confirmed == false

      requests << request if request.user_id == id
    end
    requests
  end

  def accept_friend_request(user)
    friendship_request = Friendship.find_by(user_id: user.id, friend_id: id, confirmed: false)
    friendship_request.update(confirmed: true)
  end

  def reject_friend_request(user)
    friendship_request = Friendship.find_by(user_id: user.id, friend_id: id, confirmed: false)
    friendship_request.destroy
  end

  def confirmed_friend_request
    requests = []
    Friendship.all.each do |request|
      next unless request.confirmed == true

      requests << request if request.friend_id == id
    end
    requests
  end

  def friend?(user)
    friends.include?(user)
  end
end
