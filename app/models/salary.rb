class Salary < ApplicationRecord
  belongs_to :employee

  validates :employee_id, presence: true
  validates :amount, :effective_from, presence: true
  validates :amount, numericality: { greater_than: 0 }

  scope :current, -> { where("effective_from <= ?", Date.today).order(effective_from: :desc) }

  # Add to Salary model
  def formatted_amount
    "₹#{amount.to_f.round(0).to_s.gsub(/(\d)(?=(\d{3})+(?!\d))/, '\1,')}"
  end

  # human readable
  def amount_display
    number_to_currency(amount.to_f, unit: "₹", precision: 0, delimiter: ",")
  end
end
