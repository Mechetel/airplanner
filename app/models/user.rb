class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :first_name, :last_name, :username

  has_many :projects

  def full_name
    "#{first_name} #{last_name}"
  end

  def projects_with_nestings
    options = { include: ['tasks.comments.attachments'] }
    serialization = ActiveModelSerializers::SerializableResource.new(projects, options)
    serialization.to_json
  end
end
