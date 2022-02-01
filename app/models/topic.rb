class Topic < ApplicationRecord
  has_many :questions

  alias_attribute :name, :description
end
