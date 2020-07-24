require 'spec_helper'
require 'active_support/core_ext/string/inflections'

RSpec.describe 'TestSuite' do
  Dir['app/**/*.rb'].each do |file|
    context file do
      subject { file }

      let(:test_file) { file.sub('app', 'spec').sub('.rb', '_spec.rb') }

      it 'should have tests' do
        expect(File.exist?(test_file)).to be_truthy
        class_name = File.basename(file, '.rb').classify
        File.open(test_file, encoding: 'utf-8') do |f|
          body = f.read
          regexp = /^(RSpec\.)?describe.+#{class_name}s?(,\s.+)?\sdo$/
          expect(body).to match(regexp)
          # expect(body).to match(/^\s+it.+do$/)
        end
      end
    end
  end
end
