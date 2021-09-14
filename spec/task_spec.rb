# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../task-1'
require_relative '../data_manager'

RSpec.shared_examples 'check speed' do |size, time|
  context "when size == #{size}" do
    let(:size) { size }

    it 'works under 0.5 s' do
      expect { work }.to perform_under(time)
    end
  end
end

RSpec.describe 'Task №1' do
  describe '#work' do
    let(:size) { 18 }

    before { DataManager.setup_data(size) }

    after { DataManager.clear_data }

    context 'health check' do
      let(:result_data) { File.read('spec/fixtures/result.json') }

      it 'returns users data(in json)' do
        work
        expect(File.read('result.json')).to eq(result_data)
      end
    end

    context 'check execution speed' do
      it_behaves_like 'check speed', 1500, 0.5
      it_behaves_like 'check speed', 3000, 1
      it_behaves_like 'check speed', 6000, 2
      it_behaves_like 'check speed', 12000, 6
    end
  end
end

