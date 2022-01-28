class ServicesController < ApplicationController
  def home
    @services = Rails.configuration.github.repositories
  end

  def show
    services = Rails.configuration.github.repositories
    @service = services[params[:id].to_sym]
    @name = params[:id]

    render_404 if @service.nil?
  end
end
