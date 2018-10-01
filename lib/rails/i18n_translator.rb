class TalkLikeAPirate
  class I18nTranslator
    def initialize(from_locale: 'en', verbose: false)
      @source_locale = from_locale
      @verbose = verbose
    end

    def translate_file_or_directory(path='config/locales')
      path = Rails.root.join(path) if TalkLikeAPirate.on_rails? && !path.include?(Rails.root.to_s)
      return translate(path) if File.exists?(path) && file_is_source_yaml_file?(path)

      directory_contents(path).each do |file_path|
        process_file_or_directory file_path
      end
    end
    alias :translate :translate_file_or_directory

  private #####################################################################

    def process_file_or_directory(file_path)
      if File.directory? file_path
        source_path = File.join(file_path, "#{@source_locale}.yml")
        translate_file(source_path) if File.exists?(source_path)
        translate_file_or_directory file_path
      elsif file_is_source_yaml_file?(file_path)
        translate_file file_path
      end
    end

    def file_is_source_yaml_file?(file_path)
      file_path.to_s.match source_yaml_file_matcher
    end

    def source_yaml_file_matcher
      # prefix_with_dot  locale_name  sublocale_name  .yml
      /([^\/]*\.)?#{@source_locale}([a-zA-Z-]*).yml/
    end

    def translate_file(source_file_path)
      pirate_locale_name  = pirate_locale_name_for(source_file_path)
      target_file_path    = File.join File.dirname(source_file_path), "#{source_filename_prefix(source_file_path)}#{pirate_locale_name}.yml"
      puts "Translatin' #{source_file_path} to #{pirate_locale_name}.yml" if @verbose

      en_yml              = YAML::load_file(source_file_path)
      translation         = {pirate_locale_name => parse_element(en_yml).values.first}
      File.open(target_file_path, 'w:utf-8'){|f| YAML::dump translation, f }
    end

    def pirate_locale_name_for(source_filename)
      TalkLikeAPirate.pirate_locale + source_filename.match(source_yaml_file_matcher)[2]
    end

    def source_filename_prefix(source_filename)
      source_filename.match(source_yaml_file_matcher)[1]
    end

    def parse_element(element)
      case element
        when Hash
          new_hash = {}
          element.each{|k,v| new_hash[k] = parse_element(v)}
          new_hash
        when Array
          element.map{|el| parse_element(element)}
        when String
          TalkLikeAPirate.translate element
        else
          element
      end
    end

    def directory_contents(path)
      Dir.new(path).entries.map do |filename|
        File.join(path, filename) unless ['.', '..'].include?(filename)
      end.compact
    end
  end
end
