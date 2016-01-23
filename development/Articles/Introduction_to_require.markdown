15:30 apeiros: ruby convention is: put all files in lib/, have names map the constants like Foo::BarBaz -> foo/barbaz.rb
15:31 apeiros: rails convention slightly deviates in that convention and uses Foo::BarBaz -> foo/bar_baz.rb
15:31 ddv: piece of c...
15:31 Macaveli has left IRC (Quit: Textual IRC Client: www.textualapp.com)
15:31 shevy: those monsters!
15:31 hxegon has joined (~textual@198.8.80.194)
15:31 apeiros: while testing, make sure your $LOAD_PATH is set up properly, usually you do that by e.g. -I (capital i, not lowercase L): ruby -Ilib bin/your_executable
15:32 User458764 has joined (~textual@lns-bzn-48f-62-147-220-187.adsl.proxad.net)
15:32 apeiros: and in the files, you require in each file what you need, relative to the lib dir. e.g. if foo.rb, which defines Foo, you need Foo::BarBaz, you have on top of the file `require 'foo/bar_baz.rb'`
15:32 sgambino has left IRC (Quit: My Mac has gone to sleep. ZZZzzz…)
15:32 apeiros: that's all.
15:32 prestorium: apeiros, hmmm what about appending '../lib' to $LOAD_PATH inside my bin/exe?
15:33 apeiros: generally should not do that since you'll want to make your thing a gem. and gem handles that for you.
15:33 apeiros: so fixing the $LOAD_PATH in the executable can be counterproductive.
15:34 apeiros: personally I use 2 lines of code in my exes, one which tests whether ../lib exists, and if so, adds it to $LOAD_PATH. that's borderline acceptable.
