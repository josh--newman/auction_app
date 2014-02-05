#Auction App
###Joshua Newman (s2892398)

This application is an "Auction App" developed as part of the 2503ICT Web Programming course offered in the summer of 2014 at Griffith University.

Any feedback/issues/bugs should be sent to s2892398@griffith.edu.au

If you want to check out the app:

    $ git clone git@bitbucket.org:josh_newman/auction_app.git
    $ cd auction_app
    $ git checkout v1.0  # this will change to the Assignment 1 state
    $ bundle install
    $ rake db:migrate; rake db:populate
    $ rails s

###TODO
  + Update item only before bids have been placed [DONE]
  + Add finish_time field to new item form [DONE]
  + If item is deleted, all bids for that item should also be deleted [DONE]
  + Add time remaining and item status to item details page [DONE]
  + Restrict bid amounts at a controller/model level
    - Must be higher than a previous bid [DONE]
    - Can't be placed if item expired
  + Add to Users profile
    - currently bidding [DONE]
    - won items [DONE]
  + Image upload support [DONE]
  + General interface styling (2 column layout?) [DONE]
  + Documentation
  + Javascript niceities
  + Add notices to redirects [DONE]
  + Restructure the user profile page [DONE]
