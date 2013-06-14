require 'talk_like_a_pirate'

describe TalkLikeAPirate do

  it "should make a word piratey" do
    TalkLikeAPirate.translate('between').should == "betwixt"
  end

  it "shouldn't translate plural words without ActiveSupport" do
    TalkLikeAPirate.translate("islands").should == 'islands'
  end

  it "should make gerunds piratey" do
    TalkLikeAPirate.translate('having').should == "havin'"
  end

  it "should make plural gerunds piratey" do
    TalkLikeAPirate.translate('havings').should == "havin's"
  end

  it "should properly capitalize single words" do
    TalkLikeAPirate.translate('Boss').should == "Admiral"
  end

  it "should properly capitalize all caps words" do
    TalkLikeAPirate.translate('BOSS').should == "ADMIRAL"
    TalkLikeAPirate.translate('BOSS!!!!').should == "ADMIRAL!!!!"
  end

  it "should properly capitalize phrases" do
    TalkLikeAPirate.translate('Bourbon Country').should == "Rum Land"
    TalkLikeAPirate.translate('Bourbon country').should == "Rum land"
  end

  it "should properly translate words with trailing punctuation" do
    TalkLikeAPirate.translate('man!!!').should == "pirate!!!"
    TalkLikeAPirate.translate('man!?!?!?!').should == "pirate!?!?!?!"
  end

  it "should properly translate plural gerunds with trailing punctuation" do
    TalkLikeAPirate.translate('belongings!').should == "belongin's!"
  end

  it "should properly punctuate and translate words with leading and punctuation" do
    TalkLikeAPirate.translate('"The boss said kill."').should == '"Tha admiral said keelhaul."'
    TalkLikeAPirate.translate('"The boss said to kill the dude!"').split(" ")[0..6].join(" ").should == '"Tha admiral said t\' keelhaul tha pirate!"'
  end

  it "should translate plural words when ActiveSupport's available" do
    require "active_support"
    require "active_support/inflector"

    TalkLikeAPirate.translate("islands").should == 'isles'
    TalkLikeAPirate.translate("men").should == 'pirates'
  end

end
