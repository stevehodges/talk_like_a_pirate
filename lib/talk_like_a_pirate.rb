class TalkLikeAPirate

  class << self
    def translate(me_string)
      me_string.is_a?(String) ? build_string(me_string) : me_string
    end

    def pirate_locale
      @@locale ||= local_config['locale'] || config['locale']
    end

    def on_rails?
      Object.const_defined?(:Rails)
    end

  private #####################################################################

    def build_string(me_string)
      sentence = translate_string(me_string)
      if sentence.split(" ").length > 5 && sentence.match(/[!.?]\Z/) && rand(5) == 0
        sentence = prepare_original_sentence(sentence) + " " + build_piratey_sentence
      end
      sentence
    end

    def translate_string(me_string)
      me_string.split(/ /).map do |word|

        leading_punctuation, word, trailing_punctuation = extract_punctuation word
        capitalized = (word.slice(0,1) == word.slice(0,1).upcase)
        fully_capitalized = (word == word.upcase)

        word = Object.const_defined?(:ActiveSupport) ? piratize_with_pluralization(word.downcase) : piratize(word.downcase)

        word = capitalize_first(word) if capitalized
        word = word.upcase if fully_capitalized
        "#{leading_punctuation}#{word}#{trailing_punctuation}"
      end.join(" ")
    end

    def piratize_with_pluralization(word)
      pluralized = pluralize(word) == word
      if dictionary.has_key? singularize(word)
        word = dictionary[singularize(word)]
        pluralized ? pluralize(word) : word
      else
        translate_if_gerund word
      end
    end

    def piratize(word)
      if dictionary.has_key? word
        dictionary[word]
      else
        translate_if_gerund word
      end
    end

    def translate_if_gerund(word)
      if word[/ing\Z/]
        word.sub(/ing\Z/, "in'")
      elsif word[/ings\Z/]
        word.sub(/ings\Z/, "in's")
      else
        word
      end
    end

    def extract_punctuation(word)
      leading_punctuation  = word.match(/\A([^a-zA-Z]*)/)[1] rescue ''
      trailing_punctuation = word.match(/[a-zA-Z]+([^a-zA-Z]*)\Z/)[1] rescue ''
      word_length = word.length - leading_punctuation.length - trailing_punctuation.length
      word = word[leading_punctuation.length, word_length]
      return leading_punctuation, word, trailing_punctuation
    end

    def prepare_original_sentence(sentence)
      sentence.gsub!(/\.\z/, "")
      sentence = sentence + "." if sentence.match(/\w\z/)
      capitalize_first(sentence)
    end

    def build_piratey_sentence
      capitalize_first(sprinklings_of_flavor.sample) + ["!!","!","."].sample
    end

    def dictionary
      @@dictionary_map ||= config['dictionary'].merge(local_dictionary)
    end

    def sprinklings_of_flavor
      @@fill ||= (config['pirate_flavor'] << local_flavor).compact.flatten
    end

    def config
      @@config ||= begin
        gem_config_path = File.join File.dirname(__FILE__), 'config', 'pirate_booty.yml'
        YAML::load_file gem_config_path
      end
    end

    def local_dictionary
      local_config['dictionary'] || {}
    end

    def local_flavor
      local_config['pirate_flavor'] || nil
    end

    def local_config
      @@local_configs ||= begin
        local_config_path = if on_rails?
          Rails.root.join 'config', 'pirate_booty.yml'
        else
          ENV['TALK_LIKE_A_PIRATE_CONFIG_PATH']
        end
        if local_config_path && File.exist?(local_config_path)
          YAML::load_file(local_config_path)
        else
          {}
        end
      end
    end

    def capitalize_first(string)
      return string unless string.is_a? String
      return string.upcase if string.length < 2
      string.slice(0,1).capitalize + string.slice(1..-1)
    end

    def singularize(word)
      ActiveSupport::Inflector.singularize(word)
    end

    def pluralize(word)
      ActiveSupport::Inflector.pluralize(word)
    end
  end
end

if TalkLikeAPirate.on_rails?
  require 'rails/railties'
else
  require 'yaml'
end
