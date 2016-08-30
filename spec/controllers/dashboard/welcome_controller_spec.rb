require "rails_helper"

RSpec.describe Dashboard::WelcomeController, type: "controller" do

  let(:json) { JSON.parse(response.body) }

  it "not autheticated user should be redirected" do
    get :show
    expect(response).to redirect_to("/home/welcome")
  end

  describe "authenticated user" do
    before do
      @user = create(:user)
      login_user
    end

    it "authenticated user" do
      get :show
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :show
      expect(response).to render_template("dashboard/welcome/show")
    end

    context "get list of events" do
      before do
        create(:event, user: @user)
      end

      it "return status" do
        get :show, {}, { 'Accept' => Mime::JSON }
        expect(response.status).to eq 200
      end
    end
  end
end