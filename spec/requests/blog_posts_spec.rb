require 'rails_helper'

# fact_title = 'Simple blog post title'
fact_category = 'General category'
fact_content = 'Trying to learn TDD!'

RSpec.describe 'BlogPosts', type: :request do
  before(:all) do
    create(:blog_post)
  end

  describe 'GET /index' do
    before(:each) do
      get '/posts'
    end

    it 'should respond with 200 ok' do
      expect(response).to have_http_status(200)
    end

    it 'should respond with json' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'should respond with included category' do
      expect(response.body).to include(fact_category)
    end

    it 'should respond with factory content' do
      expect(response.body).to include(fact_content)
    end
  end

  describe 'GET /posts/:id' do
    context 'valid post id' do
      before(:each) do
        get '/posts/1'
      end

      it 'should respond with 200 ok' do
        expect(response).to have_http_status(200)
      end

      it 'should respond with json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'should respond with included category' do
        expect(response.body).to include(fact_category)
      end

      it 'should respond with factory content' do
        expect(response.body).to include(fact_content)
      end
    end

    context 'invalid post id' do
      before(:each) do
        get '/posts/2'
      end

      it 'should respond with 404 ok' do
        expect(response).to have_http_status(404)
      end

      it 'should respond with json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'should respond with an error' do
        expect(response.body).to include('Unable to find post')
      end
    end
  end

  describe 'POST /posts' do
    before(:all) do
      @post_count = BlogPost.count
      @new_user = create(:user, email: 'newuser@test.com', username: 'newbie')
      @category = create(:category, name: 'random')
    end

    context 'with token' do
      before(:each) do
        token = JwtService.encode(@new_user)
        post '/posts', headers: { Authorization: 'Bearer #{token}' },
                       params: { blog_post: { title: 'This is a post with token', content: 'A content of a post with token', category_id: @category.id } }
      end

      it 'should respond with 201 created' do
        expect(response).to have_http_status(201)
      end

      it 'should increase post count by 1' do
        expect(BlogPost.count).to be @post_count + 1
      end

      it 'should contain the post content' do
        expect(response.body).to include('This is a post with token')
        expect(response.body).to include('newbie')
      end
    end

    context 'without token' do
      before(:each) do
        post '/posts',
             params: { blog_post: { title: 'Without token post', content: 'Content without a token...',
                                    category_id: 1 } }
      end

      it 'should respond with 401 unauthorised' do
        expect(response).to have_http_status(401)
      end

      it 'should not increase post count by 1' do
        expect(BlogPost.count).to be @post_count
      end

      it 'should not contain any post content' do
        expect(response.body).to include('You must be logged in to do that')
      end
    end
  end
end
