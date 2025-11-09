class Todo < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  ALLOWED_PARAMS = [ :title, :description, :completed, :user_id ].freeze
end
