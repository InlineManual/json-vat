module FileFixtureHelper
  def file_fixture(filename)
    "#{__dir__}/../fixtures/#{filename}"
  end
end

RSpec.configure do |config|
  config.include FileFixtureHelper
end
