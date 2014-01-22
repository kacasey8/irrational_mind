class CreateEFractions < ActiveRecord::Migration
  def change
    create_table :e_fractions do |t|
      t.integer :irrational_id
      t.integer :numerator
      t.integer :denominator
      t.decimal :error

      t.timestamps
    end
  end
end
