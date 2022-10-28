class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :route

  validates :user, uniqueness: {scope: :route}
end
