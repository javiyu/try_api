require "rails_helper"

class AuthenticatedController < Api::ApiController
  def index
    render text: 'response'
  end
end

Rails.application.routes.draw do
  resources :authenticated
end


RSpec.describe AuthenticatedController, type: :controller do
  context "For a controller that inherits from ApiController" do
    describe "GET #index" do
      it "responds unauthorized if no authentication headers are set" do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end

      it "responds unauthorized if authentication headers are not correct" do
        set_auth_header('wrong', 'credentials')
        get :index
        expect(response).to have_http_status(:unauthorized)
      end

      it "responds success for a valid user" do
        user = FactoryGirl.create(:admin)
        set_auth_header(user.name, user.password)

        get :index
        expect(response).to have_http_status(:success)
      end
    end

  end
end