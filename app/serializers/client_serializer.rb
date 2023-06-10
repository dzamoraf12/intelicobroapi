class AddressSerializer < Blueprinter::Base
    identifier :id
    fields :alias, :name, :paternal_name, :maternal_name, :payment_date,:number_loans, :loan_payment
end