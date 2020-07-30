require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'Associations' do
    it { should belong_to(:reciever_user).class_name('User') }
    it { should belong_to(:requester_user).class_name('User') }
  end

  
  before(:all) do
    User.create(name: 'hasan', email: 'ozovalihasan@gmail.com', password: '123456')
    User.create(name: 'hillary', email: 'hillary@gmail.com', password: '123456')
  end

  it 'is valid with valid attributes' do
    expect(User.first.requested_friendship.new(reciever_user_id: User.second.id)).to be_valid
  end

  it 'is invalid when no attribute is defined' do
    expect(User.first.requested_friendship.new()).to_not be_valid
  end
end