SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::MetricFu
])
SimpleCov.start do
  add_filter 'spec/'
  add_filter 'config/'
  add_filter 'vendor/'
end
