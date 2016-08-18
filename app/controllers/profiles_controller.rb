class ProfilesController < ApplicationController
  before_action :set_profile
  before_action :authenticate_user!

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @profile.update(post_params)
        format.html { redirect_to profile_path(@profile), notice: 'Profile was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  protected

  def set_profile
    @profile = current_user
  end

  def post_params
    params.require(:user).permit(:name, :email, :profile_image)
  end

end
