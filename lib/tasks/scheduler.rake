desc "This task is called by the Heroku scheduler add-on"
task :update_ca_data => :environment do
  puts "Updating feed..."
  
  students = Student.all

  students.each do |student|
        ca_data_array = student.update_ca_data

        ca_badges = ca_data_array[2]
        ca_total_points = ca_data_array[3]
        ca_last_coded = ca_data_array.last
        
        ca_datum = CaDatum.create(:student_id => student.id, :total_points => ca_total_points)
  end



  puts "done."
end

task :send_reminders => :environment do
  User.send_reminders
end
