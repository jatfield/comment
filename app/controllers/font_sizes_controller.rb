class FontSizesController < ApplicationController
  before_action :set_font_size, only: [:show, :edit, :update, :destroy]

  # GET /font_sizes
  # GET /font_sizes.json
  def index
    @font_sizes = FontSize.all
  end

  # GET /font_sizes/1
  # GET /font_sizes/1.json
  def show
  end

  # GET /font_sizes/new
  def new
    @font_size = FontSize.new
  end

  # GET /font_sizes/1/edit
  def edit
  end

  # POST /font_sizes
  # POST /font_sizes.json
  def create
    @font_size = FontSize.new(font_size_params)

    respond_to do |format|
      if @font_size.save
        format.html { redirect_to @font_size, notice: 'Font size was successfully created.' }
        format.json { render :show, status: :created, location: @font_size }
      else
        format.html { render :new }
        format.json { render json: @font_size.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /font_sizes/1
  # PATCH/PUT /font_sizes/1.json
  def update
    respond_to do |format|
      if @font_size.update(font_size_params)
        format.html { redirect_to @font_size, notice: 'Font size was successfully updated.' }
        format.json { render :show, status: :ok, location: @font_size }
      else
        format.html { render :edit }
        format.json { render json: @font_size.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /font_sizes/1
  # DELETE /font_sizes/1.json
  def destroy
    @font_size.destroy
    respond_to do |format|
      format.html { redirect_to font_sizes_url, notice: 'Font size was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_font_size
      @font_size = FontSize.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def font_size_params
      params.require(:font_size).permit(:name, :value)
    end
end
