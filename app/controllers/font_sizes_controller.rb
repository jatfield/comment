class FontSizesController < ApplicationController
  before_action :set_font_size, only: [:show, :edit, :update, :destroy]

  # GET /font_sizes
  def index
    @font_sizes = FontSize.all
  end

  # GET /font_sizes/1
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
  def create
    @font_size = FontSize.new(font_size_params)

    respond_to do |format|
      if @font_size.save
        format.html { redirect_to @font_size, notice: 'Font size was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /font_sizes/1
  def update
    respond_to do |format|
      if @font_size.update(font_size_params)
        format.html { redirect_to @font_size, notice: 'Font size was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /font_sizes/1
  def destroy
    @font_size.destroy
    respond_to do |format|
      format.html { redirect_to font_sizes_url, notice: 'Font size was successfully destroyed.' }
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
