Bang methods
============

What does !, ?, = at the end of a method name mean?

* It's part of the method name
* Methods ending in ? should not have a side effect[link] and return true/false
* Methods ending in = should set a state in the object.
* Note that methods ending in = will always return the RHS[link] - except if used e.g. with .public_send
* A ! at the end of a method means (as per matz[link] himself[citation needed]) "be careful"
* Bang methods are often paired with non-bang methods, in that case it means the non-bang method will
  not modify the receiver[link], but return a new, modified object. The bang method will modify the receiver.
* Note that many bang methods in ruby core will return nil if the receiver did not change
* Rule of thumb: don't chain on bang methods
* Also a rule of thumb: don't mutate arguments
