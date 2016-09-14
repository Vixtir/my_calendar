require "rails_helper"

RSpec.describe "User", type: "feature" do
  context "first visit" do
    before do
      visit root_path
    end

    it "see alert about you need login" do
      expect(page).to have_content I18n.t('not_authenticated')
    end

    it "see main title" do
      expect(page).to have_content I18n.t('main_title')
    end

    it "see main title" do
      expect(page).to have_content I18n.t('main_text')
    end

    it "see email label" do
      expect(page).to have_content I18n.t('activerecord.attributes.user.email')
    end

    it "see input for email" do
      expect(page).to have_selector("input#email")
    end

    it "see email password" do
      expect(page).to have_content I18n.t('activerecord.attributes.user.password')
    end

    it "see input for password" do
      expect(page).to have_selector("input#password")
    end

    it "see log_in button" do
      expect(page).to have_content I18n.t('login.link')
    end

    it "have link to registrate" do
        expect(page).to have_link I18n.t('signup'), href: new_home_user_path
    end

    it "dont see logout button" do
      expect(page).not_to have_button I18n.t('logout.link')
    end

    it "dont see link for new event" do
      expect(page).to_not have_link I18n.t('event.create.link')
    end

    it "dont see link for event lists" do
      expect(page).to_not have_link I18n.t('all_events')
    end

    it "dont see calendar" do
      expect(page).to_not have_selector("#calendar")
    end

    context "if he not registred" do
      context "and click log_in link would " do
        before do
          click_button I18n.t('login.link')
        end

        it "see email label" do
          expect(page).to have_content I18n.t('activerecord.attributes.user.email')
        end

        it "see input for email" do
          expect(page).to have_selector("input#email")
        end

        it "see email password" do
          expect(page).to have_content I18n.t('activerecord.attributes.user.password')
        end

        it "see input for password" do
          expect(page).to have_selector("input#password")
        end

        it "flash message" do
          expect(page).to have_content I18n.t('login.fail')
        end

        it "redirect to login_path" do
          expect(current_path).to eql home_user_sessions_path
        end

        it "have link to registrate" do
          expect(page).to have_link I18n.t('signup'), href: new_home_user_path
        end
      end

      context "click registred link" do
        before do
          click_link I18n.t('signup')
        end

        it "render to register path" do
          expect(current_path).to eql new_home_user_path
        end

        it "see fullname label" do
          expect(page).to have_content I18n.t('activerecord.attributes.user.full_name')
        end

        it "see input for fullname" do
          expect(page).to have_selector("input#user_full_name")
        end

        it "see email label" do
          expect(page).to have_content I18n.t('activerecord.attributes.user.email')
        end

        it "see input for email" do
          expect(page).to have_selector("input#user_email")
        end

        it "see email password" do
          expect(page).to have_content I18n.t('activerecord.attributes.user.password')
        end

        it "see input for password" do
          expect(page).to have_selector("input#user_password")
        end

        it "see email password" do
          expect(page).to have_content I18n.t('activerecord.attributes.user.password_confirmation')
        end

        it "see input for password" do
          expect(page).to have_selector("input#user_password_confirmation")
        end

        it "have registrate button" do
          expect(page).to have_button I18n.t('signup')
        end
      end
    end
  end
  
  context "registration" do
    before do
      @user = build_stubbed(:user)
      visit new_home_user_path
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      fill_in "user_password_confirmation", with: @user.password_confirmation
      click_button I18n.t('signup')
    end

    it "with valid information redirect to root path" do
      expect(current_path).to eql root_path
    end

    it "have succesfull registrate alert" do
      expect(page).to have_content I18n.t('registrate.success')
    end

  end
end