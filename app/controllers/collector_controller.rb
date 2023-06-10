class CollectorController < ApplicationController
  def get_clients_of_agente  
    clients =  Customer.all_by_agente(current_user.agent_id)

    render standard_json_response({}, clients,"", [], "")
  end
end
