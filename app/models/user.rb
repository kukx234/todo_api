class User < ApplicationRecord
    has_many :todos, dependent: :destroy
    # can not be empty
    validates :first_name, :last_name, presence: true
    # can not be empty, must be unique, and email format
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

    ALLOWED_PARAMS = [ :first_name, :last_name, :email ]
end
