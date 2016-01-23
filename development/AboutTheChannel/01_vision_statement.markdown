VISION FOR #RUBY
================

This document describes my personal vision for #ruby - what I'd like to achieve
with the channel and how. All of it can - of course - be discussed. This is
"just" a sketch of my ideas.  
I think it should be possible to get most, if not all implemented until the end
of 2015. I don't think that we need to hurry. The situation is already better
now than it has been for the last 10 years.


Ends
----

* A channel from the community for the community
* A welcoming channel people enjoy
* Diversity is welcome and fostered
* Newbies are welcome and fostered
* Pro users lift newbies
* Low barrier (as means to foster newbies)
* No trolls, no harassment
* Transparent leadership
* An active op team, covering all timezones
* Collaboration of channel members to work for the future of the #ruby channel

I'm quite serious about the first point. To me, once we have a reasonable way to
determine who may vote, everything is up for vote. Even my own status as founder
and/or op.


Means to those ends
-------------------

* At least 3 present ops at all times (present = online and actively checking irc)
* A channel bot (ruboto) to facilitate and automate various tasks
* Channel code of conduct, rules and policies
* #ruby-ops companion channel for ops
* #ruby-community companion channel for volunteers to work on companion website, bot and policies
* #ruby-banned companion channel for redirection of banned users to enable communication with them
* A companion website to cover common/frequent tasks and information

### ruboto, the channelbot

* eval code (easier support)
* collect messages for log on website
* collect statistics for website
* collect kick/ban reasons
* collect changes on lists (mute/ban/access-list)
* collect activity statistics (to determine [active users] [1] and [active ops] [2])
* enable a karma system
* provide factoids
* link to FAQ
* link to articles
* enable polls among active channel [users] [1]
* automatically kick rejoin-/message-/nickchange-/capslock-flooders
* automatically transfer pastebin to gist and inform the pastebin user (+other services)
* kick (automatic message to #ruby-ops)
* ban (automatic message to #ruby-ops, automatic information in #ruby-banned on join)
* Short-Cuts for common ban reasons: !troll, !spam, !flood, !behavior, …
* query for ops and inform them about a problem
* add new ops (adding them to access-list, registering their github nick, adding to invite list in #ruby-ops)
* remove ops
* inform users in #ruby-banned about their ban reasons and assist them to become unbanned
* inform about cross-posters
* link to user-specific log (as an opper tool)
* history services (pm full #ruby-ops history for ops, partial history for any user in #ruby/#ruby-community/#ruby-banned)


### The #ruby-ops channel

* For private exchange among ops regarding opper topics
* For peer review & ops internal feedback
* For information about opper events/actions
  * Upon kick -> short dialogue excerpt from the preceding interaction + the kick-reason
  * Upon mute -> short dialogue excerpt from the preceding interaction + the mute-reason + duration
  * Upon ban  -> short dialogue excerpt from the preceding interaction + the ban-reason + duration
  * Upon detection of filter triggers (insults, all uppercase) -> the message in question
  * Removal of ban
  * Adding of op
  * Removal of op
  * Ongoing votes


### The #ruby-community channel

* Talk about & coordinate development of ruby-community.com
* Talk about & coordinate development of ruboto
* Talk about past, current and future policies in #ruby


### The #ruby-banned channel

* Automatically inform/remind users on first join (TODO: and maybe in intervals?) about their ban reason
* Allow banned people to talk to ops about their ban, to potentially get their ban revoked (TODO: guidelines?)
* 


### The companion website

* Channel rules
* Code of Conduct (subset of channel rules - mainly to existing to facilitate finding the CoC, since some people look explicitly for that)
* Operators and their common presence times
* Channel log
* Channel statistics
* IRC basics
  * Nickname registration
  * explanation of JOIN/PART/AWAY/SASL/Bouncer/PRIVMSG vs NOTICE
  * explanation of how to reach the ops
  * explanation of public bot commands
* FAQ
* Articles about difficult topics
* Operator section
  * Kick/Ban/Mute reasons & history
  * Repeat offenders / reprimanded users
  * Channel wide decisions / votes / polls
  * Explanation of opper bot commands
  * Explanation of opper irc commands (kick/ban/topic, masks)

* \#ruby-banned channel for redirect of banned people, so they have a way to inquiry for the ban reason

### Policies

* Allow users to accumulate and lose karma (basic message patterns, like `/PRIVMSG #ruby Nick[:,- ]*(\+\+|--)`, `/PRIVMSG #ruby Nick[:,- ]+ (?:\b(?:thanks|thx|ty)\b)`)
* Remove inactive ops (e.g. ops which do not visit #ruby for more than 3 months)
* Invite active + karma positive users to become ops (intended as means/source to draft more ops, not as a requirement for new ops)
* Invite active + karma positive users to #ruby-pro
* Actively peer-review op actions (ops are humans, peer review can reduce stress, provide feedback, improve actions of individuals and allow the whole team to come up with strategies to common events)
* (TODO: Guideline to ban durations)
* (TODO: Mark Users who participate in votes? Karma?)


Guidelines - Users
------------------

* See http://ruby-community.com/pages/user_rules
* See http://ruby-community.com/pages/code_of_conduct (currently for contribution only - will be adapted for channel behavior)
* Q: What should I do when somebody is harrassing me and I can't resolve it myself?  
  A: Use !ops to inform ops. Let ops handle it.  
  Do NOT under any circumstances insult/attack the offender. This forces ops to remove you from the channel too.  
  We do our best to react quickly. Until an op can react, we suggest to use the /ignore command of your client.
* Q: I don't speak english. Somebody speak <LANGUAGE>?
  A: Ask "could somebody speaking <LANGUAGE> please join #ruby-<LANGUAGE> to help me?". We would like to keep
  #ruby in english. And we think strengthening local channels is better than having a potpourri of languages in #ruby.  
  You can find a [list of local channels here](TODO)


Guidelines - Ops
----------------

I think those guidelines should be kept in the non-public ops section of the community website.

* Ops ensure that channel rules and CoC are followed
* Ops are required to be active [2], else their op status is revoked (reappointment is possible)
* Ops are required to idle in #ruby-ops
* Ops are suggested to idle in #ruby-banned
* When a user wants to discuss their ban, he must do so in #ruby-banned.  
  * The op must not discuss the ban in their query.  
  * The op must instruct the user to join #ruby-banned and discuss the ban reason there.  
  * The op must inform the user that the channel is logged (TODO: not necessary if kick/ban issued by bot as that'll be part of the message?).
* Reasons for kick/ban are not discussed in #ruby. Parties interested in discussing that shall be advised to join #ruby-banned and discuss there. Not following that request should result in a 5min ban.  
  Rationale: #ruby is not a stage for anybody's stance on politics. Engagement in channel rules and policing is welcome. But #ruby is the wrong place.  
  To discuss policies, the party is invited to visit #ruby-community.
* If you're uncertain about a kick/ban, consult other ops in #ruby-ops
* Ops are required to peer review other op's actions (decide on specifics - how often? how are reviewers chosen? how are controversies escalated?)
* When a user disagrees with their banning, the op must inform the user about how to escalate their concern
* An op must carry decisions from votes
* (TODO - yes/no/how?) Ops are required to mark their away status (how? /away? /nick *|away?) - purpose: !ops only invokes present ops


Introduction, Change and Removal of Policies
--------------------------------------------

This section describes the processes for how policies are introduced, changed and removed.

* Any founder can introduce, change or remove a policy immediately in situations of urgency. The new policy must be subsequently voted upon (TODO: define maximum period until mandatory vote or reversal).
* Any founder can call for a vote for the introduction, change or removal of a policy.
* A group of 3 or more ops can call for a vote for the introduction, change or removal of a policy.
* A group of 10 or more channel members can call for a vote for the introduction, change or removal of a policy.
* A vote must pass supermajority of two thirds (rounded down) of all participants to be accepted. (Participants = sum of pro + contra + abstention)
* (TODO define period of announcement, define period of voting)
* Founders and ops are required to participate in at least 3 of 4 votings
* (TODO: weight of vote - all same? founders/ops higher? karma higher? other crowdsourcing methods of voting? add randomness similar to slashdot's karma system?)


Notes
-----

* In cases where an immediate action seems necessary, I'm pro "don't ask for permission, ask for forgiveness".
  But any actions implemented in such a situation should be communicated via #ruby-ops.
* I'm uncertain about how far ops should educate users with regards to their behavior. I.e. whether they should simply
  enforce the rules or also educate them.
* Allowing only active users to vote is a way to mitigate the risk of an offender taking over control by just mass registering users and abuse the vote process
* Requiring ops to be active is meant as a way to "garbage collect". It makes it easier to keep an overview and makes it easier for users in need to approach an op.
* Stretch goal: once this document is implemented for #ruby, approach #ruby.TLD/#ruby-TLD channels and offer integration into the mechanics. Require normalization of channel name (e.g. always #ruby.TLD and have #ruby-TLD redirect - or other way round)
* Offtopic ruby channel? E.g. #ruby-offtopic? I'm not opposed to it, but I wouldn't want to be responsible for it.


TODO
----

* Evaluate potentially exploitable weaknesses in policies, voting and karma and how to resolve those
* Determine impact of kick/ban on karma
* Determine expiration of karma
* Ponder slashdot style introduction of chance into karma system to harden it against targeted abuse/exploitation
* Ponder slashdot style introduction of chance into voting system to harden it against targeted abuse/exploitation
* Add Crowdsource kick/temporary ban policy


Footnotes
---------

* [1]: Active user: registered user. Authname messages to channel more than N times during the last K days (suggestion: N=100, K=90)
* [2]: Active op: op who was online and wrote at least one message during the last N days, and participated in the last K of J channel polls - explicit abstention counts as participation. Announced vacations are exempt. (suggestion: N=90, K=3, J=4)
