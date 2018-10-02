class User < ApplicationRecord
  validates_uniqueness_of :uuid

  has_many :memberships, -> { enabled }, dependent: :delete_all
  has_many :courses, through: :memberships

  has_many :identities

  has_many :occurrences, -> { order(created_at: :desc) }
  has_many :events, through: :occurrences

  has_many :earnings, -> { order(created_at: :desc) }
  has_many :badges, through: :earnings

  has_many :attendances
  has_many :lectures, through: :attendances

  has_many :comments

  has_many :user_solutions
  has_many :solutions, through: :user_solutions

  has_many :repos, foreign_key: :author_id, class_name: "AutomaticCorrection::Repo"

  delegate :points, to: :current_membership
  delegate :level, to: :current_membership

  delegate :admin?, to: :current_membership

  def full_name
    "#{last_name}, #{first_name}"
  end

  def enabled_memberships
    memberships.joins(:course).where(courses: { enabled: true })
  end

  def has_github_identity?
    identities.exists?(provider: "github")
  end

  def has_pending_correction_on?(repo)
    repos.exists?(pending: true, id: repo.forks.pluck(:id))
  end

  def github_username
    identities.where(provider: "github").first.nickname
  end

  def update_with(identity)
    self.nickname = identity.nickname
    self.first_name = identity.first_name unless self.first_name.present?
    self.last_name = identity.last_name unless self.last_name.present?
    self.email = identity.email
    self.image = identity.image
    self.save
    self
  end

  def current_membership
    self.memberships.find_by(course: Course.current)
  end

  def admin?
    current_membership.admin?
  end

  def teacher?
    current_membership.teacher? || current_membership.admin?
  end

  def student?
    current_membership.student?
  end

  def guest?
    current_membership.guest?
  end

  def unregister_attendance(lecture)
    if attendances.detect { |a| a.present? && a.lecture == lecture }
      current_membership.add_points(-10)
    end
    Attendance.find_by(user: self, lecture: lecture).try(:delete)
  end

  def register_attendance(lecture, condition)
    return unless current_membership # TODO: preventive fix, needs re-do
    return if present_at(lecture)
    if condition == :present
      current_membership.add_points(10)
    end
    attendance = Attendance.find_or_create_by(user: self, lecture: lecture)
    attendance.update_attributes(condition: condition)
  end

  def register(event)
    events_count = events.count { |x| x.name == event.name } + 1
    if events_count % event.batch_size == 0
      points_per_event = event.points_per_batch
    else
      points_per_event = 0
    end
    occurrences.create(event: event, points: points_per_event)
    current_membership.add_points(points_per_event)
    self.save!
  end

  def earn(badge)
    earnings.create(badge: badge)
  end

  def self.sorted
    self.order(points: :desc)
  end

  def self.sorted_by_name
    self.order(name: :asc)
  end

  def present_at(lecture)
    attendances.where(lecture: lecture, condition: :present).size > 0
  end

  def enabled?
    current_membership.enabled?
  end
end
