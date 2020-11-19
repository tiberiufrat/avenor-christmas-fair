class ProfileController < ApplicationController
    before_action :authenticate_admin!
    def index
        @cu = current_admin
    end
end
