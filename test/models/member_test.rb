# == Schema Information
#
# Table name: members
#
#  id            :integer          not null, primary key
#  number        :integer          not null
#  name          :string           not null
#  full_name     :string
#  email         :string
#  birthday      :date
#  gender        :integer          default(0), not null
#  administrator :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  test 'factory girl' do
    member = FactoryGirl.create(:member)
    assert_equal 'Yamada Taro', member.full_name
  end
end
