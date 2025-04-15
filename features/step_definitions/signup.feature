Feature: Account Management
  In order to access my personal financial data
  As a registered user
  I want to securely create an account and log in

  Background:
    Given I am a new user

  @signup
  Scenario: User Registration
    Given I navigate to the signup page
    When I enter my valid personal information and desired password
    And I submit the registration form
    Then I should see a confirmation message
    And my account should be created successfully

  @login
  Scenario: Secure Login
    Given I have an account with valid credentials
    When I enter my username and password correctly
    And I press the login button
    Then I should be logged in securely
    And my financial data should be accessible only to me
