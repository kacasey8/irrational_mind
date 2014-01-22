class ChangeExactValuesToDecimals < ActiveRecord::Migration
  def change
    change_table :irrationals do |t|
      t.remove :exact_numerator, :exact_denominator
      t.decimal :exact_numerator, :exact_denominator
    end
  end
end
