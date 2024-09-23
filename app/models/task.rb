class Task < ApplicationRecord

  has_many :task_assignments
  has_many :users, through: :task_assignments

  belongs_to :creator, class_name: "User", primary_key: "created_by"
end

