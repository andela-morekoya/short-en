[![Code Climate](https://codeclimate.com/github/andela-morekoya/short-en/badges/gpa.svg)](https://codeclimate.com/github/andela-morekoya/short-en)
[![Build Status](https://travis-ci.org/andela-morekoya/short-en.svg?branch=develop)](https://travis-ci.org/andela-morekoya/short-en)
[![Coverage Status](https://coveralls.io/repos/github/andela-morekoya/short-en/badge.svg?branch=master)](https://coveralls.io/github/andela-morekoya/short-en?branch=master)


#SHORT-EN
##Introduction

>A URL shortening app built using Ruby on Rails

>Thinking about that long and unwieldy website link? What do you do?

>Try out [**Short-en**](https://ashort-en.herokuapp.com/). It will help reduce the length of the link and make it more preesentable

<hr>

##Table of Contents
* [Features](#features)
* [Limitations](#limitations)
* [Testing](#testing)


##Features
When you make use of [**Short-en**](https://ashort-en.herokuapp.com/) as an unregistered user who is not signed in to the web application, you are able to

* Shorten links - Links need to include the "http(s)://" part

* View recently created links

* View the most popular links on the site

* View the most influential users

You get even more when you become a registered user. In addition to the above features, you will also get

 * Use of Vanity Strings - Set what you want your shortened url to be

 * Edit your links - Change the target of the shortened url or delete them
 
 * Disable your shortened url so it is no longer acessible. Enable when you like

 * Easy access to all your links

 * Details on person that has used your link


 ##Limitations
 * Vanity string cannot be phrases - spaces in phrases are replaced with underscores
 * Developers cannot interact with the application on the backend


## Testing
RSpec was used for testing on this project. The documention is as follows

####Feature Tests
**Anonymous User Features**
User visits site
- lists URLs sorted by popularity
- lists URLs sorted by how recently they were added
- lists influential users
- enters valid url
 - returns a service shortened URL
- enters an invalid Url
 - gives an invalid url error

**Registered User Features**
User visits site
- enters valid url with vanity string
 - returns a service shortened URL with specified vanity
- visit user page
 - lists of all user's service shortened URLs
 - gives links to each url detail page
- view a shortened URL details page
 - gives details about each individual who has used the URL

####Model Tests
**Link**
- is valid with a full original url and a user ID
- is invalid without a valid original url
- is invalid without a user ID
- generates a short url when given a full url
- returns the slug as a url

**User**
- should validate that :username cannot be empty/falsy
- should validate that :username is case-insensitively unique
- should validate that :email cannot be empty/falsy
- should validate that :email is case-insensitively unique
- should allow :email to be ‹"email@valid.com"›
- should not allow :email to be ‹"email@invalid"›
- should have a secure password
- should validate that the length of :password is at least 6
- should have many links

**Visit**
- should belong to user
- should belong to link

####Controller Tests
**LinksController**
- before actions
 - should have :authenticate as a before_action
- should have :set_link as a before_action
- should have :my_links as a before_action
- GET "#show"
 - redirects slug to original url
- POST "#create"
 - with invalid params
   - should raise error

**UsersController**
- GET #new
 - shows the create account page
- POST #create
 - creates valid user

**WelcomeController**
 - GET #index
  - displays welcome page
