class ProjectAssignment < ApplicationRecord
  belongs_to :employee
  belongs_to :project

  validates :employee_id, :project_id, :assigned_date, presence: true
  validates :employee_id, uniqueness: { scope: :project_id }

  scope :active, -> { where("end_date IS NULL OR end_date > ?", Date.today) }
end
