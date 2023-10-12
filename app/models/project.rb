class Project < ApplicationRecord
  validates :title, presence: true
  has_many :todos, dependent: :destroy
  belongs_to :user
end
