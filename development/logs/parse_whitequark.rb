# log = WhitequarkParser.new("/Users/stefan/Documents/Development/Rails/RubyCommunity/no_git/index", "\#ruby".freeze).parse!

class WhitequarkParser
  Entry = Struct.new(:time, :type, :line, :compatibility, :channel, :from, :to, :message, :data) do
  end

  RTime                  = /(\d{4})-(\d\d)-(\d\d) (\d\d):(\d\d)/
  RMask                  = /[^!]*![^@]*@[^\] ]*/
  RMessage               = /\A#{RTime} <(\S+)> ([^\n]*)\n?\z/
  RAction                = /\A#{RTime} \* (\S+) ([^\n]*)\n?\z/
  RJoin                  = /\A#{RTime} (\S+) (?:has )?joined (\S+)\n?\z/
  RJoinWithMask          = /\A#{RTime} (\S+) \[(#{RMask})\] has joined (\S+)\n?\z/
  RQuit                  = /\A#{RTime} (\S+) has quit \[(.*)\]\n?\z/
  RQuitBroken            = /\A#{RTime} (\S+) has quit \[(.*)\n?\z/
  RNick                  = /\A#{RTime} (\S+) is now known as (\S+)\n?\z/
  RPart                  = /\A#{RTime} (\S+) left (\S+)\n?\z/
  RPartWithMessage       = /\A#{RTime} (\S+) has left (\S+) \[(.*)\]\n?\z/
  RPartWithMessageBroken = /\A#{RTime} (\S+) has left (\S+) \[(.*)\n?\z/
  RQuitWithMask          = /\A#{RTime} (\S+) \[(#{RMask})\] has quit \[(.*)\]\n?\z/
  RTopic                 = /\A#{RTime} Topic for (\S+) ?is now ([^\n]*)\n?\z/
  RKick                  = /\A#{RTime} (\S+)? was kicked by (\S+): ([^\n]*)\n?\z/
  RKickWithChannel       = /\A#{RTime} (\S+) was kicked from (\S+) by (\S+) \[([^\]]*)\]\n?\z/
  RChangeTopic           = /\A#{RTime} (\S+) changed the topic of (\S+) to: ([^\n]*)\n?\z/
  RBan                   = /\A#{RTime} (\S+) was banned on (\S+) by (\S+) \[([^\]]*)\]\n?\z/


  attr_reader :log_dir, :parsed, :errors, :log, :channel

  def initialize(log_dir, channel=nil)
    @log_dir = log_dir
    @parsed  = []
    @errors  = []
    @log     = []
    @channel = channel
  end

  def parse!
    previous=nil
    Dir.glob("#{@log_dir}/*").each do |path|
      base = File.basename(path)
      if base[/\A\d{4}-\d{2}/] != previous
        previous = base[/\A\d{4}-\d{2}/]
        puts previous
      end

      parse_file!(path)
    end

    self
  end

  def parse_file!(path)
    File.foreach(path) do |line|
      case line
        when RMessage               then process_message(line, *$~.captures)
        when RAction                then process_action(line, *$~.captures)
        when RJoin                  then process_join(line, *$~.captures)
        when RJoinWithMask          then process_join_with_mask(line, *$~.captures)
        when RQuit                  then process_quit(line, *$~.captures)
        when RQuitBroken            then process_quit(line, *$~.captures)
        when RNick                  then process_nick(line, *$~.captures)
        when RPart                  then process_part(line, *$~.captures)
        when RPartWithMessage       then process_part_with_message(line, *$~.captures)
        when RPartWithMessageBroken then process_part_with_message(line, *$~.captures)
        when RQuitWithMask          then process_quit_with_mask(line, *$~.captures)
        when RTopic                 then process_topic(line, *$~.captures)
        when RKick                  then process_kick(line, *$~.captures)
        when RKickWithChannel       then process_kick_with_channel(line, *$~.captures)
        when RChangeTopic           then process_change_topic(line, *$~.captures)
        when RBan                   then process_ban(line, *$~.captures)
        else
          puts "Could not identify line: #{line.inspect}"
          @errors << [path, line]
      end
    end
    @parsed << path
  end

  def process_join(line, year, month, day, hour, minute, nick, channel)
    time = Time.utc(Integer(year, 10), Integer(month, 10), Integer(day, 10), Integer(hour, 10), Integer(minute, 10))
    @log << Entry.new(time, :join, line, 0, channel, nick)
  end

  def process_join_with_mask(line, year, month, day, hour, minute, nick, mask, channel)
    time = Time.utc(Integer(year, 10), Integer(month, 10), Integer(day, 10), Integer(hour, 10), Integer(minute, 10))
    @log << Entry.new(time, :join, line, 0, channel, nick, nil, nil, mask: mask)
  end

  def process_part(line, year, month, day, hour, minute, nick, channel)
    time = Time.utc(Integer(year, 10), Integer(month, 10), Integer(day, 10), Integer(hour, 10), Integer(minute, 10))
    @log << Entry.new(time, :part, line, 0, channel, nick, nil, nil, nil)
  end

  def process_part_with_message(line, year, month, day, hour, minute, nick, channel, message)
    time = Time.utc(Integer(year, 10), Integer(month, 10), Integer(day, 10), Integer(hour, 10), Integer(minute, 10))
    @log << Entry.new(time, :part, line, 0, channel, nick, nil, message, nil)
  end

  def process_nick(line, year, month, day, hour, minute, nick, new_nick)
    time = Time.utc(Integer(year, 10), Integer(month, 10), Integer(day, 10), Integer(hour, 10), Integer(minute, 10))
    @log << Entry.new(time, :nick, line, 0, @channel, nick, nil, nil, new_nick: new_nick)
  end

  def process_quit(line, year, month, day, hour, minute, nick, message)
    time = Time.utc(Integer(year, 10), Integer(month, 10), Integer(day, 10), Integer(hour, 10), Integer(minute, 10))
    @log << Entry.new(time, :quit, line, 0, @channel, nick, nil, message, nil)
  end

  def process_quit_with_mask(line, year, month, day, hour, minute, nick, mask, message)
    time = Time.utc(Integer(year, 10), Integer(month, 10), Integer(day, 10), Integer(hour, 10), Integer(minute, 10))
    @log << Entry.new(time, :quit, line, 0, @channel, nick, nil, message, mask: mask)
  end

  def process_message(line, year, month, day, hour, minute, nick, message)
    time = Time.utc(Integer(year, 10), Integer(month, 10), Integer(day, 10), Integer(hour, 10), Integer(minute, 10))
    @log << Entry.new(time, :message, line, 0, @channel, nick, nil, message, nil)
  end

  def process_action(line, year, month, day, hour, minute, nick, message)
    time = Time.utc(Integer(year, 10), Integer(month, 10), Integer(day, 10), Integer(hour, 10), Integer(minute, 10))
    @log << Entry.new(time, :action, line, 0, @channel, nick, nil, message, nil)
  end

  def process_topic(line, year, month, day, hour, minute, channel, topic)
    time = Time.utc(Integer(year, 10), Integer(month, 10), Integer(day, 10), Integer(hour, 10), Integer(minute, 10))
    @log << Entry.new(time, :topic, line, 0, channel, nil, nil, topic, nil)
  end

  def process_change_topic(line, year, month, day, hour, minute, operator, channel, topic)
    time = Time.utc(Integer(year, 10), Integer(month, 10), Integer(day, 10), Integer(hour, 10), Integer(minute, 10))
    @log << Entry.new(time, :topic, line, 0, channel, operator, nil, topic, nil)
  end

  def process_kick(line, year, month, day, hour, minute, kicked, kicker, reason)
    time = Time.utc(Integer(year, 10), Integer(month, 10), Integer(day, 10), Integer(hour, 10), Integer(minute, 10))
    @log << Entry.new(time, :kick, line, 0, @channel, kicker, kicked, reason, nil)
  end

  def process_kick_with_channel(line, year, month, day, hour, minute, kicked, channel, kicker, reason)
    time = Time.utc(Integer(year, 10), Integer(month, 10), Integer(day, 10), Integer(hour, 10), Integer(minute, 10))
    @log << Entry.new(time, :kick, line, 0, channel, kicker, kicked, reason, nil)
  end

  def process_ban(line, year, month, day, hour, minute, banned, channel, banner, mask)
    time = Time.utc(Integer(year, 10), Integer(month, 10), Integer(day, 10), Integer(hour, 10), Integer(minute, 10))
    @log << Entry.new(time, :ban, line, 0, channel, banner, banned, nil, mask: mask)
  end

  def inspect
    "\#<#{self.class} #{@channel} #{@log.size} lines>"
  end
end


__END__
path = "/Users/stefan/Documents/Development/Rails/RubyCommunity/no_git/index/2015-01-30.txt"
paths = Dir.glob("/Users/stefan/Documents/Development/Rails/RubyCommunity/no_git/index/*"); 0


2015-02-23 00:02 workmad3 has joined #ruby
2015-02-23 00:01 ruthearle is now known as fruitedoots
2015-02-23 00:02 jottr_ has quit [Quit: WeeChat 1.1.1]
2015-02-23 00:43 <Cadillactica> Anybody have an idea?
2011-11-17 00:21 skrite left #ruby
2011-11-17 02:53 * any-key is a poor college student who cannot afford good internet :(
2011-11-17 15:13 Topic for #ruby is now Ruby programming language || ruby-lang.org || RUBY SUMMER OF CODE! rubysoc.org/ || Paste >3 lines of text in http://pastie.org || Para a nossa audiencia em portugues http://ruby-br.org/
2011-11-18 14:01  was kicked by apeiros_: you're a goner
2011-12-10 13:03 _whitelogger [_whitelogger!~whitelogg@2a00:ab00:1::4464:5550] has joined #ruby
2011-12-10 17:02 Blacktow3x [Blacktow3x!~Blacktow3@196.217.241.18] has quit [\"Quitte\"]
2012-01-29 18:26 moshef was kicked from #ruby by apeiros_ [should have done that right away]
2012-01-30 16:04 LnL [LnL!~LnL@d54C4DBC4.access.telenet.be] has quit [\"[self quit];\"]
2012-02-16 16:45 LnL has quit [\"[self quit];\"]
2012-03-12 23:16 apeiros_ changed the topic of #ruby to: programming language || ruby-lang.org || Paste >3 lines of text in http://pastie.org || Rails is in #rubyonrails
2012-04-12 14:04 CaoBranco has quit [\"
2012-05-12 23:25 fowlduck has left #ruby [#ruby]
2013-12-23 01:40 xk_id has left #ruby [\"
2014-08-02 12:35 fly2web was banned on #ruby by Mon_Ouie [*!~lee@*]
