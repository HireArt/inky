require 'support/spec_helper'

API_BASE_URL = 'https://www.filepicker.io/api'

describe Inky::File do
  describe '.new' do
    let(:uid) { 'hFHUCB3iTxyMzseuWOgG' }
    let(:url) { "#{API_BASE_URL}/file/#{uid}" }
    subject { Inky::File.new(uid) }

    context 'when valid' do
      it { expect(subject.url).to eq(url) }
    end
  end
end
