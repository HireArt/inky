require 'support/spec_helper'

API_BASE_URL = 'https://www.filepicker.io/api'

shared_examples 'uploaded inky.png' do
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
  describe '#uploaded' do
    subject { file.uploaded }
    it { is_expected.to eq(1_423_769_156_390.755) }
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

      let(:remote) { 'https://www.filepicker.io/api/file/TIYEWbFeRRiWU9mF7BPk' }
      let(:file) { Inky::File.from_url(remote) }
      before { file.save! }

      it_behaves_like 'uploaded inky.png'
    end
  end
end
