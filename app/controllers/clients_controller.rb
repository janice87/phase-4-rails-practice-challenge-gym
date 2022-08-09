class ClientsController < ApplicationController
    def index
        clients = Client.all 
        render json: clients
    end

    def show
        client = Client.find(params[:id])
        # client.sum(:charge)
        render json: client
    rescue ActiveRecord::RecordNotFound 
        render json: {error: "Client not found"}, status: :not_found
    end

    def update
        client = Client.find(params[:id])
        client.update!(client_params)
        render json: client, status: :ok
    rescue ActiveRecord::RecordInvalid => invalid
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    private

    def client_params
        params.permit(:name, :age)
    end

end
