require 'rails_helper'

RSpec.describe "home/welcome/index", :type => :view do
	before { render }

	it "should contain main title" do
		expect(rendered).to have_content t('main_title')
	end

	it "should contain main title" do
		expect(rendered).to have_content t('main_text')
	end

	it "should contain log_in text" do
		expect(rendered).to have_content t('login')
	end

	it "should have link for registration" do
		expect(rendered).to have_link t("signup")  
	end	
end