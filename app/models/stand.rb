class Stand < ApplicationRecord
	has_and_belongs_to_many :volunteers
end
