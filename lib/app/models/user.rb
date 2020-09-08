class User < ActiveRecord::Base
    has_many :user_drinks
    has_many :drinks, through: :user_drinks
end