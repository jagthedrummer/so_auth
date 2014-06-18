# SoAuth

A Rails engine that makes it easy to delegate authentication for a Rails
site to
[SoAuthProvider](https://github.com/jagthedrummer/so_auth_provider).
See the [SoAuthClient](https://github.com/jagthedrummer/so_auth_client)
project for an example of using this gem.

See [http://www.octolabs.com/so-auth](http://www.octolabs.com/so-auth)
for more details.


Usage
==============

## Add `so_auth` to the `Gemfile`

```ruby
gem 'so_auth'
```

## Generate an initializer

Run this command

```bash
rails generate so_auth:install
```

This will create the following files

```
config/initializers/omniauth.rb
```

## Create a new application in your `SoAuthProvider` instance

Go to the `/oauth/applications` endpoint on the `SoAuthProvider`
installation that you want to integrate with.  For development this will
probably be `http://localhost:3000/oauth/applications`.

Create a new application, and set the callback URL to
`http://localhost:3001/auth/so/callback`. Change the port if you
plan to run your client app on a different port. (See the optional
section below.)

After creating the app make note of the Application Id and the 
Secret.

## Set some environment variables for your client

In your new client project (where you installed this gem), you should
set some environment variables.  Using something like `foreman` is
probably the best so that you can just set them in a `.env` file.

```
AUTH_PROVIDER_URL=http://localhost:3000
AUTH_PROVIDER_APPLICATION_ID=1234
AUTH_PROVIDER_SECRET=5678
AUTH_PROVIDER_ME_URL=/oauth/me.json
```

Be sure to use the Application Id you got in the last step as
`AUTH_APPLICATION_APPLICATION_ID` and the Secret as `AUTH_APPLICATION_SECRET`.

## Create a `User` model

If you haven't already done it, you should create a `User` model

```bash
rails generate model user email:string
```

Then be sure to run migrations.

```bash
rake db:migrate; rake db:test:prepare
```

## Update `ApplicationController`

Change your `ApplicationController` to inherit from
`SoAuth::ApplicationController`. The first line should look like this.

```ruby
class ApplicationController < SoAuth::ApplicationController
```

## Protect some stuff in a controller

Use a `before_filter` to protect some controller actions.

```ruby
before_filter :login_required
```





## OPTIONAL : Change the default port of your new project

Since we're relying on `so_auth_provider` to provide authentication, we need
to run our new project on a different port in development.  Open up `config/boot.rb`
and add this to the bottom of the file.  If you want to use a port other
than `3001` just change the port as appropriate.

```ruby
# Setting default port to 3001
require 'rails/commands/server'
module Rails
  class Server
    alias :default_options_alias :default_options
    def default_options
      default_options_alias.merge!(:Port => 3001)
    end    
  end
end
```

Or you could just run your development server on a different port:

```
rails s -p 3001
```

or

```
unicorn -p 3001 -c ./config/unicorn.rb
```

or whatever.

This project rocks and uses MIT-LICENSE.
