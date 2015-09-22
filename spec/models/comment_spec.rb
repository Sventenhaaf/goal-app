require 'rails_helper'
require 'spec_helper'

describe Comment do
  let(:first_user) { FactoryGirl.create(:user) }
  let(:second_user) { FactoryGirl.create(:user) }
  let!(:public_goal) { FactoryGirl.create(:public_goal, user_id: second_user.id) }
  let(:comment_to_user) { Faker::Lorem.sentence }
  let(:comment_to_goal) { Faker::Lorem.sentence }

  it "belongs to a user" do
    rspec_login_user(first_user)
    visit user_goals_url(second_user)

    click_button "Add Comment for User"
    fill_in "Comment", with: comment_to_user.body
    click_button "Add Comment"

    expect(comment_to_user.user_id).to eq(second_user.id)
  end

  it "belongs to a goal" do
    rspec_login_user(second_user)
    visit user_goals_url(second_user)

    click_button "Add Comment for Goal #{public_goal.body}"
    fill_in "Comment", with: comment_to_goal.body
    click_button "Add Comment"
    
    expect(comment_to_goal.goal_id).to_eq(public_goal.id)
  end



end
