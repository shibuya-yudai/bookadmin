class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :update, :destroy]

  # GET /sections
  def index
    @sections = Section.all

    render json: @sections
  end

  # GET /sections/1
  def show
    render json: @section
  end

  # POST /sections
  def create
    @section = Section.new(section_params)

    if @section.save
      render json: @section, status: :created, location: @section
    else
      render json: @section.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sections/1
  def update
    if @section.update(section_params)
      render json: @section
    else
      render json: @section.errors, status: :unprocessable_entity
    end
  end

  # PATCH /sections
  def sort
    params[:section].each_with_index do |t,i|
      @section = Section.find(t[:id])
      @section.update( position: i+1 )
    end
    render json: {result: "ok"}
    #ここがちゃんと機能すれば、consoleでokが表示されます。
  end

  # DELETE /sections/1
  def destroy
    @section.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def section_params
      params.require(:section).permit(:title, :understand_rate, :important_rate, :memo, :chapter_id, :position)
    end
end
