class Order < ApplicationRecord
  belongs_to :library
  belongs_to :product
  belongs_to :vendor, optional: true
  delegate :name, :product_name, to: :library, prefix:true
    def self.search(search)
        if search.present?
          Order.where('serial_no LIKE?', "%#{search}%")
        else
          Order.all
        end
      end 
end
