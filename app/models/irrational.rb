# == Schema Information
#
# Table name: irrationals
#
#  id                :integer          not null, primary key
#  input             :decimal(, )
#  exact_numerator   :integer
#  exact_denominator :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Irrational < ActiveRecord::Base
  validates_presence_of :input
  has_many :fractions
end
