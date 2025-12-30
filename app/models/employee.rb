class Employee < ApplicationRecord
  # Associations
  belongs_to :department
  belongs_to :manager, class_name: "Employee", optional: true
  has_many :subordinates, class_name: "Employee", foreign_key: "manager_id", dependent: :nullify
  has_one :employee_profile, dependent: :destroy
  has_many :salaries, dependent: :destroy
  has_many :project_assignments, dependent: :destroy
  has_many :projects, through: :project_assignments
  has_and_belongs_to_many :certifications
  has_many :performances, dependent: :destroy
  has_many :audit_logs, as: :auditable, dependent: :destroy

  # Validations
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :job_title, presence: true
  validates :hire_date, presence: true

  # Scopes for practice
  scope :active, -> { where(is_active: true) }
  scope :by_department, ->(dept_id) { where(department_id: dept_id) }
  scope :hired_in_year, ->(year) { where("EXTRACT(YEAR FROM hire_date) = ?", year) }
end
