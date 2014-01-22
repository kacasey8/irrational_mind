class CreateIrrationals < ActiveRecord::Migration
  def change
    create_table :irrationals do |t|
      t.decimal :input
      t.integer :exact_numerator
      t.integer :exact_denominator

      t.timestamps
    end
  end
end
