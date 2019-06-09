class OrganisationsController < ApplicationController
  def new
    @organisation = Organisation.new
  end

  def create
    @organisation = Organisation.new(organisation_params)
    if @organisation.save
      redirect_to organisation_connect_to_tools_path(@organisation)
    else
      render "new"
    end
  end

  def setup_organisation
    @organisation = Organisation.new
  end

  def connect_to_tools
    @organisation = Organisation.find(params[:organisation_id])
    if params[:integration_type] == 'asana'
      @code = params[:code]
      GetAsanaAccessToken.new(@code, @organisation).create_asana_integration
      flash.now[:notice] = "Congratulations! Asana account has been connected"
    elsif params[:integration_type] == 'harvest'
      @code = params[:code]
      @harvest_account_id = params[:scope].gsub(/[^0-9]/, "").to_i
      if !HarvestIntegration.exists?(harvest_account_id: @harvest_account_id)
        GetHarvestAccessToken.new(@code, @harvest_account_id, @organisation).create_harvest_integration
        flash.now[:notice] = "Congratulations! Harvest account has been connected"
      else
        flash.now[:alert] = "This harvest account does already have a connection set up. You need to ask an admin to invite you"
      end
    end
  end




  def show
    @organisations = Organisation.all
    @user = current_user
    @organisation = Organisation.find(params[:id])
  end

  def update
    redirect_to setup_connect_to_tools_path
  end

  private

  def organisation_params
    params.require(:organisation).permit(:organisation_name)
  end
end
