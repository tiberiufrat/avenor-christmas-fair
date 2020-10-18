class Volunteer < ApplicationRecord
  belongs_to :grade
  has_and_belongs_to_many :jobs
  has_and_belongs_to_many :departments
  has_and_belongs_to_many :stands

  def name
  	"#{self.first_name} #{self.last_name}"
  end
end
