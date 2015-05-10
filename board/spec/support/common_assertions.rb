module CommonAssertions
  def assert_gui_got_one_error(field_name, error)
    expect(gui.spy_validation_errors).to be, "no validation error received, but one was expected"
    expect(gui.spy_validation_errors.count).to eq(1), "only one validation error was expected, but many were recieved: #{gui.spy_validation_errors}"

    validation = gui.spy_validation_errors.first

    expect(validation.field_name).to eq field_name
    expect(validation.error).to eq error
  end
end
