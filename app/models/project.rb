class Project < ApplicationRecord
  has_many :project_assignments, dependent: :destroy
  has_many :employees, through: :project_assignments

  validates :name, :start_date, presence: true
  validates :budget, numericality: { greater_than: 0 }

  scope :active, -> { where("end_date IS NULL OR end_date > ?", Date.today) }
  scope :completed, -> { where("end_date < ?", Date.today) }
end
