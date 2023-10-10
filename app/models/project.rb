class Project < ApplicationRecord
  has_many :project_users
  has_many :users, through: :project_users
  has_many :flags, as: :flaggable, dependent: :destroy

  has_many_attached :files, dependent: :destroy
  enum state: {
    to_do: "to_do",
    in_progress: "in_progress",
    blocked: "blocked",
    to_check: "to_check",
    done: "done"
  }

  def accepted?
    project_users = ProjectUser.where(project: self, role: :project_owner)
    return project_users.any?
  end

  def project_owner_id=(id)
    @project_owner_id = id
  end
  
  def project_owner_id
    @project_owner ||= User.find_by(id: project_owner_id)
  end
  

  validates :visibility, inclusion: { in: ['public', 'private'] }

end
