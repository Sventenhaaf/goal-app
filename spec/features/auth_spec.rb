require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in "Username", with: "gizmo"
      fill_in "Password", with: "gizmogizmo"
      click_button "Sign Up"
      
      expect(page).to have_content("gizmo")
    end

  end

end

feature "logging in" do

  let(:user) { User.create(username: "gizmo", password: "gizmogizmo") }

  scenario "shows username on the homepage after login" do
    visit new_session_url
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Sign In"

    expect(page).to have_content(user.username)
  end

end

feature "logging out" do

  let(:user) { User.create(username: "gizmo", password: "gizmogizmo") }

  scenario "begins with logged out state" do
    visit user_url(user)

    expect(current_url).to eq(new_session_url)
  end



  scenario "doesn't show username on the homepage after logout" do
    visit user_url(user)

    expect(page).to_not have_content(user.username)
  end

end
