class Item < ApplicationRecord
  # Direct associations

  belongs_to :user

  # Indirect associations

  # Validations
  validates :title, :presence => { :message => ": please provide a title" }

  validates :expiration_date, :presence => { :message => ": please provide an expiration date" }

  validates :location, :presence => { :message => ": please provide the food's location in your home" }

  validates :location, :numericality => { :less_than_or_equal_to => 4, :greater_than_or_equal_to => 0 }

end
