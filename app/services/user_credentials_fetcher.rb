class UserCredentialsFetcher
  include HTTParty

  def initialize(code)
    @code = code
  end

  def call
    @user = { 'first_name' => first_name, 'last_name' => last_name, 'email' => email, 'organisation' => organisation }
  end

  def first_name
    @_first_name ||= user_info['user']['first_name']
  end

  def last_name
    @_last_name ||= user_info['user']['last_name']
  end

  def email
    @_email ||= user_info['user']['email']
  end

  def organisation
    @_organisation ||= user_info['accounts'][0]['name']
  end
end
