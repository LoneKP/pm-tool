class OrganisationsController < ApplicationController
  def create
    @organisation = Organisation.new(organisation_params)
    @organisation.save
    redirect_to setup_connect_to_tools_path
  end

  def update
    redirect_to setup_connect_to_tools_path
  end

  private

  def organisation_params
    params.require(:organisation).permit(:organisation_name)
  end
end
