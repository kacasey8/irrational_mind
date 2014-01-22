json.array!(@irrationals) do |irrational|
  json.extract! irrational, :id, :input, :exact_numerator, :exact_denominator
  json.url irrational_url(irrational, format: :json)
end
