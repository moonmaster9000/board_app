Feature: Archive Standup

  Scenario: Archive standup with items
    Given I have posted many things to my team's standup today
    When I archive my team's standup today
    Then those items should no longer be on the whiteboard
