require "board"
require "board_test_support/doubles/gui_spy"
require "support/board_test_dsl"
require "support/common_assertions"


describe "USE CASE: configuring a whiteboard for standup emails" do
  include CommonAssertions
  include BoardTestDSL

  context "Given a whiteboard exists" do
    before do
      @whiteboard = create_whiteboard
    end

    context "And a standup email config already exists for that whiteboard" do
      before do
        create_standup_email_config(whiteboard_id: @whiteboard.id, observer: gui)
      end

      context "When I try to create another standup email config" do
        before do
          create_standup_email_config(whiteboard_id: @whiteboard.id, observer: gui)
        end

        specify "Then the observer should receive a 'standup_email_config_already_exists' message" do
          expect(gui.spy_standup_email_config_already_exists).to be(true)
        end
      end
    end

    context "But that whiteboard has no standup email config" do
      context "When the standup email attributes are invalid" do
        context "because the 'from_address' is blank" do
          it "informs the observer that a 'from_address' is required" do
            create_standup_email_config(whiteboard_id: @whiteboard.id, observer: gui, from_address: nil)
            assert_observer_got_one_error(gui, :from_address, :required)
          end
        end

        context "because the 'to_address' is blank" do
          it "informs the observer that a 'to_address' is required" do
            create_standup_email_config(whiteboard_id: @whiteboard.id, observer: gui, to_address: nil)
            assert_observer_got_one_error(gui, :to_address, :required)
          end
        end

        context "because I don't give it a whiteboard_id" do
          it "informs the observer that a whiteboard_id is required" do
            create_standup_email_config(whiteboard_id: nil, observer: gui)
            assert_observer_got_one_error(gui, :whiteboard_id, :required)
          end
        end
      end

      context "When the attributes are valid" do
        let(:standup_email_config_attributes) { valid_standup_email_config_attributes }

        before do
          create_standup_email_config({whiteboard_id: @whiteboard.id, observer: gui}.merge(standup_email_config_attributes))
        end

        it "sends a standup email config back to the gui with the requested attributes" do
          expect(gui.spy_created_standup_email_config.attributes).to include(standup_email_config_attributes)
        end

        it "doesn't send any validation errors" do
          expect(gui.spy_validation_errors).not_to be
        end
      end
    end
  end

  let(:gui) { GuiSpy.new }
end
