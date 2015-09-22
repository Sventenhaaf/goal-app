require 'spec_helper'
require 'rails_helper'

feature 'list of goals' do
  given(:first_user) { FactoryGirl.create(:user) }
  given(:second_user) { FactoryGirl.create(:user) }
  given!(:private_goal) { FactoryGirl.create(:private_goal, user_id: first_user.id) }
  given!(:public_goal) { FactoryGirl.create(:public_goal, user_id: first_user.id) }

  scenario 'can see all personal goals' do
    visit "/session/new"
    fill_in "Username", with: first_user.username
    fill_in "Password", with: first_user.password

    click_button "Sign In"
    visit user_goals_url(first_user)

    expect(page).to have_content(private_goal.body)
    expect(page).to have_content(public_goal.body)
  end

  scenario 'can only view public goals of others' do
    visit "/session/new"
    fill_in "Username", with: second_user.username
    fill_in "Password", with: second_user.password
    click_button "Sign In"
    visit user_goals_url(first_user)

    expect(page).to_not have_content(private_goal.body)
    expect(page).to have_content(public_goal.body)
  end
end


feature 'goal completion' do
  given(:productive_user) { FactoryGirl.create(:user) }
  given(:unproductive_user) { FactoryGirl.create(:user) }
  given!(:completed_goal) { FactoryGirl.create(:completed_goal, user_id: productive_user.id) }
  given!(:uncompleted_goal) { FactoryGirl.create(:uncompleted_goal, user_id: unproductive_user.id) }

  scenario 'completed goals show completed' do
    visit "/session/new"
    fill_in "Username", with: productive_user.username
    fill_in "Password", with: productive_user.password

    click_button "Sign In"
    visit user_goals_url(productive_user)

    expect(page).to have_content("completed")
    expect(page).to_not have_content("unfinished")
  end


  scenario 'uncompleted goals show not-completed' do
    visit "/session/new"
    fill_in "Username", with: unproductive_user.username
    fill_in "Password", with: unproductive_user.password

    click_button "Sign In"
    visit user_goals_url(unproductive_user)

    expect(page).to have_content("unfinished")
    expect(page).to_not have_content("completed")
  end
end
