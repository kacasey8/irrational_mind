class AddPowerToEFraction < ActiveRecord::Migration
  def change
    add_column :e_fractions, :power, :integer
  end
end
