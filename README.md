Ahoy, mateys!
=====

Delight yer users with the flavor of the high seas!

Add a pirate translation layer to your Ruby or Rails app! Talk, like a Pirate!

Try the gem out on [Ahoy Mat.ee](http://www.ahoymat.ee "Translate web pages into pirate"), which allows you to translate any page on the public internets.

Translate English to Pirate on the fly!
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
The pirate dictionary is fairly generic. You may have domain-specific lingo you think would be fucking hillarious in pirate. So, add on to the dictionary!

Add a config file at

    config/pirate_booty.yml

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

And, due to dependency weirdness in ActiveSupport, you'll also need the i18n gem installed. So, in your Gemfile:

    gem 'activesupport', '~> 3.0.0'
    gem 'i18n'

Contributions
=====
Feel free to write specs, add to the standard dictionary, etc. Submit a pull request and we'll see what happens!

Credits
=====
Copyright (c) 2013, developed and maintained by Steve Hodges, and is released under the open MIT Licence
