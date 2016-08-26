class FriendshipsController < ApplicationController

  def create
    @person = Person.first
    @friendship = @person.friendships.build(friend_id: params[:friend_id])


    respond_to do |format|
      if @friendship.save
        format.html { redirect_to @person, notice: 'Added friend' }
        #format.json { render :show, status: :created, location: @person }
      else
        format.html { redirect_to @person, notice: 'Unable to add friend.' }
        #format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @person = Person.first
    @friendship = @person.friendships.find(params[:id])

    respond_to do |format|
      if @friendship.destroy
        format.html { redirect_to @person, notice: 'Removed friendship.' }
      end      
    end
  end
end
