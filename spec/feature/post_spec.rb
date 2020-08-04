require 'rails_helper'

RSpec.describe 'posts_controller', type: :system do
  before :each do
    User.create(name: 'hillary', email: 'hillary@gmail.com', password: '123456', password_confirmation: '123456')
  end

  it 'creates one post' do
    do_login('hillary@gmail.com', '123456')
    add_post('Hi')
    expect(page).to have_content 'Hi'
  end

end
