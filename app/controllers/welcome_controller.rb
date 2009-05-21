class WelcomeController < ApplicationController
  def index
    @num_missionarios = Missionario.count
  end
end
