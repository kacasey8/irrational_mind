module ApplicationHelper
  def pretty_print_int(decimal)
    decimal.to_s.length > 8 ? "%10.3E" % decimal.to_s : decimal.to_i
  end
end
