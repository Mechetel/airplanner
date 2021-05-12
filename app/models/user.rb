class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :first_name, :last_name, :username

  # has_many :projects

  def full_name
    "#{first_name} #{last_name}"
  end
end
