require "rails_helper"

RSpec.describe Dashboard::WelcomeController, type: "controller" do
	it "not autheticated user should be redirected" do
    get :index
    expect(response).to redirect_to("/home/welcome")
  end
  describe "authenticated user" do
  	before do
      @user = create(:user)
      login_user
  	end

	  it "authenticated user" do
	  	get :index
	  	expect(response).to be_success
      	expect(response).to have_http_status(200)  	
	  end

	  it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end
	end
  end
end