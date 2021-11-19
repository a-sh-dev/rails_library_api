require 'rails_helper'

user1 = 'user1'
user_email = 'user1@email.com'
user_password = 'password'

RSpec.describe 'Auths', type: :request do
  describe 'POST /auth/login' do
    before(:all) do
      @user = create(:user)
    end

    context 'with correct credentials' do
      before(:each) do
        post '/auth/login', params: { auth: { login: user_email, password: user_password } }
      end

      it 'should return 200 ok' do
        expect(response).to have_http_status(200)
      end

      it 'should include a jwt and username' do
        expect(response.body).to include('jwt')
        expect(response.body).to include(user1)
      end
    end

    context 'with incorrect credentials' do
      before(:each) do
        post '/auth/login', params: { auth: { login: user_email, password: 'wrongpassword' } }
      end

      it 'should return 422 unprocessable' do
        expect(response).to have_http_status(422)
      end

      it 'should include an error message' do
        expect(response.body).to include('Incorrect email or password')
      end
    end
  end

  describe 'POST /auth/register' do
    context 'with valid details' do
      before(:all) do
        @user_count = User.count
      end

      before(:each) do
        post '/auth/register',
             params: { auth: { email: 'test1@testing.com', password: 'password', username: 'NewUser',
                               password_confirmation: 'password' } }
      end

      it 'should return 201 created' do
        expect(response).to have_http_status(201)
      end

      it 'should include a jwt and username' do
        expect(response.body).to include('jwt')
        expect(response.body).to include('NewUser')
      end

      it 'should increase user count' do
        expect(User.count).to eq(@user_count + 1)
      end
    end
  end
end
