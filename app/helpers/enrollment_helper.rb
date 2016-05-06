module EnrollmentHelper
  def enrollments_options(chosen_recipient = nil)
    s = ''
    Student.all.each do |student|
      s << "<option value='#{student.id}' data-img-src='#{student}' #{'selected' if student == chosen_recipient}>#{student.first_name}_#{student.last_name}</option>"
    end
    s.html_safe
  end
end
