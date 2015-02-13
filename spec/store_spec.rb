require 'support/spec_helper'
require 'active_support/core_ext/string/conversions'

shared_examples 'uploaded inky.png' do
  let(:recorded_time) { VCR.current_cassette.originally_recorded_at || Time.now }

  describe '#uid' do
    subject { file.uid }
    it { is_expected.to be_truthy }
  end
  describe '#size' do
    subject { file.size }
    it { is_expected.to eq(2_930) }
  end
  describe '#mimetype' do
    subject { file.mimetype }
    it { is_expected.to eq('image/png') }
  end
  describe '#uploaded_at' do
    subject { file.uploaded_at.to_date }
    it { is_expected.to eq(recorded_time.to_date) }
  end
  describe '#container' do
    subject { file.container }
    it { is_expected.to eq(nil) }
  end
  describe '#writeable' do
    subject { file.writeable }
    it { is_expected.to eq(true) }
  end
  describe '#filename' do
    subject { file.filename }
    it { is_expected.to eq('inky.png') }
  end
  describe '#location' do
    subject { file.location }
    it { is_expected.to eq(nil) }
  end
  describe '#key' do
    subject { file.key }
    it { is_expected.to eq(nil) }
  end
  describe '#path' do
    subject { file.path }
    it { is_expected.to eq(nil) }
  end
  describe '#width' do
    subject { file.width }
    it { is_expected.to eq(300) }
  end
  describe '#height' do
    subject { file.height }
    it { is_expected.to eq(300) }
  end
end

describe Inky::File do
  before { Inky.authorize! ENV['FILEPICKER_API_KEY'] }

  context 'when writing a file' do
    context 'from local file' do
      use_vcr_cassette

      let(:local_file) { ::File.new('spec/fixtures/files/inky.png') }
      let(:file) { Inky::File.from_file(local_file) }
      before { file.save! }

      it_behaves_like 'uploaded inky.png'
    end

    context 'from remote url' do
      use_vcr_cassette

      let(:remote) { 'https://www.filepicker.io/api/file/Et0USwFnSaGtRVlR6mXY+inky.png' }
      let(:file) { Inky::File.from_url(remote) }
      before { file.save! }

      it_behaves_like 'uploaded inky.png'
    end
  end
end
