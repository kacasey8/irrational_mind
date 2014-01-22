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
  has_many :fractions
  has_many :pi_fractions
  has_many :sqrt_fractions
  validates_presence_of :input
end
