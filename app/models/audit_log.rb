class AuditLog < ApplicationRecord
  belongs_to :auditable, polymorphic: true

  validates :action, :changed_by, presence: true

  scope :recent, -> { order(created_at: :desc) }
  scope :by_action, ->(action) { where(action: action) }
end
