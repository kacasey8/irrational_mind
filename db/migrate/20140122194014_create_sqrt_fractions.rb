class CreateSqrtFractions < ActiveRecord::Migration
  def change
    create_table :sqrt_fractions do |t|
      t.integer :irrational_id
      t.integer :numerator
      t.integer :denominator
      t.decimal :error
      t.integer :root

      t.timestamps
    end
  end
end
