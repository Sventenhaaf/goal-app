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

FactoryGirl.define do
  factory :goal do
    factory :private_goal do
      body 'Lose 10 pounds'
      completed false
    end

    factory :public_goal do
      body 'Learn to Juggle'
      access "PUBLIC"
      completed false
    end

    factory :uncompleted_goal do
      body 'run a marathon'
      completed false
    end

    factory :completed_goal do
      body 'finish college'
      completed true
    end
  end
end
