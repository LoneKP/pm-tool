class SetupController < ApplicationController
  def setup
    @organisation = Organisation.new
  end

  def connect_to_tools
    @organisation = Organisation.find(params[:organisation_id])
  end

  def sign_in; end

  def create_user; end

  def invite_colleagues; end

  def done; end
end
