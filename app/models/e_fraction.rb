# == Schema Information
#
# Table name: e_fractions
#
#  id            :integer          not null, primary key
#  irrational_id :integer
#  numerator     :integer
#  denominator   :integer
#  error         :decimal(, )
#  created_at    :datetime
#  updated_at    :datetime
#  power         :integer
#

class EFraction < ActiveRecord::Base
  belongs_to :irrational

  validates_presence_of :irrational_id, :numerator, :denominator
end
