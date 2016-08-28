require 'rails_helper'

RSpec.describe "home/welcome/index", :type => :view do
	before { render template: "home/welcome/index", layout: "layouts/application"}

	it "should contain main title" do
		expect(rendered).to have_content t('main_title')
	end

	it "should contain main title" do
		expect(rendered).to have_content t('main_text')
	end

	it "should contain link for log in" do
		expect(rendered).to have_content t('login.link')
	end

	it "should have link for registration" do
		expect(rendered).to have_link t("signup")  
	end	
end