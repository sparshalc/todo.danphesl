class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
        
        
  has_many :todos
  has_many :projects


  validates :email, uniqueness: true

end
