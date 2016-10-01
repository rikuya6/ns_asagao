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

class Member < ActiveRecord::Base

  def self.search(query)
    rel = order(:number)
    if query.present?
      rel = rel.where("name LIKE ? OR full_name LIKE ?", "#{query}", "#{query}")
    end
    rel
  end
end
