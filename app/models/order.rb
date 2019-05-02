class Order < ApplicationRecord

    def self.search(search)
        if search.present?
          Order.where('serial_no LIKE?', "%#{search}%")
        else
          Order.all
        end
      end 
end
