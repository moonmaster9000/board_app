require "board"
require "support/test_attributes"
require "support/doubles/fake_repo_factory"
require "support/doubles/gui_spy"

module BoardTestDSL
  include TestAttributes

  def event_repo
    @event_repo ||= repo_factory.event_repo
  end

  def new_face_repo
    @new_face_repo ||= repo_factory.new_face_repo
  end

  def help_repo
    @help_repo ||= repo_factory.help_repo
  end

  def interesting_repo
    @interesting_repo ||= repo_factory.interesting_repo
  end

  def whiteboard_repo
    @whiteboard_repo ||= repo_factory.whiteboard_repo
  end

  def repo_factory
    @repo_factory ||= FakeRepoFactory.new
  end

  def observer
    @observer ||= GuiSpy.new
  end

  def use_case_factory
    @use_cases ||= Board::UseCaseFactory.new
  end

  def email_standup(email_client:, observer:, standup_email_formatter:, whiteboard_id:, date:, attributes: {})
    use_case_factory.email_standup(
      whiteboard_id: whiteboard_id,
      date: date,
      email_client: email_client,
      standup_email_formatter: standup_email_formatter,
      observer: observer,
      repo_factory: repo_factory,
      attributes: attributes,
    ).execute
  end

  def create_interesting(whiteboard_id:, observer: nil, **interesting_attributes)
    observer ||= self.observer

    use_case_factory.create_interesting(
      observer: observer,
      attributes: valid_interesting_attributes.merge(interesting_attributes),
      interesting_repo: interesting_repo,
      whiteboard_id: whiteboard_id,
    ).execute

    observer.spy_created_interesting
  end

  def create_help(whiteboard_id:, observer: nil, **help_attributes)
    observer ||= self.observer

    use_case_factory.create_help(
      observer: observer,
      attributes: valid_help_attributes.merge(help_attributes),
      help_repo: help_repo,
      whiteboard_id: whiteboard_id,
    ).execute

    observer.spy_created_help
  end

  def create_event(whiteboard_id:, observer: nil, **event_attributes)
    observer ||= self.observer

    use_case_factory.create_event(
      observer: observer,
      attributes: valid_event_attributes.merge(event_attributes),
      event_repo: event_repo,
      whiteboard_id: whiteboard_id,
    ).execute

    observer.spy_created_event
  end
  
  def read_event(event_id:, observer: nil)
    observer ||= self.observer

    use_case_factory.read_event(
      observer: observer,
      repo_factory: repo_factory,
      event_id: event_id,
    ).execute

    observer.spy_read_event
  end

  def delete_event(event_id:, observer: nil)
    observer ||= self.observer

    use_case_factory.delete_event(
      observer: observer,
      repo_factory: repo_factory,
      event_id: event_id,
    ).execute
  end
  
  def delete_new_face(new_face_id:, observer: nil)
    observer ||= self.observer

    use_case_factory.delete_new_face(
      observer: observer,
      repo_factory: repo_factory,
      new_face_id: new_face_id,
    ).execute
  end
  
  def delete_interesting(interesting_id:, observer: nil)
    observer ||= self.observer

    use_case_factory.delete_interesting(
      observer: observer,
      repo_factory: repo_factory,
      interesting_id: interesting_id,
    ).execute
  end
  
  def delete_help(help_id:, observer: nil)
    observer ||= self.observer

    use_case_factory.delete_help(
      observer: observer,
      repo_factory: repo_factory,
      help_id: help_id,
    ).execute
  end
  
  def read_new_face(new_face_id:, observer: nil)
    observer ||= self.observer

    use_case_factory.read_new_face(
      observer: observer,
      repo_factory: repo_factory,
      new_face_id: new_face_id,
    ).execute

    observer.spy_read_new_face
  end
  
  def read_help(help_id:, observer: nil)
    observer ||= self.observer

    use_case_factory.read_help(
      observer: observer,
      repo_factory: repo_factory,
      help_id: help_id,
    ).execute

    observer.spy_read_help
  end
  
  def read_interesting(interesting_id:, observer: nil)
    observer ||= self.observer

    use_case_factory.read_interesting(
      observer: observer,
      repo_factory: repo_factory,
      interesting_id: interesting_id,
    ).execute

    observer.spy_read_interesting
  end

  def update_event(event_id:, observer: nil, **event_attributes)
    observer ||= self.observer

    use_case_factory.update_event(
      observer: observer,
      attributes: event_attributes,
      repo_factory: repo_factory,
      event_id: event_id,
    ).execute

    observer.spy_updated_event
  end
  
  def update_interesting(interesting_id:, observer: nil, **interesting_attributes)
    observer ||= self.observer

    use_case_factory.update_interesting(
      observer: observer,
      attributes: interesting_attributes,
      repo_factory: repo_factory,
      interesting_id: interesting_id,
    ).execute

    observer.spy_updated_interesting
  end

  def update_help(help_id:, observer: nil, **help_attributes)
    observer ||= self.observer

    use_case_factory.update_help(
      observer: observer,
      attributes: help_attributes,
      repo_factory: repo_factory,
      help_id: help_id,
    ).execute

    observer.spy_updated_help
  end
  
  def update_new_face(new_face_id:, observer: nil, **new_face_attributes)
    observer ||= self.observer

    use_case_factory.update_new_face(
      observer: observer,
      attributes: new_face_attributes,
      repo_factory: repo_factory,
      new_face_id: new_face_id,
    ).execute

    observer.spy_updated_new_face
  end

  def create_new_face(whiteboard_id:, observer: nil, **new_face_attributes)
    observer ||= self.observer

    use_case_factory.create_new_face(
      observer: observer,
      attributes: valid_new_face_attributes.merge(new_face_attributes),
      new_face_repo: new_face_repo,
      whiteboard_id: whiteboard_id,
    ).execute

    observer.spy_created_new_face
  end

  def archive_standup(whiteboard_id, date)
    use_case_factory.archive_standup(
      observer: observer,
      repo_factory: repo_factory,
      whiteboard_id: whiteboard_id,
      date: date,
    ).execute
  end

  def set_standup_email_config(whiteboard_id:, observer: nil, **custom_email_config_attributes)
    observer ||= self.observer

    use_case_factory.create_standup_email_config(
      whiteboard_id: whiteboard_id,
      attributes: valid_standup_email_config_attributes.merge(custom_email_config_attributes),
      observer: observer,
      repo_factory: repo_factory,
    ).execute

    observer.spy_created_standup_email_config
  end

  def create_whiteboard
    use_case_factory.create_whiteboard(
      observer: observer,
      attributes: valid_whiteboard_attributes,
      whiteboard_repo: whiteboard_repo,
    ).execute

    observer.spy_created_whiteboard
  end

  def present_standup(whiteboard_id:, date:)
    use_case_factory.present_standup(
      whiteboard_id: whiteboard_id,
      repo_factory: repo_factory,
      date: date,
      observer: observer,
    ).execute

    observer.spy_presented_standup
  end

  def present_whiteboard(whiteboard_id:)
    use_case_factory.present_whiteboard_items(
      whiteboard_id: whiteboard_id,
      repo_factory: repo_factory,
      observer: observer,
    ).execute

    observer.spy_presented_whiteboard_items
  end
end
