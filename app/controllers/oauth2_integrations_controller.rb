class Oauth2IntegrationsController < ApplicationController
  def asana
    @organisation = Organisation.find(params[:state])
    redirect_to organisation_connect_to_tools_path(@organisation, code: params[:code], integration_type: 'asana')
  end

  def harvest
    @organisation = Organisation.find(params[:state])
    @scope = params[:scope]
    redirect_to organisation_connect_to_tools_path(@organisation, code: params[:code], integration_type: 'harvest', scope: @scope)
  end
end
