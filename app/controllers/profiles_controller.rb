class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update]

  def index
    @profiles = User.all.paginate(page: params[:page])
  end

  def show
    @profile = User.find(params[:id])
  end

  def edit
    @profile = User.find(params[:id])
    if current_user.id != @profile.id
      flash[:danger] = "Access denied"
      redirect_to root_path
    end
  end

  def update
    @profile = User.find(params[:id])
    if @profile.update(profile_params)
      flash[:success] = 'Profile updated successfully'
      redirect_to profile_path(@profile)
    else
      flash[:danger] = 'Could not update profile!'
      render 'edit'
    end
  end

  private

  def profile_params
    params.require(:user).permit(:phone_number)
  end
end
