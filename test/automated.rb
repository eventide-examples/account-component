require_relative './test_init'

TestBench::Run.(
  "test/automated",
  exclude: ["_*", "*_init.rb", "*sketch*", "*_tests.rb"]
)
