require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'Associations' do
    it { should belong_to(:friend).class_name('User') }
    it { should belong_to(:user).class_name('User') }
  end

  before(:all) do
    User.create(name: 'hasan', email: 'ozovalihasan@gmail.com', password: '123456')
    User.create(name: 'hillary', email: 'hillary@gmail.com', password: '123456')
  end

  it 'is valid with valid attributes' do
    expect(User.first.friendships.new(friend_id: User.second.id)).to be_valid
  end

  it 'is invalid when no attribute is defined' do
    expect(User.first.friendships.new).to_not be_valid
  end
end
