module RegistrationsHelper

  def registrations_options(chosen_recipient = nil)
    s = ''
    Student.all.each do |student|
      s << "<option value='#{student.id}' data-img-src='#{student}' #{'selected' if student == chosen_recipient}>#{student.first_name}_#{student.last_name}</option>"
    end
    s.html_safe
  end


  def classroom_registrations_options(chosen_recipient = nil)
    s = ''
    Classroom.all.each do |classroom|
      s << "<option value='#{classroom.id}' data-img-src='#{classroom}' #{'selected' if classroom == chosen_recipient}>#{classroom.name}</option>"
    end
    s.html_safe
  end

end
