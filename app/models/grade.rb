class Grade < ApplicationRecord
	has_many :students, dependent: :destroy
	has_many :volunteers, dependent: :destroy
end
