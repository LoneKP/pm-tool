class OrganisationsController < ApplicationController
  
  def new
  end

  def create
    @organisation = Organisation.new(organisation_params)
    @organisation.save
    redirect_to organisation_connect_to_tools_path(@organisation)
  end

  def setup_organisation
    @organisation = Organisation.new
  end

  def connect_to_tools
    @organisation = Organisation.find(params[:organisation_id])
    if params[:code].present?
      @code = params[:code]
      @scope = params[:scope]
      GetAccessToken.new(@code, @scope, @organisation).create_harvest_integration
    end
  end

  def sign_in
    @organisation = Organisation.find(params[:organisation_id])
  end

  def create_user; end

  def invite_colleagues; end

  def done; end

  def update
    redirect_to setup_connect_to_tools_path
  end

  private

  def organisation_params
    params.require(:organisation).permit(:organisation_name)
  end
end
