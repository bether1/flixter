class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson

  def show
   @lesson = current_lesson.section.course 
  end


  def enrolled_in?(lesson)
    return enrolled_lessons.include?(lesson)
  end

  private

  def require_authorized_for_current_lesson
    if current_user.enrolled_in? != true
      redirect_to lesson_path, alert: 'You Must Be Enrolled To View Lessons', status: :unauthorized
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end

