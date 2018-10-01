require 'talk_like_a_pirate'

# TODO: Test Rails integration/railties/rake task

describe TalkLikeAPirate do
  def execute(string)
    TalkLikeAPirate.translate(string)
  end

  it "makes a word piratey" do
    expect(execute('between')).to eq "betwixt"
  end

  it "shouldn't translate plural words without ActiveSupport" do
    expect(execute("islands")).to eq 'islands'
  end

  it "makes gerunds piratey" do
    expect(execute('having')).to eq "havin'"
  end

  it "makes plural gerunds piratey" do
    expect(execute('havings')).to eq "havin's"
  end

  it "properly capitalizes single words" do
    expect(execute('Boss')).to eq "Admiral"
  end

  it "properly capitalizes all caps words" do
    expect(execute('BOSS')).to eq "ADMIRAL"
    expect(execute('BOSS!!!!')).to eq "ADMIRAL!!!!"
  end

  it "properly capitalizes phrases" do
    expect(execute('Bourbon Country')).to eq "Rum Land"
    expect(execute('Bourbon country')).to eq "Rum land"
  end

  it "properly translates words with trailing punctuation" do
    expect(execute('man!!!')).to eq "pirate!!!"
    expect(execute('man!?!?!?!')).to eq "pirate!?!?!?!"
  end

  it "properly translates plural gerunds with trailing punctuation" do
    expect(execute('belongings!')).to eq "belongin's!"
  end

  it "properly punctuates and translates words with leading and punctuation" do
    expect(execute('"The boss said kill."')).to eq '"Tha admiral said keelhaul."'
    expect(execute('"The boss said to kill the dude!"')).to eq '"Tha admiral said t\' keelhaul tha pirate!"'
  end

  it "translates plural words when ActiveSupport's available" do
    require "active_support"
    require "active_support/inflector"

    expect(execute("islands")).to eq 'isles'
    expect(execute("men")).to eq 'pirates'
  end
end
