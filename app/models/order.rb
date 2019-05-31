class Order < ApplicationRecord
  belongs_to :library
  delegate :name, to: :library, prefix:true
    def self.search(search)
        if search.present?
          Order.where('serial_no LIKE?', "%#{search}%")
        else
          Order.all
        end
      end 
end
