class TalkLikeAPirate

  def self.translate(me_string)
    me_string.is_a?(String) ? build_string(me_string) : me_string
  end

private #####################################################################

  def self.build_string(me_string)
    sentence = translate_string(me_string)
    if sentence.split(" ").length > 5 && rand(5) == 0
      sentence = prepare_original_sentence(sentence) + " " + build_piratey_sentence
    end
    sentence
  end

  def self.translate_string(me_string)
    me_string.split(/ /).map do |word|
      capitalized = (word.slice(0,1) == word.slice(0,1).upcase)
      word = rails_present? ? piratize_with_pluralization(word) : piratize(word)
      capitalized ? capitalize_first(word) : word
    end.join(" ")
  end

  def self.piratize_with_pluralization(word)
    pluralized = word.pluralize == word
    if dictionary.has_key?(word.downcase.singularize)
      word = dictionary[word.downcase.singularize]
      word = pluralized ? word.pluralize : word
    end
    word
  end

  def self.piratize(word)
    dictionary.has_key?(word.downcase) ? dictionary[word.downcase] : word
  end

  def self.prepare_original_sentence(sentence)
    sentence.gsub!(/\.\z/, "")
    sentence = sentence + "." if sentence.match(/\w\z/)
    capitalize_first(sentence)
  end

  def self.build_piratey_sentence
    capitalize_first(sprinklings_of_flavor.sample) + ["!!","!","."].sample
  end

  def self.pirate_locale
    @@locale ||= local_config.has_key?("locale") ? local_config["locale"] : config["locale"]
  end

  def self.dictionary
    @@dictionary_map ||= config["dictionary"].merge(local_dictionary)
  end

  def self.sprinklings_of_flavor
    @@fill ||= (config["pirate_flavor"] << local_flavor).compact.flatten
  end

  def self.config
    @@config ||= YAML::load_file(File.dirname(__FILE__) + "/talk_like_a_pirate/pirate_booty.yml")
  end

  def self.local_dictionary
    local_config.has_key?("dictionary") ? local_config["dictionary"] : {}
  end

  def self.local_flavor
    local_config.has_key?("pirate_flavor") ? local_config["pirate_flavor"] : nil
  end

  def self.local_config
    @@local_configs ||= YAML::load_file("#{Rails.root.to_s}/config/pirate_booty.yml") rescue {}
  end

  def self.capitalize_first(string)
    return string unless string.is_a? String
    return string.upcase if string.length < 2
    string.slice(0,1).capitalize + string.slice(1..-1)
  end

  def self.rails_present?
    Object.const_defined? :Rails
  end

end

if Object.const_defined? :Rails
  require "talk_like_a_pirate/railties"
else
  require "yaml"
end
