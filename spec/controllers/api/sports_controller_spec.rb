require "rails_helper"

RSpec.describe Api::SportsController, type: :controller do
  let(:sport){ double(:sport, :update! => nil, :destroy => nil) }
  let(:policy){ double(:policy) }
  let(:user){ FactoryGirl.create(:admin) }

  before :each do
    allow(controller).to receive(:authenticate)
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:access_policy).and_return(policy)
    allow(controller).to receive(:sport).and_return(sport)
  end

  describe "GET #index" do
    it "responds forbidden if the user is not allowed to read" do
      allow(policy).to receive(:can_read?).and_return(false)
      get :index
      expect(response).to have_http_status(:forbidden)
    end

    it "responds with data if the user is allowed to read" do
      allow(policy).to receive(:can_read?).and_return(true)
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "responds forbidden if the user has not rights to create sports" do
      allow(policy).to receive(:can_create?).and_return(false)
      post :create
      expect(response).to have_http_status(:forbidden)
    end

    it "responds bad_request if not all required params are sent" do
      allow(policy).to receive(:can_create?).and_return(true)
      post :create
      expect(response).to have_http_status(:bad_request)
    end

    it "creates a sport" do
      allow(policy).to receive(:can_create?).and_return(true)
      post :create, { name: 'sport_name' }
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do
    it "responds not_found if the resource doesn't exist" do
      allow(controller).to receive(:sport).and_return(nil)
      allow(policy).to receive(:can_update?).and_return(false)
      put :update, id: 1
      expect(response).to have_http_status(:not_found)
    end

    it "responds forbidden if the user has not rights to create sports" do
      allow(policy).to receive(:can_update?).and_return(false)
      put :update, id: 1
      expect(response).to have_http_status(:forbidden)
    end

    it "responds bad_request if not all required params are sent" do
      allow(policy).to receive(:can_update?).and_return(true)
      put :update, id: 1
      expect(response).to have_http_status(:bad_request)
    end

    it "updates the sport" do
      allow(policy).to receive(:can_update?).and_return(true)
      put :update, { id: 1, name: 'sport_name' }
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    it "responds not_found if the resource doesn't exist" do
      allow(controller).to receive(:sport).and_return(nil)
      allow(policy).to receive(:can_delete?).and_return(false)
      delete :destroy, id: 1
      expect(response).to have_http_status(:not_found)
    end

    it "responds forbidden if the user has not rights to create sports" do
      allow(policy).to receive(:can_delete?).and_return(false)
      delete :destroy, id: 1
      expect(response).to have_http_status(:forbidden)
    end

    it "removes the sport" do
      allow(policy).to receive(:can_delete?).and_return(true)
      delete :destroy, { id: 1, name: 'sport_name' }
      expect(response).to have_http_status(:success)
    end
  end

end