class Admin < ApplicationRecord
  has_many :events
  has_many :notifications
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create do |admin|
    Notification.create(admin: admin, text: 'Bine ai venit în noul tău cont!', color: 'success', icon: 'thumbs-up', link: '/profile')
  end
end
