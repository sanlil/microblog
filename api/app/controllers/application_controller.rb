class ApplicationController < ActionController::API
    # show json format in browser
    before_action do
        request.format = :json
    end

end
