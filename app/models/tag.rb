class Tag < ApplicationRecord
  has_many :taggings
  has_many :posts, through: :taggings

  validate :text_should_be_present_and_unique

  private
  def text_should_be_present_and_unique
    if text.blank? or Tag.pluck(:text).map(&:upcase).include?(text.upcase)
      errors.add(:text, "should be present and unique")
    end
  end
end