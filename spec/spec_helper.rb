require File.join(File.dirname(__FILE__), "../lib/gembird-backend")
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end

def assets(*path)
  File.join(File.dirname(__FILE__), "assets", *path)
end

def command_result(file)
  File.read assets "sispmctl", file
end
