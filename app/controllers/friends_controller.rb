class FriendsController < ApplicationController
  def index
    @friends = Friend.all
  end

  def show
    @friend = Friend.find(params[:id])
    authorize @friend
  end

  def new
    @friend = Friend.new
    authorize @friend
  end

  def edit
    @friend = Friend.find(params[:id])
    authorize @friend
  end

  def update
    @friend = Friend.find(params[:id])
    authorize @friend
    if @friend.update(friend_params)
      redirect_to friend_path(@friend)
    else
      render :edit
    end
  end

  def create
    @friend = Friend.new(friend_params)
    @friend.user_id = current_user.id
    authorize @friend

    if @friend.save
      redirect_to friend_path(@friend)
    else
      render :new
    end
  end

  def destroy
    @friend = Friend.find(params[:id])
    authorize @friend
    friend.destroy
    redirect_to friends_path
  end

  private

  def friend_params
    params.require(:friend).permit(:email, :phone_number, :name, :token)
  end
end
end
