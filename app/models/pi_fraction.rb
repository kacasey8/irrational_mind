# == Schema Information
#
# Table name: pi_fractions
#
#  id            :integer          not null, primary key
#  numerator     :integer
#  denominator   :integer
#  error         :decimal(, )
#  created_at    :datetime
#  updated_at    :datetime
#  irrational_id :integer
#

class PiFraction < ActiveRecord::Base
  belongs_to :irrational

  validates_presence_of :irrational_id, :numerator, :denominator
end
