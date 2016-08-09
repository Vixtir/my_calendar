require "rails_helper"

RSpec.describe Home::WelcomeController, type: "controller" do
	it "#index return 200 status" do
		get :index
		expect(response).to be_success
    expect(response).to have_http_status(200)
	end

	it "renders the index template" do
    get :index
    expect(response).to render_template("index")
  end
end