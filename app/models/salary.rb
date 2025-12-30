class Salary < ApplicationRecord
  belongs_to :employee

  validates :employee_id, presence: true
  validates :amount, :effective_from, presence: true
  validates :amount, numericality: { greater_than: 0 }

  scope :current, -> { where("effective_from <= ?", Date.today).order(effective_from: :desc) }
end
