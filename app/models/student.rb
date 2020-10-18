class Student < ApplicationRecord
  belongs_to :grade

  def name
  	"#{self.first_name} #{self.last_name}"
  end

  def change_money(amount, operation)
  	self.update(balance: self.balance.method(operation).call(amount))
  end
end
