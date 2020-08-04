module IntegrationTestHelpers
  def do_signup(username, email, password)
    visit root_path
    # click_link('Sign up')
    # fill_in('Name', with: username)
    # fill_in('Email', with: email)
    # fill_in('Password (6 characters minimum)', with: password)
    # fill_in('Password confirmation', with: password)
    # click_button('sign_up')
  end

  def do_login(email)
    visit root_path
    fill_in('Email', with: email)
    
    click_button('Log in')
  end

  def create_event(title)
    click_link('Create Event')
    fill_in('Title', with: title)
    page.find('#event_date').set('10-23-2020')
    fill_in('Description', with: 'Very good party')
    click_button('commit')
  end

  def invite(creator, invited_user, event)
    visit root_path
    click_link(creator.username)
    click_link(event)
    select invited_user.username, from: 'user_id'
  end
end
