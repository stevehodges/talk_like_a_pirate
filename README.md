Ahoy, mateys!
=====

Delight yer users with the flavor of the high seas!

Add a pirate translation layer to your Rails app! Talk, like a Pirate!

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
The pirate dictionary is fairly generic. You my have domain-specific lingo you think would be fucking hillarious in pirate. So, add on to the dictionary!

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

Contributions
=====
Feel free to write specs, add to the standard dictionary, etc. Submit a pull request and we'll see what happens!
