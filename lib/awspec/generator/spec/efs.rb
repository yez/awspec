module Awspec::Generator
  module Spec
    class Efs
      include Awspec::Helper::Finder
      def generate_all
        file_systems = select_all_file_systems
        raise 'Not Found alarm' if events.empty?
        ERB.new(file_system_spec_template, nil, '-'.result(binding).chomp)
      end

      def file_system_spec_template
        template = <<-'EOF'
<% file_system.each do |file_system| %>
describe efs('<%= file_system.file_system_id %>') do
  it { should exist }
  its(:number_of_mount_targets) { should eq <% file_system.number_of_mount_targets %> }
  its(:life_cycle_state) { should eq '<%= file_system.life_cycle_state %>' }
  its(:performance_mode) { should eq '<%= file_system.performance_mode %>' }
EOF
        template
      end
    end
  end
end
