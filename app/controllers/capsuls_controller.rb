class CapsulsController < ApplicationController


  # GET /capsuls
  # GET /capsuls.json
  def index
    @capsuls = Capsul.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @capsuls }
    end
  end

  # GET /capsuls/1
  # GET /capsuls/1.json
  def show
    @capsul = Capsul.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @capsul }
    end
  end

  # GET /capsuls/new
  # GET /capsuls/new.json
  def new
    @capsul = Capsul.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @capsul }
    end
  end

  # GET /capsuls/1/edit
  def edit
    @capsul = Capsul.find(params[:id])
  end

  # POST /capsuls
  # POST /capsuls.json
  def create

    # FAIRE UN PARSEUR POUR LA STRING VIDEO ET CHOPER ID VIDEO YOUTUBE ONLY !!!
    @capsul = Capsul.new(params[:capsul])
    @capsul.user_id = current_user.id
    respond_to do |format|
      if @capsul.save
        # add +1 capsule to user profile
        if current_user.capsules.nil?
          current_user.capsules = 0
        end
        current_user.capsules += 1
        current_user.save
        format.html { redirect_to @capsul, notice: 'Capsul was successfully created.' }
        format.json { render json: @capsul, status: :created, location: @capsul }
      else
        format.html { render action: "new" }
        format.json { render json: @capsul.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /capsuls/1
  # PUT /capsuls/1.json
  def update
    @capsul = Capsul.find(params[:id])

    respond_to do |format|
      if @capsul.update_attributes(params[:capsul])
        format.html { redirect_to @capsul, notice: 'Capsul was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @capsul.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /capsuls/1
  # DELETE /capsuls/1.json
  def destroy
    @capsul = Capsul.find(params[:id])
    user = User.find(@capsul.user_id)
    if user.capsules and user.capsules > 0
      user.capsules -= 1
      user.save
    end
    @capsul.destroy

    respond_to do |format|
      format.html { redirect_to capsuls_url }
      format.json { head :no_content }
    end
  end

end
