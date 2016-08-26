class FriendshipsController < ApplicationController

  def new
    @person = Person.find(params[:person_id])
    @friendship = @person.friendships.build
  end


  def create
    search_string = params[:friendship][:search_friends]

    @person = Person.find(params[:person_id])
    @friends = Post.find_taggable(search_string)[:found]

    errors = []
    success = []
    @friends.each do |f|
      friendship = Friendship.new(person: @person, friend: f, accepted: true)
      if friendship.save
        success << f.login
      else
        errors << f.login
      end

    end

    respond_to do |format|
      if errors.empty? && success.size > 0
        format.html { redirect_to @person, notice: "Added friendship for #{search_string}"  }
        #format.json { render :show, status: :created, location: @person }
      else
        format.html { redirect_to @person, notice: "Can't added friends #{errors.join(', ')}" } 
        #format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @friendship = Friendships.find(params[:id])

    respond_to do |format|
      if @friendship.destroy
        format.html { redirect_to @person, notice: 'Removed friendship.' }
      end      
    end
  end
end
