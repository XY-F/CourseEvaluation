class CoursesController < ApplicationController
  include CoursesHelper
  skip_before_action :verify_authenticity_token, :only => [:select_with_ajax1, :select_with_ajax]
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    if !params[:q].blank?
      @q = Course.ransack(params[:q])
      @course = @q.result.includes(:major, :teacher)
    else
      @course = Course.all
    end
    
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @comment=Comment.where(:course => @course)
  end

  def select_with_ajax
      @majors = College.find_by_id(params[:selected1]).majors
      render json: @majors
  end

  def select_with_ajax1
    @teachers = College.find_by_id(params[:selected2]).teachers
    render json: @teachers
end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  def search
    index
    render :index
  end
  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:name, :major_id, :year, :teacher_id)
    end
end
