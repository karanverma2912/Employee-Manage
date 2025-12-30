class EmployeeProfile < ApplicationRecord
  belongs_to :employee

  validates :employee_id, uniqueness: true
  validates :phone, :address, :city, :country, presence: true
end
