module Api
  class SportsController < ApiController

    def index
      if access_policy.can_read?
        render json: current_user.sports, each_serializer: SportSerializer
      else
        head :forbidden
      end
    end

    def create
      if access_policy.can_create?
        current_user.sports.create!(sport_params)
        head :no_content
      else
        head :forbidden
      end
    rescue ActionController::ParameterMissing
      head :bad_request
    end

    def update
      if sport.nil?
        head :not_found
      elsif access_policy.can_update?
        sport.update!(sport_params)
        head :no_content
      else
        head :forbidden
      end
    rescue ActionController::ParameterMissing
      head :bad_request
    end

    def destroy
      if sport.nil?
        head :not_found
      elsif access_policy.can_delete?
        sport.destroy
        head :no_content
      else
        head :forbidden
      end
    end

    private
    def sport
      @sport ||= Sport.find_by(id: params[:id])
    end

    def access_policy
      ResourceAccessPolicy.new(resource: sport, user: current_user)
    end

    def sport_params
      params.require(:name)
      params.permit(:id, :name)
    end

  end
end
