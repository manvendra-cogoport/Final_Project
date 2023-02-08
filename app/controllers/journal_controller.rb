class JournalController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        j= Journal.all
        render json: j
end
