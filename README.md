[![Code Climate](https://codeclimate.com/github/andela-morekoya/short-en/badges/gpa.svg)](https://codeclimate.com/github/andela-morekoya/short-en)
[![Coverage Status](https://coveralls.io/repos/github/andela-morekoya/short-en/badge.svg?branch=master)](https://coveralls.io/github/andela-morekoya/short-en?branch=master)

#SHORT-EN

A URL shortening app built using Ruby on Rails

When you have to send a website link that is long and unwieldy, what do you do?

Try out Short-en. It will help reduce the length of the link and make it more preesentable

##Features
As a user who is not signed in to the app, you are able to

* Shorten links - Links need to include the "http(s)://" part

* View recently created links

* View the most popular links on the site

* View the most influential users

When you sign up for the the Short-en service, in addition to the above features, you will also get

 * Use of Vanity Strings - Set what you want your shortened url to be

 * Edit your links - Change the target of the shortened link

 * Easy access to all you links

 ## Go to https://ashort-en.herokuapp.com/ to start using Short-en

The app does not provide statistics currently. This feature is under implementation

# Running the app locally

Make sure you are using ruby 2.3.1

* Clone this app: ```git clone https://github.com/andela-morekoya/short-en.git```

* Install the required gems and dependencies ```bundle install```

* Setup the database ```rake db:setup```

* Start your server and navigate to the specified port on your localhost ```rails s```

## Testing
RSpec was used for testing on this project.


