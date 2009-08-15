Testing with Stories
====================

Instead of starting by implementing the application on a lower level (i.e: models) and then defining the functionality you actually want, another option is to write the [user stories](http://en.wikipedia.org/wiki/User_story) that define a project (rather than tasks or other methodologies) and start working from there. This represents an [outside-in approach](http://dannorth.net/whats-in-a-story).

For example, say you have this story:

      As a user I want to log in so I can access restricted features

Your first instinct might be to create a User model, and start writing some specs. The part of actually logging in comes much later, and when you do have to implement it, you may be bound to your model implementation limitations, because you weren't completely sure of what you wanted to achieve in the first place.


Our strategy is different. First of all, we define what we want by creating the integration tests using webrat and stories. For example:

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

NOTE: If you are not familiar with the gem [Spawn](/help/spawn), you may want to check it out.

Now you have a very clear vision of the story. This doesn't mean unit testing is out of the picture, but it should be used only when necessary.

Notice that when this story passes, your work is finished and you can mark that story as complete.
When you run it, you will get this output:

    As a user I want to log in so I can access restricted features
      — A user submits valid credentials
          Go to “/”
          Click “Log in”
          Fill in “Email” with “albert@example.com”
          Fill in “Password” with “monkey”
          Click "Sign in"
          I should see “Welcome Albert”

This is generated automatically and looks pretty good out of the box. However, it's not perfect. From time to time you will find Webrat methods that won't get reported nicely. For example, lets also check that the response we receive is 200.

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

          assert_response 200
          assert_contain "Welcome Albert"
        end
      end
    end

If you run that test now you will get the same output as before. This is not a bug, it just means that there is no standard report for that Webrat method yet. All you have to do is define it however you like to, in your test helper.

    module Stories::Webrat
      report_for :assert_response do |response|
        "The response should be #{response}"
      end
    end

Now when you run the test you will get this output:

    As a user I want to log in so I can access restricted features
      — A user submits valid credentials
          Go to “/”
          Click “Log in”
          Fill in “Email” with “albert@example.com”
          Fill in “Password” with “monkey”
          Click "Sign in"
          The response should be 200
          I should see “Welcome Albert”

`report_for` lets you customize or add a description for a Webrat method, the way you want it to be on your output.

So far so good. Lets assume now that you are not interested in having all those steps in your output, only to describe a user logging in. Fair enough, we can group the steps into a single report message.

    class UserStoriesTest < ActionController::IntegrationTest
      story "As a user I want to log in so I can access restricted features" do
        setup do
          @user = User.spawn :name => "Albert", :email => "albert@example.com"
        end

        scenario "A user submits valid credentials" do
          report "log in with user '#{user.email}' and password '#{user.password}'" do
            visit "/"
            click_link "Log in"
            fill_in "Email", :with => user.email
            fill_in "Password", :with => user.password
            click_button "Sign in"
          end

          assert_response 200
          assert_contain "Welcome Albert"
        end
      end
    end

Now the output will be:

    As a user I want to log in so I can access restricted features
      — A user submits valid credentials
          log in with user 'albert@example.com' and password 'monkey'
          The response should be 200
          I should see “Welcome Albert”

If you later realize that you need to log in for every test, then you can just extract those steps into a helper method, like:

    def login(user, password)
      report "log in with user '#{user.email}' and password '#{user.password}'" do
        visit "/"
        click_link "Log in"
        fill_in "Email", :with => user.email
        fill_in "Password", :with => user.password
        click_button "Sign in"
      end
    end

And now the original test will look like this:

    class UserStoriesTest < ActionController::IntegrationTest
      story "As a user I want to log in so I can access restricted features" do
        setup do
          @user = User.spawn :name => "Albert", :email => "albert@example.com"
        end

        scenario "A user submits valid credentials" do
          login(@user.email, @user.password)

          assert_response 200
          assert_contain "Welcome Albert"
        end
      end
    end

Now any time that you need to log in to your application, you have that helper method available and you can add it to any story.

    class UserStoriesTest < ActionController::IntegrationTest
      story "As a user I want to log in so I can access restricted features" do
        setup do
          @user = User.spawn :name => "Albert", :email => "albert@example.com"
        end

        scenario "A user submits valid credentials" do
          login(@user.email, @user.password)

          assert_response 200
          assert_contain "Welcome Albert"
        end
      end

      story "As a user I want to read an article so I can learn something" do
        setup do
          @user = User.spawn :name => "Albert", :email => "albert@example.com"
        end

        scenario "Given a valid user" do
          login(@user.email, @user.password)
          click_link "articles"
          click_link "Dan North on User Stories"
          assert_contain "What's in a story?"
        end
      end
    end

Instead of grouping steps and generating a dynamic report for them, there may be the case in which you want to just silence some ugly step, for that you have the method `silent`. For example:

    ...
    silent do
      assert_contain "Some obscure hash"
    end
    ...

This will supress the report for that assert_contain validation.

What all of this does for you, in a few words, is speed things up. You will gain more from TDD this way. Moreover, we get our requirements from our clients in a user-stories format, so we want to (ocasionally) let the client know how we are doing. It is now a standard for us, to generate pdf reports from our stories, which serve as documentation we can deliver to our clients.

Trust me, they love it.

You can do this too. Simple run your tests with the `stories pdf runner` like this:

    $ ruby my_test.rb --runner=stories-pdf

This pdf is drop-dead beautiful as it stands, but of course, you can customize it to your liking.
Lets change the header so that it displays the name of the company and the company logo. All you have to do is add the following in your test helper:

    Test::Unit::AutoRunner::RUNNERS[:"stories-pdf"] = Proc.new do
      require "stories/runner/pdf"

      class Stories::Runner::PDF
        def render_header(pdf)
          pdf.write "Citrusbyte"
          pdf.canvas do
            pdf.bounding_box pdf.bounds.absolute_top_left, :height => 110 do
              pdf.image("/public/img/logo.jpg")
            end
          end
        end
      end

      Stories::Runner::PDF
    end

This pdf is generated with [Prawn](http://prawn.majesticseacreature.com/) and you can easily tweak it to fit your taste. You could also choose to generate this kind of report in html or whatever format you want, the sky is the limit. It's up to you.
