require 'support/spec_helper'

describe Inky::File do
  context 'when reading existing file' do
    use_vcr_cassette

    let(:uid) { 'hFHUCB3iTxyMzseuWOgG' }
    let(:file) { Inky::File.new(uid) }

    describe '#url' do
      subject { file.url }
      it { is_expected.to eq("#{API_BASE_URL}/file/#{uid}") }
    end
    describe '#size' do
      subject { file.size }
      it { is_expected.to eq(175_210) }
    end
    describe '#mimetype' do
      subject { file.mimetype }
      it { is_expected.to eq('image/png') }
    end
    describe '#uploaded' do
      subject { file.uploaded }
      it { is_expected.to eq(1_390_334_370_000.0) }
    end
    describe '#container' do
      subject { file.container }
      it { is_expected.to eq('your_own_bucket') }
    end
    describe '#writeable' do
      subject { file.writeable }
      it { is_expected.to eq(false) }
    end
    describe '#filename' do
      subject { file.filename }
      it { is_expected.to eq('5qYoopVTsixCJJiqSWSE.png') }
    end
    describe '#location' do
      subject { file.location }
      it { is_expected.to eq('S3') }
    end
    describe '#key' do
      subject { file.key }
      it { is_expected.to eq('ZynOv436QOirPYbJIr3Y_5qYoopVTsixCJJiqSWSE.png') }
    end
    describe '#path' do
      subject { file.path }
      it { is_expected.to eq('ZynOv436QOirPYbJIr3Y_5qYoopVTsixCJJiqSWSE.png') }
    end
    describe '#width' do
      subject { file.width }
      it { is_expected.to eq(400) }
    end
    describe '#height' do
      subject { file.height }
      it { is_expected.to eq(400) }
    end
  end
end
