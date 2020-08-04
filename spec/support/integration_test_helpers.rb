module IntegrationTestHelpers
  def do_signup(username, email, password)
    visit root_path
    click_link('Sign up')
    fill_in('Name', with: username)
    fill_in('Email', with: email)
    fill_in('Password', with: password)
    fill_in('Password confirmation', with: password)
    click_button('sign_up')
  end

  def do_login(email, password)
    visit root_path
    fill_in('Email', with: email)
    fill_in('Password', with: password)
    click_button('log_in')
  end


  def do_logout
    visit root_path
    click_link('Sign out')
  end

  def add_post(text)
    fill_in('post_content', with: text)
    click_button('save')
  end

  def like_post(href)
    click_link('Like!', href: href)
  end
  
  def dislike_post(href)
    click_link('Dislike!', href: href)
  end


end
