require 'rails_helper'

RSpec.describe 'comments_controller', type: :system do
  before :each do
    User.create(name: 'hillary', email: 'hillary@gmail.com', password: '123456', password_confirmation: '123456')
  end

  it 'creates one comment' do
    do_login('hillary@gmail.com', '123456')
    add_post('Hi')
    add_comment('Hi, too!')
    expect(page).to have_content 'Hi, too!'
  end
end
