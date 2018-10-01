class TalkLikeAPirate
  class InstallLocalConfig
    class << self
      def install(target_file_path=nil)
        target_file_path = set_target_file_path(target_file_path)
        if File.exists?(target_file_path)
          "Configuration file already exists at #{target_file_path}"
        else
          copy_local_config_template_to(target_file_path)
          output_local_instructions(target_file_path)
        end
      end

    private #####################################################################

      def set_target_file_path(target_file_path)
        if TalkLikeAPirate.on_rails?
          Rails.root.join 'config', 'pirate_booty.yml'
        else
          target_file_path = path_looks_like_file(target_file_path) ?  FileUtils.pwd : target_file_path
          File.join target_file_path, 'pirate_booty.yml'
        end
      end

      def copy_local_config_template_to(target_file_path)
        target_directory = File.dirname(target_file_path)
        FileUtils.mkdir_p(target_directory) unless Dir.exists?(target_directory) 
        source_path = File.join File.dirname(__FILE__), 'config', 'sample_config.yml'

        FileUtils.copy source_path, target_file_path
      end

      def output_local_instructions(target_file_path)
        return "Configuration installed at #{target_file_path}" if TalkLikeAPirate.on_rails?
        <<-INSTRUCTIONS
********************************************************************************************
Be sure to specify the path to your YAML file in ENV['TALK_LIKE_A_PIRATE_CONFIG_PATH'], i.e.
export TALK_LIKE_A_PIRATE_CONFIG_PATH="#{target_file_path}"
********************************************************************************************
INSTRUCTIONS
      end

      def path_looks_like_file(target_file_path)
        target_file_path =~ /\.[^\.\/]*\z/
      end
    end
  end
end
