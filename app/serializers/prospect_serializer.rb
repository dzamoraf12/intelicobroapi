class ProspectSerializer < Blueprinter::Base
  identifier :id
  fields :names, :mother_surname, :father_surname, :street, :internal_number,
         :external_number, :zip_code, :neighborhood, :municipality, :city,
         :state, :latitude, :longitude, :verification_status, :verified_at,
         :verification_accepted_at, :verification_rejected_at, :agent_id
end