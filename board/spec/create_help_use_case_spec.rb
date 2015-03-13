require "support/common_assertions"
require "board"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_help_repo"

describe "USE CASE: creating a help" do
  include CommonAssertions

  context "when the attributes are invalid" do
    context "because the date is blank" do
      it "informs the observer that a date is required" do
        attributes = {date: nil}

        Board.create_help(
          observer: gui,
          attributes: attributes,
          help_repo: fake_help_repo,
          # team_id: created_team.id
        ).execute

        assert_gui_received_error(:date, :required)
      end
    end
  end

  let(:gui) { GuiSpy.new }
  let(:fake_help_repo) { FakeHelpRepo.new }
end
