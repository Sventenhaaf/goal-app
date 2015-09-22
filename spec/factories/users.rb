# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :user do
    username { Faker::Name.name }
    password { Faker::Internet.password(8) }
    session_token { SecureRandom.urlsafe_base64 }
  end
end
