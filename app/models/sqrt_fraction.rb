# == Schema Information
#
# Table name: sqrt_fractions
#
#  id            :integer          not null, primary key
#  irrational_id :integer
#  numerator     :integer
#  denominator   :integer
#  error         :decimal(, )
#  root          :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class SqrtFraction < ActiveRecord::Base
  belongs_to :irrational

  validates_presence_of :irrational_id, :numerator, :denominator, :root
end
