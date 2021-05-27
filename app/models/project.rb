class Project < ApplicationRecord
  belongs_to :user

  with_options inverse_of: :project do
    has_many :tasks, -> { order('tasks.position') }, dependent: :destroy
  end

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :user, presence: true
end
