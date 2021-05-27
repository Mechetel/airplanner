class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :username, presence: true
  # validates_with EmailAddress::ActiveRecordValidator, field: :email

  has_many :projects, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end

  def projects_with_nestings
    options = { include: ['tasks.comments.attachments'] }
    serialization = ActiveModelSerializers::SerializableResource.new(projects, options)
    serialization.to_json
  end
end
