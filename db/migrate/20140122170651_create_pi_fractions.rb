class CreatePiFractions < ActiveRecord::Migration
  def change
    create_table :pi_fractions do |t|
      t.integer :numerator
      t.integer :denominator
      t.decimal :error

      t.timestamps
    end
  end
end
