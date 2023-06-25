class Prospect < ApplicationRecord
  acts_as_paranoid

  belongs_to :agent, optional: true

  enum verification_status: { pending: 0, verified: 1, accepted: 2, rejected: 3 }

  validates :names, :father_surname, presence: true
  validate_enum_attributes :verification_status

  scope :by_verification_agent, -> (agent_id) do
    where("agent_id = ? AND verification_status IN (?)", agent_id, [0, 1, 3])
  end

  scope :by_name, -> (name) do
    where("names LIKE :filter OR mother_surname LIKE :filter OR
           father_surname LIKE :filter", filter: "%#{name}%")
  end

  scope :by_verification_status, -> (status) do
    where("verification_status = ?", status)
  end

  def self.filter(params = {})
    filters = {
      by_verification_agent: params[:agent_id],
      by_name: params[:name],
      by_verification_status: params[:verification_status]
    }

    FilteringService.new(self, filters, { }).filter
  end
end
