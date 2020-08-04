require 'rails_helper'

RSpec.describe 'friendships_controller', type: :system do
  before :each do
    User.create(name: 'hillary', email: 'hillary@gmail.com', password: '123456', password_confirmation: '123456')
    User.create(name: 'hasan', email: 'hasan@gmail.com', password: '123456', password_confirmation: '123456')

  end

  it 'adds a friend' do
    do_login('hillary@gmail.com', '123456')
    send_friendship_request
    expect(page).to have_content 'Friends Request Sent'

  end

  it 'accepts friend request' do
    do_login('hillary@gmail.com', '123456')
    send_friendship_request
    do_logout
    do_login('hasan@gmail.com', '123456')
    accept_friendship_request
    expect(page).to have_content 'Your Friend'
  end

  it 'accepts friend request' do
    do_login('hillary@gmail.com', '123456')
    send_friendship_request
    do_logout
    do_login('hasan@gmail.com', '123456')
    reject_friendship_request
    expect(page).to have_button("Add friend")
  end

end