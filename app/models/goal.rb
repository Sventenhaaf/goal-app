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

class Goal < ActiveRecord::Base
  STATE = ["PRIVATE", "PUBLIC"]

  validates :body, :user_id, :access, presence: true
  validates :access, inclusion: STATE

  belongs_to :user

  def switch_access
    self.access = (self.access == "PRIVATE" ? "PUBLIC" : "PRIVATE")
    self.save
  end

  def complete_goal
    self.completed = true
    self.save
  end
end
