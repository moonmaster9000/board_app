Feature: New Faces

  Scenario: New Faces Exist
    Given there are new faces for my team
    When I view my team's standup
    Then I should see those new faces
