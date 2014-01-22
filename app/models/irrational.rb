# == Schema Information
#
# Table name: irrationals
#
#  id                :integer          not null, primary key
#  input             :decimal(, )
#  created_at        :datetime
#  updated_at        :datetime
#  exact_numerator   :decimal(, )
#  exact_denominator :decimal(, )
#

class Irrational < ActiveRecord::Base
  validates_presence_of :input
  has_many :fractions
end
