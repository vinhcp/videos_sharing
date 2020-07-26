VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.default_cassette_options = {
    record: :new_episodes,
    re_record_interval: 1.day
  }
  c.configure_rspec_metadata!
end
