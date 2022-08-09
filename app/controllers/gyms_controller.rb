class GymsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :response_invalid
rescue_from ActiveRecord::RecordNotFound, with: :response_not_found

    def index
        render json: Gym.all
    end

    def show
        gym = find_gym
        render json: gym 
    end

    def create
        gym = Gym.create!(gym_params)
        render json: gym, status: :created
    end

    def update
        gym = find_gym
        gym.update!(gym_params)
        render json: gym, status: :ok
    end

    def destroy
        gym = find_gym
        gym.destroy
        head :no_content
    end

    private

    def gym_params
        params.permit(:name, :address)
    end

    def find_gym
       Gym.find(params[:id])
    end

    def response_not_found
        render json: {error: "Gym not found"}, status: :not_found
    end

    def response_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

end
