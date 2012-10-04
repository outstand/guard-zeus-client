module Guard
  class ZeusClient
    class Runner
      def initialize(options = {})
        @options = {
          :zeus_options => nil,
          :zeus_subcommand => 'test',
          :zeus_subcommand_options => nil,
          :run_all_test_dirs => nil,
          :notification => true
        }.merge(options)
      end

      def run(paths, options = {})
        return false if paths.empty?

        message = options[:message] || "Zeus running: #{paths.join(' ')}"
        UI.info(message, :reset => true)

        options = @options.merge(options)

        run_via_shell paths, options
      end

      def run_all
        run(@options[:run_all_test_dirs] || test_dirs, :message => 'Zeus running all')
      end

      def zeus_executable
        @zeus_executable ||= 'zeus'
      end

      private
      def run_via_shell(paths, options)
        success = system(zeus_command(paths, options))

        notify(success)

        success
      end

      def notify(success)
        return unless @options[:notification]

        message = 'Failed'
        type = :failed

        if success
          message = 'Succeeded'
          type = :success
        end

        Notifier.notify(message, type: type, image: type, title: 'ZeusClient Spec Results', priority: 2)
      end

      def zeus_arguments(paths, options)
        arg_parts = []
        arg_parts << options[:zeus_options]
        arg_parts << zeus_subcommand
        arg_parts << options[:zeus_subcommand_options]
        arg_parts << paths.join(' ')

        arg_parts.compact.join(' ')
      end

      def zeus_command(paths, options)
        cmd_parts = []
        cmd_parts << zeus_executable
        cmd_parts << zeus_arguments(paths, options)

        cmd_parts.compact.join(' ')
      end

      def zeus_subcommand
        @options[:zeus_subcommand] || 'test'
      end

      def test_dirs
        if File.exists?(ROOT_PATH + "/spec/spec_helper.rb")
          ['spec']
        elsif File.exist?(ROOT_PATH + "/test/minitest_helper.rb")
          minitest_dirs
        else
          Dir['test/**/*_test.rb'] + Dir['test/**/test_*.rb']
        end
      end

      def minitest_dirs
        dirs = %w[test spec]
        patterns = %w[*_test.rb test_*.rb *_spec.rb]
        dirs.map do |dir|
          patterns.map do |pattern|
            Dir["#{dir}/**/#{pattern}"]
          end.flatten
        end.flatten
      end
    end
  end
end
