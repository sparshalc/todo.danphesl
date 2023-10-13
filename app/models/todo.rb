class Todo < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  
  belongs_to :project
  belongs_to :user

  def completed?
    !completed_at.nil?
  end

end
