Channel Bot
===========

* Find a name

### Commands

* !version +VERSION VERSION -VERSION
  +VERSION adds a version number in front
  -VERSION drops a version number
  VERSION updates VERSION with same major & minor
  E.g. with current topic: "Foo || Ruby 2.2.1; 2.1.5; 2.0.0-p643 || Bar", the command
  "!version +2.3.0 2.2.2 -2.0.0-p643" will change the topic to:
  "Foo || Ruby 2.3.0; 2.2.2; 2.1.5 || Bar"
* !rule DEFN [NICK]
  Will link the specified rule
* !faq DEFN [NICK]
  Will link the specified FAQ entry
* !kick NICK [REASON]
  Will kick the person with the given nick, log the recent conversation and log the kick
* !ban NICK DURATION [REASON]
  Will kick the person with the given nick, log the recent conversation and log the kick
  The duration can be given as minutes, hours, days or "-" for infinite. Example durations:

  * "30m" 30 minutes
  * "2h" 2 hours
  * "3d" 3 days
  * "-" forever

* !baninfo NICK
  Will reveal informations about the latest banning of the user with the given nick
* !revoke eval NICK
  Revokes eval rights from NICK.

* NICK++, NICK--, (thx|thanks|thank you) [NICK]
  Feed the karma system

* !karma [NICK]
  With a given nickname, emit the current karma of NICK. Without, emit top 3 karma in channel, top 20 in privmsg.

* \>\> CODE
  Evaluate ruby code.
  Eval rights are automatically revoked algorithmically (TODO: define algorithm)


### Automatic functions

* Channel logging (can we import the logs from whitequark?)
* ban with *!*@<IP>$##ruby-fix-your-connection upon rapid reconnects (TODO: define algorithm)
* revoke ban after ban-duration elapsed
* Recognition of dialogs and proper logging
* Greet first time visitors (account > nick+duration)
