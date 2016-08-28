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

      it "responcse 302 status" do
        expect(response).to have_http_status 302
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
end