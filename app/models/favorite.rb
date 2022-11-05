class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :route
  validates :user, uniqueness: {scope: :route}
  scope :user_faborites, ->(user) { where("user_id=?", user.id) }
  scope :route_faborites, ->(route) { where("route_id=?", route.id) }

  include PgSearch::Model
  pg_search_scope :search_by_mark_favourite,
    against: [ :user_id, :route_id ],
    using: {
      tsearch: { prefix: true }
    }
end
