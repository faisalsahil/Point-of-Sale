class AddRackNumberToProducts < ActiveRecord::Migration
  def change
    add_column :products, :rack_number, :string
  end
end
