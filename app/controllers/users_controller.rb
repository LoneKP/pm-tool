class UsersController < ApplicationController
    def create
        @user = User.new(user_params)
        @organisation = Organisation.find(params[:organisation_id])
        @user.organisation = @organisation
        @user.save
        redirect_to user_invite_colleagues_path(@user)
    end

    def new
        
    end

    def invite_colleagues
    end

    def done
    end

    private

    def user_params
      params.require(:user).permit(:email)
    end

end