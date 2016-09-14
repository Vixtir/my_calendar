require 'rails_helper'

RSpec.describe Dashboard::EventsController, type: "controller" do
  before do
    @user = create(:user)
    login_user
  end

  context "user get #new event" do
    before { get :new, { user_id: @user.id } }

    it { expect(response).to have_http_status 200 }

    it { expect(response).to render_template "dashboard/events/new"}

    context "and save event" do
      before { @event = FactoryGirl.attributes_for(:event, user_id: @user.id) }

      context " with valid params " do
        it "change Events count by 1" do
          expect{
            post :create, user_id: @event[:user_id], event: @event
          }.to change(Event,:count).by(1)
        end

        it "redirect to root path" do
          post :create, user_id: @event[:user_id], event: @event
          expect(response).to redirect_to root_path
        end
      end

      context "with invalid params " do
        before { @event = FactoryGirl.attributes_for(:event, title: nil,user_id: @user.id) }

        it "change Events count by 1" do
          expect{
            post :create, user_id: @event[:user_id], event: @event
          }.to change(Event,:count).by(0)
        end

        it "redirect to root path" do
          post :create, user_id: @event[:user_id], event: @event
          expect(response).to render_template(:new)
        end
      end
    end
  end

  context "edit event" do
    before do
      @event = create(:event, user: @user)
      @event_attr = FactoryGirl.attributes_for(:event, user_id: @user.id)
    end

    it "response 200 status" do
      get :edit, user_id: @event.user_id, id: @event.id
      expect(response).to have_http_status 200
    end

    it "render edit template" do
      get :edit, user_id: @event.user_id, id: @event.id
      expect(response).to render_template(:edit)
    end

    context "with valid params " do
      let!(:attr) do
        { title: "Update my title", date: Date.today + 2.day, user_id: @event.user_id , recurring_rule: "null"}
      end

      before do
        patch :update, user_id: @event.id, id: @event, event: attr
        @event.reload
      end

      it "change title" do
        expect(@event.title).to eql "Update my title"
      end

      it "redirect to root path" do
        expect(response).to redirect_to root_path
      end
    end

    context "with valid params " do
      let!(:attr) do
        { title: nil, date: Date.today + 2.day, user_id: @event.user_id , recurring_rule: "null"}
      end

      before do
        patch :update, user_id: @event.id, id: @event, event: attr
      end


      it "redirect to root path" do
        expect(response).to render_template(:edit)
      end
    end
  end

  context "index action" do
    it "user have no event" do
      expect(@user.events.count).to eq 0
    end

    it "return 200 status" do
      get :index, format: :json
      expect(response.status).to eq 200
    end

    it "return json formats" do
      get :index, format: :json
      expect(response.content_type).to eq Mime::JSON
    end

    context "user_with 1 event" do
      before { create(:event, user: @user) }

      it "user have no event" do
        expect(@user.events.count).to eq 1
      end

      it "return 200 status" do
        get :index, format: :json
        expect(response.status).to eq 200
      end

      it "return json formats" do
        get :index, format: :json
        expect(response.content_type).to eq Mime::JSON
      end

      it "return json formats" do
        get :index, format: :json
        expect(response.content_type).to eq Mime::JSON
      end
    end

    context "many users with actions" do
      let!(:user_2) do
        create(:user) do |user|
          user.events.create(attributes_for(:event, title: "User 2 Event"))
        end
      end

      it 'all events' do
        get "/events.json?all=1"
        expect(response.content_type).to eq Mime::JSON
      end
    end
  end
end