class Performance < ApplicationRecord
  belongs_to :employee

  validates :employee_id, :review_date, :rating, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  scope :by_year, ->(year) { where("EXTRACT(YEAR FROM review_date) = ?", year) }
end
