require 'rails_helper'

RSpec.describe 'users_controller', type: :system do
  before :each do
    User.create(name: 'hillary', email: 'hillary@gmail.com', password: '123456', password_confirmation: '123456')
  end

  it 'creates a user' do
    do_signup('hillary', 'hillary282@gmail.com', '123456')
    expect(page).to have_content 'Recent posts'
  end

  it 'logs in a user' do
    do_login('hillary@gmail.com', '123456')
    expect(page).to have_content 'Recent posts'
  end

  it 'shows an event page' do
    do_login('hillary')
    create_event('Graduation Party')
    click_link('Graduation Party')
    expect(page).to have_content 'Created by'
  end

  # it 'lists all events when you sign in' do
  #   do_login('hillary')
  #   expect(page).to have_content 'Upcoming Events'
  # end
end
