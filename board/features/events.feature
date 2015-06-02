Feature: Events

  Scenario: Event created for a whiteboard
    Given there are events for my whiteboard
    When I view my whiteboard's standup
    Then I should see those events
