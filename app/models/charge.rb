class Charge < ApplicationRecord
   self.table_name = "pagares"
   has_many :loan, foreign_key:"ID", primary_key:"IDSolicitud"

end
