module Api
  class ApiController < ApplicationController
    include Concerns::Authentication

    before_action :authenticate
  end
end
