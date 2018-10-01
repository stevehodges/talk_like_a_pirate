require_relative 'i18n_translator'
require_relative '../install_local_config'

class LoadTasks < Rails::Railtie
  rake_tasks do

		namespace 'pirate' do
		  desc 'Translate config/locales dictionary into pirrrrate'
		  task :translate, [:dir_or_file_to_translate] => :environment do |t, args|
		    args.with_defaults(dir_or_file_to_translate: 'config/locales')
		    TalkLikeAPirate::I18nTranslator.new.translate args[:dir_or_file_to_translate]
		  end
		end

		namespace 'pirate' do
		  desc 'Add a pirate config file to enable customization of the translation dictionary'
		  task :initialize, [:target_path] => :environment do |t, args|
		    message = TalkLikeAPirate::InstallLocalConfig.install(args[:target_path])
		    puts "#{message}"
		  end
		end
  end
end
