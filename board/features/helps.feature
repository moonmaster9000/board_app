Feature: Helps

  Scenario: Helps Exist
    Given there are helps for my team
    When I view my team's standup
    Then I should see those helps
