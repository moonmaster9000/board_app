module CommonAssertions
  def assert_gui_received_error(field_name, error)
    expect(gui.spy_validation_errors.count).to eq 1

    validation = gui.spy_validation_errors.first

    expect(validation.field_name).to eq field_name
    expect(validation.error).to eq error
  end
end
