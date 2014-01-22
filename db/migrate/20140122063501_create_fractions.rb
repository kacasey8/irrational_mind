class CreateFractions < ActiveRecord::Migration
  def change
    create_table :fractions do |t|
      t.integer :irrational_id
      t.integer :numerator
      t.integer :denominator
      t.decimal :error

      t.timestamps
    end
  end
end
