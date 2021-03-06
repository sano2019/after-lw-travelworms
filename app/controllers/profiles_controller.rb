class ProfilesController < ApplicationController

  def index
    if params[:query].present?
      @user = User.where(username: params[:query])
      if @user.empty?
        @profile = nil
      else
        @profile = @user[0].profile
      end
    end
  end

  def show
    @profile = Profile.find(params[:id])
    @my_friendship = Friendship.where(asker_id: current_user.id).or(Friendship.where(receiver_id: current_user.id))
    @pending_friendships = @my_friendship.where(status: 'pending')
    @friendships = @my_friendship.where(status: 'accepted')
    @friend_check = Friendship.where(asker_id: @profile.user.id, receiver_id: current_user.id).or(Friendship.where(receiver_id: @profile.user.id, asker_id: current_user.id ))
    @declined_request = @friend_check.where(status: 'declined')
  end

  def new
    @profile = Profile.new
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    @profile.save
    redirect_to profiles_path
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.update(profile_params)
    redirect_to profile_path(@profile)
  end

  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
    redirect_to profiles_path
  end

  private

  def profile_params
      params.require(:profile).permit(:first_name, :last_name, :about, :photo)
  end

end
