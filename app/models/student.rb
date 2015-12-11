require 'csv'

class Student < ActiveRecord::Base
    
    belongs_to :user
    has_many :enrollments
    has_many :classrooms, through: :enrollments
    
    belongs_to :school
    
    # require 'iconv'
    
    
    
    
     def self.import(file, classroom_id = nil)
      CSV.foreach(file.path, headers: true) do |row|
      
      student_hash = row.to_hash # exclude the price field
      student_hash[:classroom_id] = classroom_id
      
      student = Student.where(id: student_hash["id"])

        if student.count == 1
          student.first.update_attributes(student_hash)
        else
          Student.create!(student_hash)
        end # end if !product.nil?
      end # end CSV.foreach
    end
  
end
