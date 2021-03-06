class CapsulsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index, :range]

  # GET /capsuls
  # GET /capsuls.json
  def index
    @capsuls = Capsul.order('created_at DESC').all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @capsuls }
    end
  end

  # GET /capsuls_datas?from=int&limit=int&currentUser=bool
  def datas
    if params[:currentUser] and current_user
      user = User.find(current_user.id)
      @capsuls = user.capsuls.order('created_at DESC').limit(params[:limit]).offset(params[:from])
    else
      @capsuls = Capsul.order('created_at DESC').limit(params[:limit]).offset(params[:from])
    end
    respond_to do |format|
      format.json { render json: @capsuls }
      format.html # datas.html.erb
    end
  end

  # GET /capsuls/1
  # GET /capsuls/1.json
  def show
    @capsul = Capsul.find(params[:id])
    @json_map = nil
    if @capsul.latitude
      @json_map = @capsul.to_gmaps4rails
    end
    @owner = User.find(@capsul.user_id) if @capsul
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
    user = User.find(current_user.id)
    @capsul = user.capsuls.new(params[:capsul])

    respond_to do |format|
      if @capsul.save
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
    @capsul.destroy

    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end
end
