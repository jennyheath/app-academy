class Tagging < ActiveRecord::Base

  def self.tag!(tag_topic_id, url_id)
    Tagging.create!({ :tag_topic_id => tag_topic_id, :short_url_id => url_id })
  end

  belongs_to(
    :tag_topic,
    class_name: "TagTopic",
    foreign_key: :tag_topic_id,
    primary_key: :id
  )

  belongs_to(
    :short_url,
    class_name: "ShortenedUrl",
    foreign_key: :short_url_id,
    primary_key: :id
  )

end
