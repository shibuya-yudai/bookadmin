class ChaptersController < ApplicationController
  before_action :set_chapter, only: [:show, :update, :destroy]

  # GET /chapters
  def index
    @chapters = Chapter.all

    render json: @chapters
  end

  # GET /chapters/1
  def show
    render json: @chapter
  end

  # POST /chapters
  def create
    @chapter = Chapter.new(chapter_params)

    if @chapter.save
      render json: @chapter, status: :created, location: @chapter
    else
      render json: @chapter.errors, status: :unprocessable_entity
    end
  end

  # PATCH /chapters
  def sort
    params[:chapter].each_with_index do |t,i|
      @chapter = Chapter.find(t[:id])
      @chapter.update( position: i+1 )
    end
    render json: {result: "ok"}
    #ここがちゃんと機能すれば、consoleでokが表示されます。
  end

  # PATCH/PUT /chapters/1
  def update
    if @chapter.update(chapter_params)
      render json: @chapter
    else
      render json: @chapter.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chapters/1
  def destroy
    @chapter.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Chapter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chapter_params
      params.require(:chapter).permit(:title, :memo, :book_id, :position)
    end
end
