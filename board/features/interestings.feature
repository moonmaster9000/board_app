Feature: Interestings

  Scenario: Interesting created for a whiteboard
    Given there are interestings for my whiteboard
    When I view my whiteboard's standup
    Then I should see those interestings
