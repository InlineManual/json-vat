require "spec_helper"

RSpec.describe JSONVAT::Country do

  let(:periods) do
    JSON.parse(<<~JSON
      [
        {
          "effective_from": "2014-01-01",
          "rates": {
            "super_reduced": 2.5,
            "reduced1": 5.5,
            "reduced2": 10,
            "standard": 20
          }
        },
        {
          "effective_from": "2015-01-01",
          "rates": {
            "super_reduced": 5.25,
            "reduced1": 10.5,
            "reduced2": 20,
            "standard": 25.5
          }
        }
      ]
    JSON
    )
  end

  it { expect(described_class.new("country_code" => "FR").country_code).to eql("FR") }
  it { expect(described_class.new("code" => "UK").code).to eql("UK") }
  it { expect(described_class.new("periods" => periods).periods.first).to be_a(JSONVAT::Period) }
  it { expect(described_class.new("periods" => periods).periods.first.effective_from).to eql(Date.parse("2014-01-01")) }
  it { expect(described_class.new("periods" => periods).rate_on(Date.parse("2015-02-02"))).to eql(25.5) }
end
