require 'bcrypt'
class User < ApplicationRecord
  include BCrypt

  enum :role, [:admin, :member]

  has_many :task_assignments
  has_many :tasks, through: :task_assignments

  has_many :created_tasks, class_name: "Task", foreign_key: "created_by"

  validates_presence_of :name, :email

  validates_uniqueness_of :email

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end
end
