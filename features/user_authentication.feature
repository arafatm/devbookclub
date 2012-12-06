Feature: User authentication
  Scenario: Signed out users see appropriate links
    Given I am on the homepage
    Then I should see "Sign In"
    And I should see "Sign Up"
    And I should not see "Sign Out"

  Scenario: Signed in users see appropriate links
    Given I am signed in
    And I am on the homepage
    Then I should see "Sign Out"
    And I should not see "Sign In"
    And I should not see "Sign Up"

  Scenario: Signing up
    Given I am on the homepage
    When I click "Sign Up"
    And I fill in "adam" for "Username"
    And I fill in "adam@example.com" for "Email"
    And I fill in "foobar" for "Password"
    And I fill in "foobar" for "Password confirmation"
    And I click "Sign up"
    Then I should see "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."

  Scenario: Signing up with non-matching passwords
    Given I am on the homepage
    When I click "Sign Up"
    And I fill in "adam" for "Username"
    And I fill in "adam@example.com" for "Email"
    And I fill in "foobar" for "Password"
    And I fill in "notfoobar" for "Password confirmation"
    And I click "Sign up"
    Then I should see "Password doesn't match confirmation"

  Scenario: Logging in
    Given there is a user "adam" with password "foobar"
    When I go to the homepage
    And I click "Sign In"
    And I fill in "adam" for "Login"
    And I fill in "foobar" for "Password"
    And I click "Sign in"
    Then I should see "You are now signed in."

  Scenario: Logging in with incorrect password
    Given there is a user "adam" with password "notfoobar"
    When I go to the homepage
    And I click "Sign In"
    And I fill in "adam" for "Login"
    And I fill in "foobar" for "Password"
    And I click "Sign in"
    Then I should see "Incorrect login or password"
    And the "Login" field should contain "adam"

  Scenario: Logging out
    Given I am signed in
    And I am on the homepage
    When I click "Sign Out"
    Then I should see the alert "You are now signed out."
