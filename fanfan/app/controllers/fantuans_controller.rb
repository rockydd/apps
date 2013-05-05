class FantuansController < ApplicationController
  # GET /fantuans
  # GET /fantuans.json
  def index
    @fantuans = Fantuan.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fantuans }
    end
  end

  # GET /fantuans/1
  # GET /fantuans/1.json
  def show
    @fantuan = Fantuan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fantuan }
    end
  end

  # GET /fantuans/new
  # GET /fantuans/new.json
  def new
    @fantuan = Fantuan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fantuan }
    end
  end

  # GET /fantuans/1/edit
  def edit
    @fantuan = Fantuan.find(params[:id])
  end

  # POST /fantuans
  # POST /fantuans.json
  def create
    @fantuan = Fantuan.new(params[:fantuan])

    respond_to do |format|
      if @fantuan.save
        format.html { redirect_to @fantuan, notice: 'Fantuan was successfully created.' }
        format.json { render json: @fantuan, status: :created, location: @fantuan }
      else
        format.html { render action: "new" }
        format.json { render json: @fantuan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fantuans/1
  # PUT /fantuans/1.json
  def update
    @fantuan = Fantuan.find(params[:id])

    respond_to do |format|
      if @fantuan.update_attributes(params[:fantuan])
        format.html { redirect_to @fantuan, notice: 'Fantuan was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fantuan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fantuans/1
  # DELETE /fantuans/1.json
  def destroy
    @fantuan = Fantuan.find(params[:id])
    @fantuan.destroy

    respond_to do |format|
      format.html { redirect_to fantuans_url }
      format.json { head :ok }
    end
  end
end
