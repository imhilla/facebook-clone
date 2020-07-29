class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :recieved_friendship, class_name: 'Frienship', foreign_key: 'reciever_user_id', inverse_of: :reciever_userz #inverse of friendship
  has_many :requested_friendship, class_name: 'Friendship', foreign_key: 'requester_user_id', inverse_of: :requester_user#friendship
end
