# == Schema Information
#
# Table name: members
#
#  id              :integer          not null, primary key
#  number          :integer          not null
#  name            :string(255)      not null
#  full_name       :string(255)
#  email           :string(255)
#  birthday        :date
#  gender          :integer          default(0), not null
#  administrator   :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  hashed_password :string(255)
#

FactoryGirl.define do
  factory :member do
    sequence(:number) { |n| n + 1 }
    sequence(:name) { |n| "Taro#{n}" }
    full_name 'Yamada Taro'
    sequence(:email) { |n| "taro#{n}@example.com" }
    birthday 30.years.ago
    password 'password'
    password_confirmation 'password'
  end
end
