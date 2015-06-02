Feature: Helps

  Scenario: Helps Exist
    Given there are helps for my whiteboard
    When I view my whiteboard's standup
    Then I should see those helps
