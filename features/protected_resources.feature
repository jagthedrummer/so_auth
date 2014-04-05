Feature: Protecting Resources
  As a developer
  I want to keep anonymous users away form protected content

  Scenario: Protected Resource
    Given an anonymous user
    When he visits "/stuff/public"
    Then he should see "This is public content"

  Scenario: Protected Resource
    Given an anonymous user
    When he visits "/stuff/private"
    Then he should be redirected into the oauth dance
