require 'rails_helper'

# title { "Simple blog post title" }
# content { "Trying to learn TDD!" }

RSpec.describe "BlogPosts", type: :request do
  before(:all) do
    create(:blog_post)
  end
  
  describe "GET /index" do
    
    before(:each) do
      get "/posts"
    end

    it "should respond with 200 ok" do
      expect(response).to have_http_status(200)
    end

    it "should respond with json" do
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "should respond with included category" do
      expect(response.body).to include("General category")
    end

    it "should respond with factory content" do
      expect(response.body).to include("Trying to learn TDD!")
    end

  end
end
