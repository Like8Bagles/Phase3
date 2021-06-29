class Student < ActiveRecord::Base
    belongs_to :sensei

    def self.all_students
        self.all.select { |s| s.sensei.name == "Kakashi Hatake" }
    end

    # def define_sensei
    #     sensei = Student.self.sensei.name
    #     student = Student.self.name
    #     puts "#{student} is in #{sensei}'s class."
    # end

end

# i = Student.new
# i.define_sensei

#Instance method
#prints "student'n name is in student's sensei's name class"

#student.name
#

#return all students that belong to kakashi katake