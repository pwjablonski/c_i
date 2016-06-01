
require 'csv'

class Classroom < ActiveRecord::Base
    belongs_to :teacher
    belongs_to :school
    
    has_many :announcements
    has_many :enrollments, dependent: :destroy
    has_many :students, through: :enrollments
    has_many :notifications
    has_many :attendance_lists
    has_many :attendance_data, through: :attendance_lists
    belongs_to :track
    
    acts_as_messageable
    
    def add_students(students)
        response = ""

        students.each do |student|
            student_id = student.id
            current_student = self.enrollments.find_by(student_id: student_id)
            if current_student
                response = response + "#{student.first_name} already enrolled:  "
            else
                current_student = self.enrollments.build(student_id: student_id)
                current_student.save
                response = response + "#{student.first_name} successfully enrolled: "

            end
            current_student
        end
        return response
    end
    
    def verified_enrollments
        verified_enrollments = []
        self.enrollments.each do |enrollment|
            if enrollment.is_verified
                verified_enrollments << enrollment
            end
        end
        return verified_enrollments
    end

def percent_present
    total_percent_present = 0.0
   
    
    self.verified_enrollments.each do |enrollment|
        total_percent_present += enrollment.percent_present
    end
    
    class_percent_present = (total_percent_present/self.verified_enrollments.count)
    
    return class_percent_present.round(2)
    
end

def calculate_ca_points
    class_total_ca_score = 0.0
    
    self.verified_enrollments.each do |enrollment|
        class_total_ca_score += enrollment.student.current_ca_score
    end
    self.update_attribute(:ca_points, class_total_ca_score)
    class_total_ca_score
end

def calculate_average_ca_points
    if self.verified_enrollments.count == 0
        return 0
    else
        return (self.ca_points / self.verified_enrollments.count) 
    end
end

def self.total_ca_points
    total = 0
    all.each{|c| total += c.calculate_ca_points}
    total.to_i
end




def mailboxer_email(object)
    
      return self.teacher.user.email   # or whatever address the email is to be sent to
 
end


def to_csv(options = {})
      CSV.generate(options) do |csv|
      header = [""]  
      header += self.attendance_lists.reverse.collect { |p| p.date } 
      csv <<  header
        self.verified_enrollments.each do |enrollment|
          row = ["#{enrollment.student.first_name + enrollment.student.last_name}"]
          puts "testing1"
          row += enrollment.attendance_data.reverse.collect { |p| p.present } 
          puts row
          csv << row
        end
      end
end


#    def remove_student(student_id)
#        current_student = self.enrollments.find_by(student_id: student_id)
#        current_student
#    end
#    

    def num_students
        self.students.count
    end

def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    student = Student.find_by( codecademy_username: row["Username"])
    student.update_attribute(:capercentcomplete, row["Complete"] )
    product.save!
  end
end

def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when ".csv" then Csv.new(file.path, nil, :ignore)
  when ".xls" then Excel.new(file.path, nil, :ignore)
  when ".xlsx" then Excelx.new(file.path, nil, :ignore)
  else raise "Unknown file type: #{file.original_filename}"
  end
end
    
    
end
