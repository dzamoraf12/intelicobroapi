class Visit < ApplicationRecord
  acts_as_paranoid

  belongs_to :customer, class_name: "Customer", foreign_key: "customer_id"
  belongs_to :user

  enum status: { pending: 0, paid: 1 }

  validates :penalty_amount, :comments, presence: :true
  validates :penalty_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :latitude, format: { with: /\A([-+]?([1-8]?\d(\.\d+)?|90(\.0+)?))?\z/ }, allow_blank: true
  validates :longitude, format: { with: /\A([-+]?((1[0-7]|[1-9])?\d(\.\d+)?|180(\.0+)?))?\z/ }, allow_blank: true
  validate_enum_attributes :status

  scope :by_user, -> (user_id) do
    where("user_id = ?", user_id)
  end

  scope :by_customer, -> (customer_id) do
    where("customer_id = ?", customer_id)
  end

  scope :by_status, -> (status) do
    where("status = ?", status)
  end

  def self.filter(params = {})
    filters = {
      by_customer: params[:customer_id],
      by_user: params[:user_id],
      by_status: params[:status],
    }

    FilteringService.new(self, filters, { }).filter
  end
end
