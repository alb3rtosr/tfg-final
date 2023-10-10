class ProjectUser < ApplicationRecord
  belongs_to :user
  belongs_to :project

  attribute :role, :integer, default: :member
  enum role: { commissioner: 0, project_owner: 1, member: 3 }
  
end
