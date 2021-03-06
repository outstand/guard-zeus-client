require 'spec_helper'

describe Guard::ZeusClient::Runner do
  subject(:runner) { described_class.new }

  describe '#run_all' do
    context 'with rspec' do
      it 'should run all specs in the spec dir' do
        runner.should_receive(:run).with(['spec'], anything)

        runner.run_all
      end
    end
  end

  describe 'notifications' do
    context 'when the zeus command fails' do
      before do
        runner.stub(:system).and_return(false)
      end

      it 'sends a failure notification' do
        ::Guard::Notifier.should_receive(:notify).with(
          'Failed', :title => 'ZeusClient Spec Results', :type => :failed, :image => :failed, :priority => 2
        )

        runner.run(['spec'])
      end
    end

    context 'when the zeus command passes' do
      before do
        runner.stub(:system).and_return(true)
      end

      it 'sends a success notification' do
        ::Guard::Notifier.should_receive(:notify).with(
          'Succeeded', :title => 'ZeusClient Spec Results', :type => :success, :image => :success, :priority => 2
        )

        runner.run(['spec'])
      end
    end
  end
end
