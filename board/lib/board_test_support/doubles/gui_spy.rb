class GuiSpy
  def validation_failed(errors)
    @spy_validation_errors = errors
  end
  attr_reader :spy_validation_errors

  def whiteboard_created(whiteboard)
    @spy_created_whiteboard = whiteboard
  end
  attr_reader :spy_created_whiteboard

  def help_created(help)
    @spy_created_help = help
  end
  attr_reader :spy_created_help

  def interesting_created(interesting)
    @spy_created_interesting = interesting
  end
  attr_reader :spy_created_interesting

  def event_created(event)
    @spy_created_event = event
  end
  attr_reader :spy_created_event

  def whiteboard_presented(whiteboard)
    @spy_presented_whiteboard = whiteboard
  end
  attr_reader :spy_presented_whiteboard

  def whiteboards_presented(whiteboards)
    @spy_presented_whiteboards = whiteboards
  end
  attr_reader :spy_presented_whiteboards

  def standup_archived
    @spy_standup_archived = true
  end
  attr_reader :spy_standup_archived

  def new_face_created(new_face)
    @spy_created_new_face = new_face
  end
  attr_reader :spy_created_new_face


  def authentication_succeeded
    @spy_authentication_succeeded = true
  end
  attr_reader :spy_authentication_succeeded

  def already_authenticated
    @spy_already_authenticated = true
  end
  attr_reader :spy_already_authenticated

  def standup_email_config_created(standup_email_config)
    @spy_created_standup_email_config = standup_email_config
  end
  attr_reader :spy_created_standup_email_config

  def email_sent(email)
    @spy_email_sent = email
  end
  attr_reader :spy_email_sent

  def email_not_configured
    @spy_email_not_configured = true
  end
  attr_reader :spy_email_not_configured

  def standup_presented(standup)
    @spy_presented_standup = standup
  end
  attr_reader :spy_presented_standup

  def whiteboard_items_presented(items)
    @spy_presented_whiteboard_items = items
  end
  attr_reader :spy_presented_whiteboard_items
end
