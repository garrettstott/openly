module Addressable
  extend ActiveSupport::Concern

  included do
    has_many :addresses, as: :addressable
    accepts_nested_attributes_for :addresses
  end

end
