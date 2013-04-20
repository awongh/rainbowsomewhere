class FindRainbowsController < ApplicationController
  # GET /find_rainbows
  # GET /find_rainbows.json
  def index
  end

  def find 
    # @find_rainbows = FindRainbow.new( :location => {:longitude =>37.8267, :latitude=>-122.423} )
    # @find_rainbows.location = f
    @find_rainbows = FindRainbow.new

    @b = @find_rainbows.find

    puts @find_rainbows

    puts @b

    #binding.pry

    render json: @find_rainbows
  end

  # GET /find_rainbows/1
  # GET /find_rainbows/1.json
  def show
    @find_rainbow = FindRainbow.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @find_rainbow }
    end
  end

  # GET /find_rainbows/new
  # GET /find_rainbows/new.json
  def new
    @find_rainbow = FindRainbow.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @find_rainbow }
    end
  end

  # GET /find_rainbows/1/edit
  def edit
    @find_rainbow = FindRainbow.find(params[:id])
  end

  # POST /find_rainbows
  # POST /find_rainbows.json
  def create
    @find_rainbow = FindRainbow.new(params[:find_rainbow])

    respond_to do |format|
      if @find_rainbow.save
        format.html { redirect_to @find_rainbow, notice: 'Find rainbow was successfully created.' }
        format.json { render json: @find_rainbow, status: :created, location: @find_rainbow }
      else
        format.html { render action: "new" }
        format.json { render json: @find_rainbow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /find_rainbows/1
  # PUT /find_rainbows/1.json
  def update
    @find_rainbow = FindRainbow.find(params[:id])

    respond_to do |format|
      if @find_rainbow.update_attributes(params[:find_rainbow])
        format.html { redirect_to @find_rainbow, notice: 'Find rainbow was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @find_rainbow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /find_rainbows/1
  # DELETE /find_rainbows/1.json
  def destroy
    @find_rainbow = FindRainbow.find(params[:id])
    @find_rainbow.destroy

    respond_to do |format|
      format.html { redirect_to find_rainbows_url }
      format.json { head :no_content }
    end
  end
end
