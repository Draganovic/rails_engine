#Rails Engine

##Setup

To use, clone down this repo:

`$ git clone https://github.com/Draganovic/rails_engine.git`

Bundle those gems:

`$ bundle install`

To set up the database run:

`$ rake db:{create,migrate}`

To populate the database with the csv's included in this repository, run:

`$ rake csv:load_to_db`

Now take this time to consider your life choices.

##Testing

Testing suite built in RSpec. To run:

`$ rspec`
