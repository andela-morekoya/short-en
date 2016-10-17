[![Code Climate](https://codeclimate.com/github/andela-morekoya/short-en/badges/gpa.svg)](https://codeclimate.com/github/andela-morekoya/short-en)
[![Build Status](https://travis-ci.org/andela-morekoya/short-en.svg?branch=develop)](https://travis-ci.org/andela-morekoya/short-en)
[![Coverage Status](https://coveralls.io/repos/github/andela-morekoya/short-en/badge.svg?branch=develop)](https://coveralls.io/github/andela-morekoya/short-en?branch=develop)


#SHORT-EN
##Introduction

A URL shortening app built using Ruby on Rails

Thinking about that long and unwieldy website link? What do you do?

Try out [**Short-en**](https://ashort-en.herokuapp.com/). It will help reduce the length of the link and make it more preesentable

<hr>

##Table of Contents
* [Getting Started](#getting-started)
* [Features](#features)
* [Dependencies](#dependencies)
* [Limitations](#limitations)
* [Testing](#testing)


##Getting Started
Visit [**Short-en**](https://ashort-en.herokuapp.com/). Enter your url in the form on the homepage and click "Shorten" to get your shortened url.
To get the extra features as listed [here](#registered), become a registered user by clicking "Create an Account"


##Features
When you make use of [**Short-en**](https://ashort-en.herokuapp.com/) as an unregistered user who is not signed in to the web application, you are able to

* Shorten links - Links need to include the "http(s)://" part

* View recently created links

* View the most popular links on the site

* View the most influential users

You get even more when you become a <a name="registered"></a>registered user. In addition to the above features, you will also get

 * Use of Vanity Strings - Choose your shortened url by setting a vanity string

 * Edit your links - Change the target of the shortened url or delete them

 * Disable your shortened url so it is no longer acessible. Enable when you like

 * Easy access to all your links

 * Details on person that has used your link


##Dependencies
The external dependencies of this project include
 * Bootstrap
 * Bootstrap Switch
 * jQuery
 * clipboard.js


## Testing
RSpec with capybara was used for testing on this project. To run the tests,
 * Clone this repo
   `git clone https://github.com/andela-morekoya/short-en.git`
 * Navigate into the project folder
   `cd short-en`
 * Install the project's gems
   `bundle install`
 * Setup the databases
   `rake db:setup`
 * Run rspec
   `bundle exec rspec`


##Limitations
 * Vanity string cannot be phrases - spaces in phrases are replaced with underscores
 * URLs must begin with http:// or https://
 * There is no check for duplicated URLs
 * There is no API
