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

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  # 空の値をチェック
  test 'presence' do
    article = Article.new
    assert article.invalid?
    assert article.errors.include?(:title)
    assert article.errors.include?(:body)
    assert article.errors.include?(:released_at)
  end

  # 長さのチェック
  test 'length' do
    article = FactoryGirl.build(:article)
    article.title = 'A' * 201
    assert article.invalid?
    assert article.errors.include?(:title)
  end

  # 掲載終了日時は掲載開始日時より後
  test 'expired_at' do
    article = FactoryGirl.build(:article)
    article.released_at = Time.current
    article.expired_at = 1.days.ago
    assert article.invalid?
    assert article.errors.include?(:expired_at)
  end

  # no_expirationがオンならexpired_atを使わない
  test 'no_expiration' do
    article = FactoryGirl.build(:article)
    article.no_expiration = true
    assert article.valid?
    assert_nil article.expired_at
  end

  # openスコープのチェック
  test 'open' do
    article1 = FactoryGirl.create(:article, title: '現在',
      released_at: 1.day.ago, expired_at: 1.day.from_now)
    article2 = FactoryGirl.create(:article, title: '過去',
      released_at: 2.days.ago, expired_at: 1.day.ago)
    article3 = FactoryGirl.create(:article, title: '未来',
      released_at: 1.day.from_now, expired_at: 2.days.from_now)
    article4 = FactoryGirl.create(:article, title: '終了日なし',
      released_at: 1.day.ago, expired_at: nil)

    articles = Article.open
    assert_includes articles, article1, '現在の記事が含まれる'
    refute_includes articles, article2, '過去の記事は含まれない'
    refute_includes articles, article3, '未来の記事は含まれない'
    assert_includes articles, article4, 'expiredがnilの場合'
  end

  # readable_forスコープのチェック
  test 'readable_for' do
    article1 = FactoryGirl.create(:article)
    article2 = FactoryGirl.create(:article, member_only: true)

    articles = Article.readable_for(nil)
    assert_includes articles, article1, '現在の記事が含まれる'
    refute_includes articles, article2, '会員限定記事は含まれない'

    articles = Article.readable_for(FactoryGirl.create(:member))
    assert_includes articles, article1, '現在の記事が含まれる'
    assert_includes articles, article2, '会員限定記事が含まれる'
  end
end
