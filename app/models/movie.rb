class Movie < ActiveRecord::Base
  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :image,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future

  mount_uploader :image, ImageUploader

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size
  end

  def self.search(title, director, duration)

    case duration.to_i
    when 1
      runtime = "runtime_in_minutes < 90"
    when 2
      runtime = "runtime_in_minutes > 90 AND runtime_in_minutes < 120"
    when 3
      runtime = "runtime_in_minutes > 120"
    else
      runtime = ""
    end

    if title.empty? && director.empty?
      where(runtime)
    else
      where("title LIKE ?", "%#{title}%").where("director LIKE ?", "%#{director}%").where(runtime)
    end

  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end
  
end
