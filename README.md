# Microblog
A full-stack microblog built using Ruby on Rails and AngularJS, loosely inspired by the [RoR tutorial by Michael Hartl](http://apionrails.icalialabs.com/book/).

## Project structure
### Ruby API
The API, developed using Ruby on Rails, is defined in `api/` where the interesting folders and files mainly are:  
`api/app/controllers`  
`api/app/models`  
`api/app/views`  
`api/db/schema.rb`  
`api/test/controllers`  
`api/test/models`  

### AngularJS single-page app
The interface can be found in `public/` and is a single-page app in AngularJS comunicating with the API. The most interesting folders are:  
`public/app/scripts/controllers`  
`public/app/scripts/services`  
`public/app/styles`  
`public/app/views`

## Run Ruby server locally
### Make sure to have installed
- ruby 3.2.0 (or higher)
- rails 5.0.0 (or higher)

### Install dependencies
`cd api/`  
`bundle install`

### Create db and migrate schema
`rake db:create`  
`rake db:migrate`

### Add a secret (for Rails > 4)
Generate a random secret key value:  
`bundle exec rake secret`  
Copy the generated value and put it in config/initializers/secret_token.rb:  
`Microblog::Application.config.secret_key_base = 'your-secret'`

### Run server
`rails s`

## Run node.js server locally
### Make sure to have installed
- node
- npm
- yo
- grunt
- bower
- compass (gem install compass)

### Install dependencies
`cd public/`  
`npm install`  
`bower update`

### Run server
`grunt serve` 
If needed add (`--force`)

### Browse
http://localhost:9000/ will automatically be opened in your default browser
