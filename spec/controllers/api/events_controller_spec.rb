require "rails_helper"

RSpec.describe Api::EventsController, type: :controller do
  let(:sport){ double(:sport, events: []) }
  let(:event){ double(:event, :update! => nil, :destroy => nil) }
  let(:policy){ double(:policy) }
  let(:user){ FactoryGirl.create(:admin) }

  before :each do
    allow(controller).to receive(:authenticate)
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:access_policy).and_return(policy)
    allow(controller).to receive(:sport).and_return(sport)
    allow(controller).to receive(:event).and_return(event)
  end

  describe "GET #index" do
    it "responds forbidden if the user is not allowed to read" do
      allow(policy).to receive(:can_read?).and_return(false)
      get :index, { sport_id: 1 }
      expect(response).to have_http_status(:forbidden)
    end

    it "responds with data if the user is allowed to read" do
      allow(policy).to receive(:can_read?).and_return(true)
      get :index, { sport_id: 1 }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "responds forbidden if the user has not rights to create events" do
      allow(policy).to receive(:can_create?).and_return(false)
      post :create, { sport_id: 1 }
      expect(response).to have_http_status(:forbidden)
    end

    it "responds bad_request if not all required params are sent" do
      allow(policy).to receive(:can_create?).and_return(true)
      post :create, { sport_id: 1 }
      expect(response).to have_http_status(:bad_request)
    end

    it "creates a event" do
      allow(policy).to receive(:can_create?).and_return(true)
      allow(controller).to receive(:create_event)
      post :create, { sport_id: 1, name: 'event_name' }
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do
    it "responds not_found if the resource doesn't exist" do
      allow(controller).to receive(:event).and_return(nil)
      allow(policy).to receive(:can_update?).and_return(false)
      put :update, { sport_id: 1, id: 1 }
      expect(response).to have_http_status(:not_found)
    end

    it "responds forbidden if the user has not rights to create events" do
      allow(policy).to receive(:can_update?).and_return(false)
      put :update, { sport_id: 1, id: 1 }
      expect(response).to have_http_status(:forbidden)
    end

    it "responds bad_request if not all required params are sent" do
      allow(policy).to receive(:can_update?).and_return(true)
      put :update, { sport_id: 1, id: 1 }
      expect(response).to have_http_status(:bad_request)
    end

    it "updates the event" do
      allow(policy).to receive(:can_update?).and_return(true)
      put :update, { sport_id: 1, id: 1, name: 'event_name' }
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    it "responds not_found if the resource doesn't exist" do
      allow(controller).to receive(:event).and_return(nil)
      allow(policy).to receive(:can_delete?).and_return(false)
      delete :destroy, sport_id: 1, id: 1
      expect(response).to have_http_status(:not_found)
    end

    it "responds forbidden if the user has not rights to create events" do
      allow(policy).to receive(:can_delete?).and_return(false)
      delete :destroy, sport_id: 1, id: 1
      expect(response).to have_http_status(:forbidden)
    end

    it "removes the event" do
      allow(policy).to receive(:can_delete?).and_return(true)
      delete :destroy, { sport_id: 1, id: 1, name: 'event_name' }
      expect(response).to have_http_status(:success)
    end
  end

end