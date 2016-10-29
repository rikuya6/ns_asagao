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

class Member < ActiveRecord::Base
  include EmailAddressChecker

  # アクセサ
  attr_accessor :password, :password_confirmation


  # 関連
  has_many :entries,  dependent: :destroy


  # バリデーション
  validates :number,      presence: true,
                          numericality: {
                                          only_integer: true,
                                          greater_than: 0,
                                          less_then: 100,
                                          allow_blank: true,
                                        },
                          uniqueness: true

  validates :name,        presence: true,
                          format: {
                                    with: /\A[A-Za-z]\w*\z/, allow_blank: true,
                                    message: :invalid_member_name,
                                  },
                          length: {
                                    minimum: 2,
                                    maximum: 20,
                                    allow_blank: true,
                                   },
                          uniqueness: { case_sensitive: false, }

  validates :full_name,   length: { maximum: 20, }

  validate  :check_email

  validates :password,    presence: { on: :create, },
                          confirmation: { allow_blank: true, }


  # メソッド
  def password=(val)
    if val.present?
      self.hashed_password = BCrypt::Password.create(val)
    end
    @password = val
  end

  # クラスメソッド
  def self.authenticate(name, password)
    member = find_by(name: name)
    if member && member.hashed_password.present? &&
        BCrypt::Password.new(member.hashed_password) == password
      member
    else
      nil
    end
  end


  # プライベートメソッド
  private

  def self.search(query)
    rel = order(:number)
    if query.present?
      rel = rel.where("name LIKE ? OR full_name LIKE ?", "#{query}", "#{query}")
    end
    rel
  end

  def check_email
    if email.present?
      errors.add(:email, :invalid) unless well_formed_as_email_address(email)
    end
  end
end
