require "zeitwerk"
require "grape"

require "trailblazer/operation"
require "trailblazer/endpoint"

loader = Zeitwerk::Loader.new
loader.push_dir("./app/api")
loader.push_dir("./app/concepts")
loader.push_dir("./app/endpoints")
loader.setup

Twitter::Api.compile!

run Twitter::Api