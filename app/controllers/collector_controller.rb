class CollectorController < ApplicationController


    def get_clients_of_agente
        
       clients =  Client.all_by_agente(current_user.agent_id)
 
       render standard_json_response({}, clients,"", [], "")
    end
end
