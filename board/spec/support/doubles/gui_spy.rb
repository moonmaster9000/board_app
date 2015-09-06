require "support/doubles/spy_validations"

class GuiSpy
  include SpyValidations

  def whiteboard_created(whiteboard)
    @spy_created_whiteboard = whiteboard
  end
  attr_reader :spy_created_whiteboard

  def event_updated(event)
    @spy_updated_event = event
  end
  attr_reader :spy_updated_event

  def interesting_updated(interesting)
    @spy_updated_interesting = interesting
  end
  attr_reader :spy_updated_interesting

  def help_updated(help)
    @spy_updated_help = help
  end
  attr_reader :spy_updated_help

  def new_face_updated(new_face)
    @spy_updated_new_face = new_face
  end
  attr_reader :spy_updated_new_face

  def entity_not_found
    @spy_entity_not_found = true
  end
  attr_reader :spy_entity_not_found

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

  def event_read(event)
    @spy_read_event = event
  end
  attr_reader :spy_read_event

  def event_not_found
    @spy_event_not_found = true
  end
  attr_reader :spy_event_not_found

  def help_read(help)
    @spy_read_help = help
  end
  attr_reader :spy_read_help

  def help_not_found
    @spy_help_not_found = true
  end
  attr_reader :spy_help_not_found

  def new_face_read(new_face)
    @spy_read_new_face = new_face
  end
  attr_reader :spy_read_new_face

  def new_face_not_found
    @spy_new_face_not_found = true
  end
  attr_reader :spy_new_face_not_found

  def interesting_read(interesting)
    @spy_read_interesting = interesting
  end
  attr_reader :spy_read_interesting

  def interesting_not_found
    @spy_interesting_not_found = true
  end
  attr_reader :spy_interesting_not_found

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
