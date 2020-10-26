class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20, minimum: 2 }
  validates :email, presence: true
  validates :introduction, presence: true, length: { maximum: 50 }

  has_many :books, dependent: :destroy
  attachment :profile_image
end