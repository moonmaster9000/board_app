Feature: Archive Standup

  Scenario: Archive standup with items
    Given I have posted many things to my whiteboard's standup today
    When I archive my whiteboard's standup today
    Then those items should no longer be on the whiteboard
