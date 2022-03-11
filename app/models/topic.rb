class Topic < ApplicationRecord
  has_many :questions

  alias_attribute :name, :description

  validates :description, presence: true
end
