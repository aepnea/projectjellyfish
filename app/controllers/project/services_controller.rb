class Project
  class ServicesController < ApplicationController
    after_action :verify_authorized

    def index
      respond_with services
    end

    private

    def project
      @_project ||= Project.find(params[:project_id]).tap { |p| authorize p }
    end

    def service
      @_service ||= project.services.find(params[:id]).tap { |s| authorize s }
    end

    def services
      @_services ||= project.services
    end
  end
end
