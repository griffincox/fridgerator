class Item < ApplicationRecord
  # Direct associations

  belongs_to :user

  # Indirect associations

  # Validations

  validates :expiration_date, :presence => { :message => "Please provide an expiration date" }

  validates :location, :presence => { :message => "Please provide the food's location in your household." }

  validates :location, :numericality => { :less_than_or_equal_to => 4, :greater_than_or_equal_to => 0 }

end
