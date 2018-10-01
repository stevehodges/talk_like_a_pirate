Ahoy, mateys!
=====

Translate English to Pirate on the fly! Delight yer users with the flavor of the high seas!

Plus, add a pirate translation layer to your Ruby or Rails app! Talk, like a Pirate!

This gem has been functional tested against a public domain version of The Bible (which may or may not be available as an e-book on Amazon.com...)

[![Gem Version](https://badge.fury.io/rb/talk_like_a_pirate.svg)](https://badge.fury.io/rb/talk_like_a_pirate)

----

    TalkLikeAPirate.translate("Today is a good day to die")
    => "Today is a jolly good day t' die"

If you pass in a sentence (and have a bit o' luck), you might get some extra piratey flavoring sprinkled on the end of your string!

Build a Pirate locale layer for i18n
----
Use i18n? The pirate rake task can generate a pirate locale (arr, by default) based on your English locale files.

    rake pirate:translate["config/locales"]

It'll iterate through all of your en.yml files in that location and build a pirate version. You can also specify a specific en.yml file to translate just that file!

Config
----
The pirate dictionary is fairly generic. You may have domain-specific lingo you think would be hillarious in pirate. So, add on to the dictionary!

You can generate a config file using the rake task:

  rake pirate:initialize

Or, add a config file at

  * Rails:
    config/pirate_booty.yml

  * Without Rails
    Specify the path to your YAML file in ENV['TALK_LIKE_A_PIRATE_CONFIG_PATH']

And format it like so (all keys are optional):

    locale: pirate     # This defaults to arr, but you can override it if you'd prefer a different locale string!
    dictionary:
      computer: voodoo
      bill: debt
      policies: creeds
      inventory: treasure chest

    pirate_flavor:         # the flavoring occasionally added to the ends of sentences
      - "T' Davy Jones' locker wit ya"

Using Ruby without Rails?
----
TalkLikeAPirate works great on Ruby (without Rails) as-is. 

If you want more sophistication in your translations, you can add the Rails ActiveSupport gem for translating singular and plural versions of words. In your project, be sure to:

    require "active_support"
    require "active_support/inflector"

Contributions
=====
Feel free to write specs, add to the standard dictionary, etc. Submit a pull request and we'll see what happens!

Tests
=====

To test the gem against the current version of ActiveSupport (in [Gemfile.lock](Gemfile.lock)):

1. `bundle install`
2. `bundle exec rspec`

Or, you can run tests for all supported Rails versions

1. `gem install appraisal`
1. `bundle exec appraisal install` *(this Generates gemfiles for all permutations of our dependencies, so you'll see lots of bundler output))*
1. `bundle exec appraisal rspec`. *(This runs rspec for each dependency permutation. If one fails, appraisal exits immediately and does not test permutations it hasn't gotten to yet. Tests are not considered passing until all permutations are passing)*

Credits
=====
Copyright (c) 2013, developed and maintained by Steve Hodges, and is released under the open MIT Licence
