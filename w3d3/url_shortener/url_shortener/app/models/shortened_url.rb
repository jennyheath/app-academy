class ShortenedUrl < ActiveRecord::Base
  def self.random_code
    new_short_url = SecureRandom.urlsafe_base64
    until !exists?(:short_url => new_short_url)
      new_short_url = SecureRandom.urlsafe_base64
    end

    new_short_url
  end

  def self.create_for_user_and_long_url!(user, long_url)
    new_shortened_url = ShortenedUrl.random_code

    ShortenedUrl.create!({ :submitter_id => user,
                           :long_url => long_url,
                           :short_url => new_shortened_url })
  end

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :short_url_id,
    primary_key: :id
  )

  has_many :visitors, through: :visits, source: :user

  has_many(
    :distinct_visitors,
    -> { distinct },
    through: :visits,
    source: :user
    )

  has_many(
    :taggings,
    class_name: "Tagging",
    foreign_key: :short_url_id,
    primary_key: :id
  )

  has_many :tag_topics, through: :taggings, source: :tag_topic

  def num_clicks
    visitors.count
  end

  def num_uniques
    distinct_visitors.count
  end

  def num_recent_uniques
    distinct_visitors.where('visits.created_at > ?', 10.minutes.ago).count
  end
end
