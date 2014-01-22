# == Schema Information
#
# Table name: fractions
#
#  id            :integer          not null, primary key
#  irrational_id :integer
#  numerator     :integer
#  denominator   :integer
#  error         :decimal(, )
#  created_at    :datetime
#  updated_at    :datetime
#

class Fraction < ActiveRecord::Base
  belongs_to :irrational

  validates_presence_of :irrational_id, :numerator, :denominator
end
