class Customer < ApplicationRecord
  self.table_name = "clientes"

  alias_attribute :number_client, :NumeroCliente
  alias_attribute :name, :Nombre
  alias_attribute :paternal_name, :ApellidoPaterno
  alias_attribute :maternal_name, :ApellidoMaterno

  def self.all_by_agente(id_agente)
      Customer.find_by_sql("Select c.ID,c.NumeroCliente,CONCAT(c.Nombre,' ',c.ApellidoPaterno,' ',c.ApellidoMaterno) as Nombre,
                            c.FolioIFE, c.FechaNacimiento,c.Direccion,c.CodigoPostal from clientes as c
                            inner join solicitudcredito as s ON c.id=s.IDCliente and IDAgente = #{id_agente}
                            inner join pagares as p ON p.IDSolicitud=s.ID AND p.Cancelado=0 AND p.Pagado=0 
                            WHERE s.Liquidado =0 ")
  end
end
