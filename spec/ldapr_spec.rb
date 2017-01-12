require 'spec_helper'

describe LDAPR::Client, :vcr do
  before :all do
    described_class.configure do
      url ENV['LDAPR_BASE_URL']
      client_name 'ldapr-client testbed'
      http_options timeout: 15, cache: { disabled: true }
    end
  end

  describe LDAPR::Entry do
    let(:account_name) { "Barnaba Marcello" }
    let(:dn) { dn_for_account_name(account_name) }

    describe 'create entry' do
      let(:account_name) { "test creation" }

      subject { create(account_name: account_name) }

      xit { is_expected.to change { find(dn).entries.count }.from(0).to(1) }
    end

    describe '#find' do
      subject { find(dn) }

      it { is_expected.to be_a LDAPR::Entry }

      it 'has the correct dn' do
        expect( subject.entries.first['entry']['dn'] ).to eq dn
      end

      it 'has the correct thumbnail' do
        expect(subject.entries.first['entry']['thumbnailphoto'] ).to eq thumbnail_data
      end
    end

  end
end
