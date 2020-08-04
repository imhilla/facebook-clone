require 'rails_helper'

RSpec.describe 'users_controller', type: :system do
  # before :each do
  #   User.create(username: 'hillary')
  # end

  it 'creates an event' do
    do_signup('hillary', 'hillary@gmail.com', '123456')
    expect(page).to have_content 'Sign in'
  end

  # it 'shows an event page' do
  #   do_login('hillary')
  #   create_event('Graduation Party')
  #   click_link('Graduation Party')
  #   expect(page).to have_content 'Created by'
  # end

  # it 'lists all events when you sign in' do
  #   do_login('hillary')
  #   expect(page).to have_content 'Upcoming Events'
  # end
end
