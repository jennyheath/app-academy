class Student

  def initialize(first_n, last_n)
    @first_name = first_n
    @last_name = last_n
    @course_list = []
  end

  def name
    "#{@first_name} #{@last_name}"
  end

  def courses
    @course_list
  end

  def enroll(new_course)
    unless has_conflict?(new_course)
      @course_list << new_course
      new_course.add_student(self)
    end
  end

  def course_load
    dept_credits = {}
    @course_list.each do |course|
      if dept_credits[course.department].nil?
        dept_credits[course.department] = course.credits
      else
        dept_credits[course.department] += course.credits
      end
    end
    dept_credits
  end

  def has_conflict?(new_course)
    @course_list.each do |course|
      return true if course.conflicts_with?(new_course)
    end
    false
  end

end


class Course
  attr_reader :course, :department, :credits, :days, :time_block

  def initialize(course, department, credits, days, time_block)
    @course = course
    @department = department
    @credits = credits
    @student_list = []
    @days = days
    @time_block = time_block
  end

  def students
    @student_list
  end

  def add_student(student)
    @student_list << student.name unless @student_list.include?(student.name)
  end

  def conflicts_with?(course_2)
    return false if self.time_block != course_2.time_block
    if (days & course_2.days).empty?
      false
    else
      true
    end
  end

end
