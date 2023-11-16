class Customer < ApplicationRecord
  self.table_name = "clientes"
  self.primary_key = "ID"

  alias_attribute :id, :ID
  alias_attribute :customer_number, :NumeroCliente
  alias_attribute :name, :Nombre
  alias_attribute :paternal_name, :ApellidoPaterno
  alias_attribute :maternal_name, :ApellidoMaterno

  # belongs_to :agent, class_name: "Agent", foreign_key: "verification_agent_id", optional: true

  scope :by_name, -> (name) do
    where("Nombre LIKE :filter OR ApellidoPaterno LIKE :filter OR
           ApellidoPaterno LIKE :filter", filter: "%#{name}%")
  end

  def self.all_by_agente(id_agente)
      Customer.find_by_sql("Select c.ID,c.NumeroCliente,CONCAT(c.Nombre,' ',c.ApellidoPaterno,' ',c.ApellidoMaterno) as Nombre,
                            c.FolioIFE, c.FechaNacimiento,c.Direccion,c.CodigoPostal from clientes as c
                            inner join solicitudcredito as s ON c.id=s.IDCliente and IDAgente = #{id_agente}
                            inner join pagares as p ON p.IDSolicitud=s.ID AND p.Cancelado=0 AND p.Pagado=0 
                            WHERE s.Liquidado =0 ")
  end

  def self.filter(params = {})
    filters = {
      by_verification_agent: params[:verification_agent_id],
      by_name: params[:name],
      by_verification_status: params[:verification_status]
    }

    FilteringService.new(self, filters, { }).filter
  end
end
