class Budget < ApplicationRecord
  belongs_to :department

  validates :department_id, uniqueness: true
  validates :allocated_amount, :spent_amount, numericality: { greater_than_or_equal_to: 0 }
end

# class AuditLog < ApplicationRecord
#   belongs_to :auditable, polymorphic: true

#   validates :action, :changed_by, presence: true

#   scope :recent, -> { order(created_at: :desc) }
# end
