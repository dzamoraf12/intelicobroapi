class Prospect < ApplicationRecord
  include Rails.application.routes.url_helpers
  acts_as_paranoid

  belongs_to :agent, optional: true
  has_one_attached :picture
  has_one_attached :ID_front
  has_one_attached :ID_back
  has_one_attached :address_proof

  enum verification_status: { pending: 0, verified: 1, accepted: 2, rejected: 3 }
  attr_accessor :attaching_documents

  validates :names, :father_surname, presence: true
  validate_enum_attributes :verification_status
  validates :picture, attached: true, processable_image: true,
                      content_type: ["image/png", "image/jpeg"], size: { between: 1.kilobyte..8.megabytes },
                      if: :attaching_picture?
  validates :ID_front, attached: true, processable_image: true,
                       content_type: ["image/png", "image/jpeg"], size: { between: 1.kilobyte..8.megabytes },
                       if: :attaching_ID_front?
  validates :ID_back, attached: true, processable_image: true,
                      content_type: ["image/png", "image/jpeg"], size: { between: 1.kilobyte..8.megabytes },
                      if: :attaching_ID_back?
  validates :address_proof, attached: true, processable_image: true,
                            content_type: ["image/png", "image/jpeg"], size: { between: 1.kilobyte..8.megabytes },
                            if: :attaching_address_proof?

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

  scope :by_agent, -> (agent_id) do
    where("agent_id = ?", agent_id)
  end

  def self.filter(params = {})
    filters = {
      by_verification_agent: params[:agent_id],
      by_name: params[:name],
      by_verification_status: params[:verification_status],
      by_agent: params[:only_agent_id]
    }

    FilteringService.new(self, filters, { }).filter
  end

  def self.dashboard_data(prospects)
    ProspectDashboardService.new(prospects).generate_metrics
  end

  def attaching_picture?
    self.attaching_documents && self.attaching_documents.include?("picture")
  end

  def attaching_ID_front?
    self.attaching_documents && self.attaching_documents.include?("ID_front")
  end

  def attaching_ID_back?
    self.attaching_documents && self.attaching_documents.include?("ID_back")
  end

  def attaching_address_proof?
    self.attaching_documents && self.attaching_documents.include?("address_proof")
  end

  def picture_url
    if self.picture.attached?
      rails_blob_url(self.picture)
    end
  end

  def ID_front_url
    if self.ID_front.attached?
      rails_blob_url(self.ID_front)
    end
  end

  def ID_back_url
    if self.ID_back.attached?
      rails_blob_url(self.ID_back)
    end
  end

  def address_proof_url
    if self.address_proof.attached?
      rails_blob_url(self.address_proof)
    end
  end
end
