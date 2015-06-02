Feature: New Faces

  Scenario: New Faces Exist
    Given there are new faces for my whiteboard
    When I view my whiteboard's standup
    Then I should see those new faces
