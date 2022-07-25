class Activity < ApplicationRecord
  belongs_to :camper
  has_many :signup
  has_many :camper, through: :signup
end
