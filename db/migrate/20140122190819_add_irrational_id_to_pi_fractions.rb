class AddIrrationalIdToPiFractions < ActiveRecord::Migration
  def change
    add_column :pi_fractions, :irrational_id, :integer
  end
end
