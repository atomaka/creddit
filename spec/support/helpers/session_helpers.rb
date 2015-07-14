module SessionHelpers
  def signin(**opts)
    if opts[:user]
      username = opts[:user].username
      password = opts[:user].password
    else
      username = opts[:username]
      password = opts[:password]
    end

    visit root_path

    if page.has_link? 'Sign In'
      click_link 'Sign In'

      fill_in :user_session_username, with: username
      fill_in :user_session_password, with: password

      click_button 'Create User session'
    end
  end

  def signout
    visit root_path
    click_link 'Sign Out' if page.has_link? 'Sign Out'
  end
end
