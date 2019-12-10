class AddStatusToRental < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :status, :integer, defeault: 0
  end
end
