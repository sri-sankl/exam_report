class StudentsController < ApplicationController
  load_resource :only => [:show, :update, :edit, :destroy, :new, :new_upload]
  authorize_resource

  def index
    page = params[:page].present? ? params[:page] : 1
    if params[:search].present?
      @students = Student.search(params[:search]).paginate(:page => 1)
    else
      @students = Student.all.order("roll_number DESC").paginate(:page => page)
    end
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      flash.now[:success] = I18n.t :success, :scope => [:student, :create]
      render "show"
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:student, :create]
      render "new"
    end
  end

  def update
    if @student.update(student_params)
      flash.now[:success] = I18n.t :success, :scope => [:student, :update]
      render "show"
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:student, :update]
      render "edit"
    end
  end

  def destroy
    if @student.destroy
      flash.now[:success] = I18n.t :success, :scope => [:student, :destroy]
      redirect_to students_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:student, :destroy]
      render "show"
    end
  end

  def student_upload
    @student_uploader = StudentUploader.new
    respond_to do |format|
      format.html { render "new_upload"}
      format.xlsx { send_data @student_uploader.xls_template(col_sep: "\t") }
    end
  end

  def upload
    @student_uploader = StudentUploader.new(params[:student_uploader])
    if @student_uploader.save
      flash[:success] = I18n.t :success, :scope => [:student, :upload]
      redirect_to students_path
    else
      render "new_upload"
    end
  end

  private

  def student_params
    params.require(:student).permit(:name, :dob, :joining_date, :parent_email, :father_name, :mother_name, :roll_number, :mobile_number)
  end

end
