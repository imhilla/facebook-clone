class Friendship < ApplicationRecord
  belongs_to :reciever_user, class_name: 'User'
  belongs_to :requester_user, class_name: 'User'
end
