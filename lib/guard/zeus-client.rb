require 'guard'
require 'guard/guard'

module Guard
  class ZeusClient < Guard

    autoload :Runner, 'guard/zeus-client/runner'
    attr_accessor :runner

    # Initialize a Guard.
    # @param [Array<Guard::Watcher>] watchers the Guard file watchers
    # @param [Hash] options the custom Guard options
    def initialize(watchers = [], options = {})
      super

      @options = {
        :all_on_start => true
      }.merge(options)

      @runner = Runner.new(@options)
    end

    # Call once when Guard starts. Please override initialize method to init stuff.
    # @raise [:task_has_failed] when start has failed
    def start
      UI.info 'Guard::ZeusClient is running'
      run_all if @options[:all_on_start]
    end

    # Called when just `enter` is pressed
    # This method should be principally used for long action like running all specs/tests/...
    # @raise [:task_has_failed] when run_all has failed
    def run_all
      unless runner.run_all
        throw :task_has_failed
      end
    end

    # Called on file(s) modifications that the Guard watches.
    # @param [Array<String>] paths the changes files or paths
    # @raise [:task_has_failed] when run_on_change has failed
    def run_on_changes(paths)
      unless runner.run(paths)
        throw :task_has_failed
      end
    end
  end
end
