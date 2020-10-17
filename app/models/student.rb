class Student < ApplicationRecord
  belongs_to :grade

  def name
  	"#{self.first_name} #{self.last_name}"
  end
end
