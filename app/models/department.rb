class Department < ApplicationRecord
  has_many :employees, dependent: :destroy
  has_one :budget, dependent: :destroy
  has_many :audit_logs, as: :auditable, dependent: :destroy

  validates :name, presence: true
  validates :budget_allocation, numericality: { greater_than: 0 }
end
