class User < ApplicationRecord
    has_many :todos, dependent: :destroy
    
    # can not be empty
    validates :name, presence: true
  
    # can not be empty, must be unique, and email format
    validates :email, presence: true, uniqueness: true,format: { with: URI::MailTo::EMAIL_REGEXP }
end
