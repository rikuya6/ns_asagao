# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  body        :text(65535)      not null
#  released_at :datetime         not null
#  expired_at  :datetime
#  member_only :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Article < ActiveRecord::Base
  before_validation :clear_expired_at


  # スコープ
  scope :open, -> {
    now = Time.current
    where("released_at <= ? AND (? < expired_at OR " +
      "expired_at IS NULL)", now, now)
  }

  scope :readable_for, ->(member) {
    member ? all : where(member_only: false)
  }


  # バリデーション
  validates :title,         presence: true,
                            length: { maximum: 200 }

  validates :body,          presence: true

  validates :released_at,   presence: true

  validate :check_expired_at


  # メソッド
  def no_expiration
    expired_at.blank?
  end

  def no_expiration=(val)
    @no_expiration = val.in?([true, 1, '1'])
  end


  # プライベートメソッド
  private

  def check_expired_at
    if expired_at && expired_at < released_at
      errors.add(:expired_at, :expired_at_too_old)
    end
  end

  def clear_expired_at
    self.expired_at = nil if @no_expiration
  end

  def self.sidebar_articles(member, num = 5)
    open.readable_for(member).order(released_at: :desc).limit(num)
  end
end
