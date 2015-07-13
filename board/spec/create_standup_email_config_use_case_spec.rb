require "board"
require "board_test_support/doubles/gui_spy"
require "support/board_test_dsl"
require "support/common_assertions"


describe "USE CASE: configuring a whiteboard for standup emails" do
  include CommonAssertions
  include BoardTestDSL

  before do
    @whiteboard = create_whiteboard
  end

  describe "invalid data scenarios" do
    it "from_address required" do
      set_standup_email_config(whiteboard_id: @whiteboard.id, observer: gui, from_address: nil)

      assert_observer_got_one_error(gui, :from_address, :required)
    end

    it "to_address required" do
      set_standup_email_config(whiteboard_id: @whiteboard.id, observer: gui, to_address: nil)
      assert_observer_got_one_error(gui, :to_address, :required)
    end

    it "whiteboard_id required" do
      set_standup_email_config(whiteboard_id: nil, observer: gui)

      assert_observer_got_one_error(gui, :whiteboard_id, :required)
    end
  end

  describe "Given valid data" do
    let(:standup_email_config_attributes) { valid_standup_email_config_attributes }

    before do
      set_standup_email_config({whiteboard_id: @whiteboard.id, observer: gui}.merge standup_email_config_attributes)
    end

    it "sends a standup email config back to the gui with the requested attributes" do
      expect(gui.spy_created_standup_email_config.attributes).to include(standup_email_config_attributes)
    end

    it "doesn't send any validation errors" do
      expect(gui.spy_validation_errors).not_to be
    end

    it "allows you to overwrite previous versions of the standup email config" do
      set_standup_email_config(whiteboard_id: @whiteboard.id, observer: gui, from_address: "new address")

      expect(gui.spy_created_standup_email_config.from_address).to eq "new address"
    end
  end

  let(:gui) { GuiSpy.new }
end
