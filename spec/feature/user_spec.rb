require 'rails_helper'

RSpec.describe 'users_controller', type: :system do
  before :each do
    User.create(name: 'hillary', email: 'hillary@gmail.com', password: '123456', password_confirmation: '123456')
  end

  it 'signs up  a user' do
    do_signup('hillary', 'hillary282@gmail.com', '123456')
    expect(page).to have_content 'Recent posts'
  end

  it 'logs in a user' do
    do_login('hillary@gmail.com', '123456')
    expect(page).to have_content 'Recent posts'
  end

  it 'logs out a user' do
    do_login('hillary@gmail.com', '123456')
    do_logout
    expect(page).to have_content 'Sign in'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
  end

end
