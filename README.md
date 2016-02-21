# A Virtual Machine for Ruby on Rails Web Application Development

## Introduction

This vagrant box project is meant to be shipped within a rails app in a directory that might be called `.vgt`,
so your rails app directory structure would be as follows:

```
    -app_name
    ---.vgt
    -----Vagrantfile
    -----provision
    -------bootstrap.sh
    ---app
    ---bin
    ---...
```

Inspired by fxn's [rails-dev-box](https://github.com/rails/rails-dev-box)

** Note: this VM is based on Ubuntu 14.04 64-bit (trusty64) / Vagrant / VirtualBox. **

## Requirements

* [VirtualBox](https://www.virtualbox.org)
* [Vagrant](http://vagrantup.com)

## Steps

```
    1.- create the directory that will hold your app directory structure.
        
        mkdir app_name
    
    2.- cd to recently created app directory.
    
        cd app_name
        
    3.- clone vgtbox repo and clean after by executing 'vgtbox-clean' script that will be inside .vgt/bin.
    
        windows:
        git clone https://github.com/ebratini/rails-devbox.git . & .vgt\bin\vgtbox-clean.bat

        linux:
        git clone https://github.com/ebratini/rails-devbox.git . && .vgt/bin/vgtbox-clean.sh

    4.- cd to vgtbox project home '.vgt'
    
        host$ cd .vgt
    
    5.- in 'Vagrantfile' set/update '$APP_NAME' variable with your rails app name, for the following steps, replace $APP_NAME with it.
    6.- do vagrant up:
    
        host$ vagrant up
        
    6.- do vagrant ssh:
    
        host$ vagrant ssh $APP_NAME.dev
        
    7.- cd to '/home/workspace/$APP_NAME' # check 'Vagrantfile' to see vagrant synced folders
        
        guest$ cd /home/workspace/$APP_NAME
    
    8.- create your rails app:
    
        guest$ rails new .  # Notice the period at the end telling it to use current directory instead of creating a subdirectory

    9.- you're ready to go!.
```

Port 3000 in the host computer is forwarded to port 3000 in the virtual machine (guest). Thus, the application running in the virtual machine can be accessed via localhost:3000 in the host computer. Be sure the web server is bound to the IP 0.0.0.0, instead of 127.0.0.1, so it can access all interfaces:

    bin/rails server -b 0.0.0.0

## What's In The Box

* Git
* Heroku Toolbelt
* Node.js (ExecJS runtime)
* SQLite3, MySQL, and Postgres
* RVM (with ruby 2.2.2 installed)
* Bundler, Rails and Rake gems for the installed ruby


## Recommended Workflow

* edit files in the host computer
* run within the virtual machine

## Virtual Machine Management

When done just log out with `^D` and suspend the virtual machine

    host$ vagrant suspend

then, resume to hack again

    host$ vagrant resume

Run

    host$ vagrant halt

to shutdown the virtual machine, and

    host$ vagrant up

to boot it again.

You can find out the state of a virtual machine anytime by invoking

    host$ vagrant status

Finally, to completely wipe the virtual machine from the disk **destroying all its contents**:

    host$ vagrant destroy # DANGER: all will be gone

Please check the [Vagrant documentation](http://vagrantup.com/v1/docs/index.html) for more information on Vagrant.