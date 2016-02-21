#!/bin/bash
## installs goal
## Git
## Heroku Toolbelt
## Node.js (ExecJS runtime)
## SQLite3, MySQL, and Postgres
## RVM (with ruby 2.2.2 installed)
## Bundler, Rails and Rake gems for the installed ruby

# configuration variables with default values
RUBY_VERSION=2.2.2
RAILS_VERSION=4.2.4

# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
  echo "..installing $1"
  shift
  sudo apt-get -y install "$@" >/dev/null 2>&1
}

# Exit on error
set -e

# updating package info
echo '..updating package info'
sudo apt-get update >/dev/null 2>&1

# installing dev tools
#                           libgmp-dev to troubleshoot issue with rvm/nokogiri gem install when installing rails
install 'development tools' build-essential patch curl ruby-dev zlib1g-dev liblzma-dev libgmp-dev libssl-dev
install 'development tools' libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev libtool
install 'development tools' libffi-dev libgdbm-dev python-software-properties libncurses5-dev automake bison

# installing git
install Git git

# installing heroku toolbelt
echo '..installing heroku toolbelt'
sudo wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh >/dev/null 2>&1

# installing node.js (execjs runtime)
install 'Node.js (ExecJS runtime)' nodejs

# installing SQLite3, MySQL, and Postgres
## installing sqlite3
install 'SQLite' sqlite3 libsqlite3-dev

## installing MySQL
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
install 'MySQL' mysql-server libmysqlclient-dev

## installing postgresql
install 'PostgreSQL' postgresql postgresql-contrib libpq-dev

### create postgresql user with the name: vgt
sudo -u postgres createuser --superuser $USER

### Password is also - $USER
sudo -u postgres psql

# troubleshooting rvm/nokogiri gem install issue when installing rails
# export NOKOGIRI_USE_SYSTEM_LIBRARIES=1

# installing rvm and ruby RUBY_VERSION
echo "..installing rvm and ruby $RUBY_VERSION"
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm

rvm requirements
rvm install $RUBY_VERSION # --disable-binary # disabling binaries troubleshooting rvm/nokogiri gem install issue
rvm use $RUBY_VERSION --default
ruby -v

# installing gems: bundler, rails and rake
echo '..installing gem bundler'
echo 'gem: --no-ri --no-rdoc' > ~/.gemrc
gem install bundler
bundler -v

echo "..installing rails $RAILS_VERSION"
gem install rails -v $RAILS_VERSION
rails -v

echo '..installing rake'
gem install rake
rake --version

echo "done! you're ready to go."
