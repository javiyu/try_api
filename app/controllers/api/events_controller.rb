module Api
  class EventsController < ApiController

    def index
      if access_policy.can_read?
        render json: sport.events, each_serializer: EventSerializer
      else
        head :forbidden
      end
    end

    def create
      if access_policy.can_create?
        create_event(event_params)
        head :no_content
      else
        head :forbidden
      end
    rescue ActionController::ParameterMissing
      head :bad_request
    end

    def update
      if event.nil?
        head :not_found
      elsif access_policy.can_update?
        event.update!(event_params)
        head :no_content
      else
        head :forbidden
      end
    rescue ActionController::ParameterMissing
      head :bad_request
    end

    def destroy
      if event.nil?
        head :not_found
      elsif access_policy.can_delete?
        event.destroy
        head :no_content
      else
        head :forbidden
      end
    end

    private
    def sport
      @sport ||= Sport.find_by(id: params[:sport_id])
    end

    def event
      @event ||= sport.events.find_by(id: params[:id]) if sport
    end

    def access_policy
      ResourceAccessPolicy.new(resource: event, user: current_user)
    end

    def event_params
      params.merge!(user_id: current_user.id)
      params.require(:name)
      params.permit(:id, :name, :user_id)
    end

    def create_event(params)
      sport.events.create!(params)
    end

  end
end
