Stories
=======

[Stories](http://blog.citrusbyte.com/2009/05/20/stories/) is a small add on for [Contest](/help/contest).
It allows you to declare user stories, scenarios and steps using [Webrat](http://github.com/brynary/webrat/tree/master).

This is an example of a user story written with Stories:

    class SearchStoriesTest < ActionController::IntegrationTest
      story "As a user I want to find information so I can learn more" do
        scenario "Find what I'm looking for" do

          visit "http://www.google.com/"

          fill_in "q", :with => "Citrusbyte Stories"

          click_button "Google Search"

          assert_contain "citrusbyte's stories"

          click_link "citrusbyte's stories at master - GitHub"

          assert_contain "Stories and User Acceptance Tests"
        end
      end
    end

Stories alllows you to keep it simple and avoid having to translate English to code, just to have a pretty output.

Instead of that, when you run your tests with the **stories runner**, you get this output:

    As a user I want to find information so I can learn more
      — Find what I'm looking for
          Go to “http://www.google.com”
          Fill in “q” with “Citrusbyte Stories”
          Click “Google Search”
          I should see “citrusbyte's stories”
          Click “citrusbyte's stories at master - GitHub”
          I should see “Stories and User Acceptance Tests”

You can customize the output for any webrat method, silence or report a custom message for a group of steps and even generate a breathtaking PDF with the **stories pdf-runner**.

*Please take a look at the [Stories documentation](http://github.com/citrusbyte/stories/tree/master) and rediscover the meaning of Test Driven Development.*
