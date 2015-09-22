require 'spec_helper'
require 'rails_helper'

feature 'adds a comment' do
  given(:first_user) { FactoryGirl.create(:user) }
  given(:second_user) { FactoryGirl.create(:user) }
  given!(:public_goal) { FactoryGirl.create(:public_goal, user_id: second_user.id) }
  given(:comment_to_user) { Faker::Lorem.sentence }
  given(:comment_to_goal) { Faker::Lorem.sentence }


  scenario 'to a user' do
    rspec_login_user(first_user)
    visit user_goals_url(second_user)

    click_button "Add Comment for User"
    fill_in "Comment", with: comment_to_user.body
    click_button "Add Comment"

    expect(page).to have_content(comment_to_user.body)
  end

  scenario 'to a goal' do
    rspec_login_user(second_user)
    visit user_goals_url(second_user)

    click_button "Add Comment for Goal #{public_goal.body}"
    fill_in "Comment", with: comment_to_goal.body
    click_button "Add Comment"

    expect(page).to have_content(comment_to_goal.body)
  end

end
