require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:recieved_friendship).class_name('Friendship').with_foreign_key('reciever_user_id').inverse_of(:reciever_user).dependent(:destroy)}
    it { should have_many(:requested_friendship).class_name('Friendship').with_foreign_key('requester_user_id').inverse_of(:requester_user).dependent(:destroy)}
  end

  before(:all) do
    User.create(name: 'hasan', email: 'ozovalihasan@gmail.com', password: '123456')
    User.create(name: 'hillary', email: 'hillary@gmail.com', password: '123456')
    User.first.requested_friendship.create(reciever_user_id: User.second.id)
  end

  describe 'accept_friend_request method' do
    it 'is expected to accept friend request' do
      User.second.accept_friend_request(User.first)
      expect(Friendship.first.status).to be_eql true
    end
  end

  describe 'reject_friend_request method' do
    it 'is expected to reject friend request' do
      User.second.reject_friend_request(User.first)
      expect(Friendship.first.status).to be_eql false
    end
  end

  describe 'confirmed_friend_request method' do
    it 'is expected to give list of friendship confirmed by user' do
      User.second.accept_friend_request(User.first)
      expect(User.second.confirmed_friend_request[0].reciever_user_id).to be_eql (2)
    end
  end
  
  describe 'pending_requests method' do
    it 'is expected to give list of user\'s pending friendship ' do
      expect(User.second.pending_requests[0].reciever_user_id).to be_eql (2)
      expect(User.second.pending_requests[0].status).to be_eql (nil)
    end
  end

  describe 'friend_requests method' do
    it 'is expected to give list of friendship sent by user' do
      expect(User.first.friend_requests[0].requester_user_id).to be_eql (1)
      expect(User.first.friend_requests[0].status).to be_eql (nil)
    end
  end
  
  describe 'friends method' do
    it 'is expected to give list of user\'s friends' do
      User.second.accept_friend_request(User.first)
      expect(User.first.friends[0].name).to be_eql ('hillary')
      expect(User.second.friends[0].name).to be_eql ('hasan')
    end
  end


  describe 'friend?(user)' do
    it 'return true if friendship request is accepted' do
      User.second.accept_friend_request(User.first)
      expect(User.first.friend?(User.second)).to be_eql (true)
    end

    it 'return false if friendship request is rejected' do
      User.second.reject_friend_request(User.first)
      expect(User.first.friend?(User.second)).to be_eql (false)
    end
  end
end
