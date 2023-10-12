class User < ApplicationRecord
  has_many :todos
  has_many :projects

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
end
