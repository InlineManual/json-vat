require "spec_helper"

RSpec.describe JSONVAT do
  before do
    # Use a fixture file to provide VAT rates. Note that jsonvat.com is no longer available
    described_class.perform_caching = true
    described_class.cache_backend = JSONVAT::FileCacheBackend.new(file_fixture("vat_rates.json"))
  end

  describe "#rates" do
    it { expect(described_class.rates.count).to eql(2) }
    it { expect(described_class.rates.first).to be_a(JSONVAT::Country) }
    it { expect(described_class.rates[0].name).to eql("France") }
    it { expect(described_class.rates[1].name).to eql("United Kingdom") }
  end

  describe "#country" do
    it { expect(described_class.country("uk")).to be_a(JSONVAT::Country) }
    it { expect(described_class.country("uk").name).to eql("United Kingdom") }
  end

  describe "#[]" do
    it { expect(described_class["fr"]).to be_a(JSONVAT::Country) }
    it { expect(described_class["fr"].name).to eql("France") }
  end
end
