Feature: Events

  Scenario: Event created for a team
    Given there are events for my team
    When I view my team's standup
    Then I should see those events
