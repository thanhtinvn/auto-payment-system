class HealthcheckController < ActionController::Base
    def index
        respObj = Response::BaseResponse.new
        respObj.set_msg('Healthy check OK!')

        return render json: respObj.as_json, status: :ok
    end
end
