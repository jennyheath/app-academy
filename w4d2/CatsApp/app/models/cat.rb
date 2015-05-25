class Cat < ActiveRecord::Base
  COAT_COLORS = ["black", "calico", "white", "purple", "orange"]

  def self.colors
    COAT_COLORS
  end

  validates :birth_date, :name, :description, :sex, :color, presence: true
  validates :color, inclusion: { :in => COAT_COLORS }
  validates :sex, inclusion: { :in => ["M", "F"] }

  has_many :cat_rental_requests, dependent: :destroy

  def age
    # ((Time.now - birth_date) / 1.year).round
    time_ago_in_words(birth_date)
  end
end
