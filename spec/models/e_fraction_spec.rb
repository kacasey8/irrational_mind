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

require 'spec_helper'

describe EFraction do
  pending "add some examples to (or delete) #{__FILE__}"
end
