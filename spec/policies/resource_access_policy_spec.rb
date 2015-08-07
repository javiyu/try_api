require "rails_helper"

RSpec.describe ResourceAccessPolicy do
  let!(:admin){ FactoryGirl.create(:admin) }
  let!(:user){ FactoryGirl.create(:user) }
  let!(:guest){ FactoryGirl.create(:guest) }
  let(:sport){ double(:sport) }

  context "for an admin" do
    let(:policy){ described_class.new(resource: sport, user: admin) }

    describe "can_read?" do
      it "should return true" do
        expect(policy.can_read?).to eq(true)
      end
    end

    describe "can_create?" do
      it "should return true" do
        expect(policy.can_create?).to eq(true)
      end
    end

    describe "can_update?" do
      it "should return true" do
        expect(policy.can_update?).to eq(true)
      end
    end

    describe "can_delete?" do
      it "should return true" do
        expect(policy.can_delete?).to eq(true)
      end
    end
  end

  context "for an user" do
    let(:policy){ described_class.new(resource: sport, user: user) }

    describe "can_read?" do
      it "should return true" do
        expect(policy.can_read?).to eq(true)
      end
    end

    describe "can_create?" do
      it "should return true" do
        expect(policy.can_create?).to eq(true)
      end
    end

    describe "can_update?" do
      it "should return true if he owns the resource" do
        allow(policy).to receive(:resource_owned_by_user?).and_return(true)
        expect(policy.can_update?).to eq(true)
      end

      it "should return false if he doesn't own the resource" do
        allow(policy).to receive(:resource_owned_by_user?).and_return(false)
        expect(policy.can_update?).to eq(false)
      end
    end

    describe "can_delete?" do
      it "should return true if he owns the resource" do
        allow(policy).to receive(:resource_owned_by_user?).and_return(true)
        expect(policy.can_delete?).to eq(true)
      end

      it "should return false if he doesn't own the resource" do
        allow(policy).to receive(:resource_owned_by_user?).and_return(false)
        expect(policy.can_delete?).to eq(false)
      end
    end
  end

  context "for a guest" do
    let(:policy){ described_class.new(resource: sport, user: guest) }

    before :each do
      allow(policy).to receive(:resource_owned_by_user?).and_return(true)
    end

    describe "can_read?" do
      it "should return true" do
        expect(policy.can_read?).to eq(true)
      end
    end

    describe "can_create?" do
      it "should return false" do
        expect(policy.can_create?).to eq(false)
      end
    end

    describe "can_update?" do
      it "should return false" do
        expect(policy.can_update?).to eq(false)
      end
    end

    describe "can_delete?" do
      it "should return false" do
        expect(policy.can_delete?).to eq(false)
      end
    end
  end

end