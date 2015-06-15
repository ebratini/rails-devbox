#!/bin/bash
## installs goal
## Git
## Heroku Toolbelt
## Node.js (ExecJS runtime)
## SQLite3, MySQL, and Postgres
## RVM (with ruby 2.2.2 installed)
## Bundler, Rails and Rake gems for the installed ruby

# configuration variables with default values
RUBY_VERSION = 2.2.2
RAILS_VERSION = 4.2.1

# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
  echo installing $1
  shift
  apt-get -y install "$@" >/dev/null 2>&1
}

# Exit on error
set -e

# updating package info
sudo apt-get update

# installing dev tools
install 'development tools' build-essential curl zlib1g-dev libssl-dev libreadline-dev libyaml-dev
install 'development tools' dudolibxml2-dev libxslt1-dev libcurl4-openssl-dev libffi-dev libgdbm-dev
install 'development tools' python-software-properties libncurses5-dev automake libtool bison

# installing git
install Git git

# installing heroku toolbelt
echo '..installing heroku toolbelt'
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# installing node.js (execjs runtime)
install 'Node.js (ExecJS runtime)' nodejs

# installing SQLite3, MySQL, and Postgres
## installing sqlite3
install SQLite sqlite3 libsqlite3-dev

## installing MySQL
install MySQL mysql-server libmysqlclient-dev

## installing postgresql
install PostgreSQL postgresql postgresql-contrib libpq-dev

### create postgresql user with the name: vgt
sudo -u postgres createuser --superuser vgt

### Password is also - vgt
sudo -u postgres psql

# installing rvm and ruby RUBY_VERSION
echo "..installing rvm and ruby $RUBY_VERSION"
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm

rvm requirements
rvm install $RUBY_VERSION
rvm use $RUBY_VERSION --default
ruby -v

# installing gems: bundler, rails and rake
echo '..installing gem bundler'
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler
bundler -v

echo "..installing rails $RAILS_VERSION"
gem install rails -v $RAILS_VERSION
rails -v

echo '..installing rake'
gem install rake
rake --version


echo "done! you're ready to go."