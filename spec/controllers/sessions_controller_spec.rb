require 'rails_helper'

# describe 'POST #create' do
#  context 'when email is valid' do
#    it 'sets the user in the session and redirects them to their dashboard' do
#      user = create(:user)
#
#            post :create, session: { email: user.email }
#
#            expect(response).to redirect_to '/dashboard'
#            expect(controller.current_user).to eq user
#    end
#  end
# end

# describe 'POST #create' do
#  context 'when password is invalid' do
#    it 'renders the page with error' do
#    end
#  end
# end

describe 'the signin process', type: :feature do
  describe 'when a user clicks log in' do
    it 'redirects the user from root to the /login url' do
      visit '/'
      first(:link, 'Log in').click
      expect(page.current_path).to eq '/login'
    end
  end
end

# describe 'when the user is not logged in and renders any page in the application' do
#  it 'redirects to the /login url' do
#    visit ''
#  end
# end
