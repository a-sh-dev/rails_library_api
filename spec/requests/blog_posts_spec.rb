require 'rails_helper'

fact_category = "General category"
fact_title = "Simple blog post title"
fact_content = "Trying to learn TDD!"

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
      expect(response.body).to include(fact_category)
    end

    it "should respond with factory content" do
      expect(response.body).to include(fact_content)
    end
  end

  describe "GET /posts/:id" do
    context "valid post id" do
      before(:each) do
        get "/posts/1"
      end

      it "should respond with 200 ok" do
        expect(response).to have_http_status(200)
      end

      it "should respond with json" do
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end

      it "should respond with included category" do
        expect(response.body).to include(fact_category)
      end

      it "should respond with factory content" do
        expect(response.body).to include(fact_content)
      end

    end

    context "invalid post id" do
      before(:each) do
        get "posts/2"
      end

      it "should respond with 404 ok" do
        expect(response).to have_http_status(404)
      end

      it "should respond with json" do
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end

      it "should respond with an error" do
        expect(response.body).to include("Unable to find post")
      end

    end
  end

end
