Stories
=======

[Stories](http://blog.citrusbyte.com/2009/05/20/stories/) is a small add on for [Contest](/help/contest).
It allows you to declare user stories, scenarios and steps using [Webrat](http://github.com/brynary/webrat/tree/master), and generate a pretty English output in plain text or PDF.

This is an example of a user story written with Stories:

    class UserStoriesTest < ActionController::IntegrationTest
      story "As a user I want to log in so I can access restricted features" do
        setup do
          @user = User.spawn :name => "Albert", :email => "albert@example.com"
        end

        scenario "A user submits valid credentials" do
          visit "/"
          click_link "Log in"
          fill_in "Email", :with => user.email
          fill_in "Password", :with => user.password
          click_button "Sign in"

          assert_contain "Welcome Albert"
        end
      end
    end

When you run your tests with the `stories runner`, you get this output:

    As a user I want to log in so I can access restricted features
      — A user submits valid credentials
          Go to “/”
          Click “Log in”
          Fill in “Email” with “albert@example.com”
          Fill in “Password” with “monkey”
          Click "Sign in"
          I should see “Welcome Albert”

You can customize the output for any webrat method, silence or report a custom message for a group of steps and even generate a PDF with the `stories pdf-runner`.

Please take a look at the [documentation](http://github.com/citrusbyte/stories/tree/master) for more info.
