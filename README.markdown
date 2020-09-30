README
======


### Website

[ruby-community.com](http://ruby-community.com)


### Setup

* Ruby version: >= 2.3.0
* System dependencies: PostgreSQL v. 9.4+
* Configuration:
  * `cp config/database.example.yml config/database.yml`
  * `cp config/secrets.example.yml config/secrets.yml`
* Database creation: `rake db:migrate`
* Database initialization: `rake db:seed`
* Some data resides in db/data. You can load it using `psql -f`. Take a look at db/data/README.markdown.
* How to run the test suite: no test suite so far.

If you also want to test the private section, you have to additionally do:

* add "127.0.0.1 ruby-community" to your /etc/hosts (it can be on the same line as "127.0.0.1 localhost", e.g. "127.0.0.1 localhost ruby-community").
* go to your github profile > applications, there click the "Developer applications" tab, then hit the "Register new application" button.
* Fill out "Application Name", "Homepage URL", "Application Description" with whatever you want, they do not matter.
* Fill out "Authorization callback URL" with "http://ruby-community:3000/users/auth/github/callback".
* Update your config/secrets.yml with Client-ID (github_app) and Client Secret (github_secret) which github shows you.
* Restart your server and open it as "http://ruby-community:3000/" in your browser (NOT as "http://127.0.0.1:3000" or "http://localhost:3000/, the login will not work there").

Take also a look at the "Contribute" section below.


### Contribute

We are happy about everybody who helps contributing.
The following should help you and us with your contribution:

* Please follow the Code of Conduct below.
* We are located in IRC on freenode.net in the [#ruby-community](irc://irc.freenode.net/#ruby-community) channel.
* The core contributors are listed in this README under Contributors
* Fork the repository on https://github.com/ruby-community/ruby-community
* Provide your contributions as Pull Requests
* Please follow the code style listed in PROJECT/development/Contribute/Code_style.markdown
* The file suffixes are .yaml, .markdown, .html.slim
* We use bootstrap, sass and slim


### Contributor Code of Conduct

As contributors and maintainers of this project, we pledge to respect all people who
contribute through reporting issues, posting feature requests, updating documentation,
submitting pull requests or patches, and other activities.

We are committed to making participation in this project a harassment-free experience for
everyone, regardless of the level of experience, gender, gender identity, and expression,
sexual orientation, disability, personal appearance, body size, race, ethnicity, age, or religion.

Examples of unacceptable behavior by participants include the use of sexual language or
imagery, derogatory comments or personal attacks, trolling, public or private harassment,
insults, or other unprofessional conduct.

Project maintainers have the right and responsibility to remove, edit, or reject comments,
commits, code, wiki edits, issues, and other contributions that are not aligned to this
Code of Conduct. Project maintainers who do not follow the Code of Conduct may be removed
from the project team.

Instances of abusive, harassing or otherwise unacceptable behavior may be reported by
opening an issue or contacting one or more of the project maintainers.

This Code of Conduct is adapted from the [Contributor Covenant, version 1.0.0](http://contributor-covenant.org/version/1/0/0/)


### Contributors

In alphabetical order:

* [apeiros](https://github.com/apeiros)
* [atmosx](https://github.com/atmosx)
* [c-c](https://github.com/csmr)
* [jhass](https://github.com/jhass)
* [jheg](https://github.com/jheg)
* [miah](https://github.com/miah)
* [mikecmpbll](https://github.com/mikecmpbll)
* [workmad3](https://github.com/workmad3)
