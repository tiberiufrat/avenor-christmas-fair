class Grade < ApplicationRecord
	has_many :students, dependent: :destroy
end
