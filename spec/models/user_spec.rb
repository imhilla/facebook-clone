require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:recieved_friendship).class_name('Friendship').with_foreign_key('reciever_user_id').inverse_of(:reciever_user)}
    it { should have_many(:requested_friendship).class_name('Friendship').with_foreign_key('requester_user_id').inverse_of(:requester_user)}
  end

end
