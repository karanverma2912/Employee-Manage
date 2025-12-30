class Certification < ApplicationRecord
  has_and_belongs_to_many :employees

  validates :name, :issuing_body, presence: true
end
