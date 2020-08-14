require 'rails_helper'

RSpec.describe 'likes_controller', type: :system do
  before :each do
    User.create(name: 'hillary', email: 'hillary@gmail.com', password: '123456', password_confirmation: '123456')
  end

  it 'likes one post' do
    do_login('hillary@gmail.com', '123456')
    add_post('Hi')
    like_post('/posts/1/likes')
    expect(page).to have_content '1 Like'
    expect(page).to have_content 'Dislike!'
  end

  it 'dislikes one post' do
    do_login('hillary@gmail.com', '123456')
    add_post('Hi')
    like_post('/posts/1/likes')
    dislike_post('/posts/1/likes/1')
    expect(page).to have_content 'Like!'
  end
end
