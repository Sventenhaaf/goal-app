# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  body       :string           not null
#  user_id    :integer          not null
#  access     :string           default("PRIVATE")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  completed  :boolean          default(FALSE)
#

require 'rails_helper'
require 'spec_helper'

describe Goal do
  let(:user) { FactoryGirl.create(:user) }
  let(:goal) { FactoryGirl.create(:private_goal, user_id: user.id) }

  it "belongs to a user" do
    expect(goal.user).to eq(user)
  end

  it "defaults to private" do
    expect(goal.access).to eq("PRIVATE")
  end

  describe "#switch_access" do
    it "switches the access of the goal" do
      goal.switch_access

      expect(goal.access).to eq("PUBLIC")
    end
  end


end
