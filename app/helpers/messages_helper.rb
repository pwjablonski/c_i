module MessagesHelper
  def recipients_options(chosen_recipient = nil)
    s = ''
    Student.all.each do |student|
      s << "<option value='#{student.user.id}' data-img-src='#{student.user.image}' #{'selected' if student.user == chosen_recipient}>Student: #{student.first_name} #{student.last_name}</option>"
    end
    Teacher.all.each do |teacher|
      s << "<option value='#{teacher.user.id}' data-img-src='#{teacher.user.image}' #{'selected' if teacher.user == chosen_recipient}>Teacher: #{teacher.first_name} #{teacher.last_name}</option>"
    end
    Classroom.all.each do |classroom|
      s << "<option value='#{classroom.id}' data-img-src='' #{'selected' if classroom == chosen_recipient}>Classroom: #{classroom.name} </option>"
    end

    s.html_safe
  end





  
end
