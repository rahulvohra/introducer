#!/usr/bin/env ruby

class IntroTweeter

  def initialize(arguments, stdin)
    @arguments = arguments
    @stdin = stdin
  end

  def run
    if arguments_valid?
      puts introduce(@arguments.first).join("\n\n")
    else
      puts "Usage: intro [username]"
    end
  end

  protected
  
  def arguments_valid?
    true if @arguments.length == 1
  end
  
  def names
    File.open("regulars.txt", "r") do |f|
      f.readlines.map(&:strip)
    end
  end
  
  def prefix(new_name, count)
    "@#{new_name} please meet the http://MalazanTweeps.com Regulars (#{count}):"
  end
  
  def introduce(new_name)
    tweets = []
    count = 1
    tweet = prefix(new_name, count)
    
    names.sort_by { rand }.each do |name|
      if (tweet + " " + name).length <= 140
        tweet += " " + name
      else
        tweets << tweet
        count += 1
        tweet = prefix(new_name, count)
      end
    end
    
    tweets
  end

end

app = IntroTweeter.new(ARGV, STDIN)
app.run