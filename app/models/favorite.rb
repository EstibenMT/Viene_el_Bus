class Favorite < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :route

  validates :user, uniqueness: {scope: :route}
end
