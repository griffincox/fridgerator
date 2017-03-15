class Item < ApplicationRecord
  # Direct associations

  # Indirect associations

  # Validations

  validates :location, :numericality => { :less_than_or_equal_to => 4, :greater_than_or_equal_to => 0 }

end
