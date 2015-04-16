module AuthenticationHelpers
  # For use in requests test
  # Logs in user by submitting a login request
  #
  # @param user [User] the user to log in as
  # @param password [String] password to use when logging in; defaults to 'a password'
  def login(user,password='a password')
    post user_session_path, 'user[email]' => user.email, 'user[password]' => password
  end
end