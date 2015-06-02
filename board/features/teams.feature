Feature: Whiteboards

  Scenario: Showing a list of created whiteboards
    Given there is a whiteboard
    When I view a list of whiteboards
    Then I should see that whiteboard
