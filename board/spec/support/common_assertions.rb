module CommonAssertions
  def self.included(base)
    base.send :include, InstanceMethods
    base.send :extend, ClassMethods
  end

  module InstanceMethods
    def assert_observer_got_one_error(observer, field_name, error)
      expect(observer.spy_validation_errors).to be, "no validation error received, but one was expected"
      expect(observer.spy_validation_errors.count).to eq(1), "only one validation error was expected, but many were received: #{observer.spy_validation_errors}"

      validation = observer.spy_validation_errors.first

      expect(validation.field_name).to eq field_name
      expect(validation.error).to eq error
    end

    def it_disallows(entity_class, field, value)
      event = entity_class.new(field => value)

      expect(event).not_to be_valid
      expect(event.validation_errors.select { |ve| ve.field_name == field }).not_to be_empty
    end
  end

  module ClassMethods
    def it_requires(entity_class, field)
      it "does not allow 'nil' for #{field}" do
        it_disallows entity_class, field, nil
      end

      it "does not allow an empty string for #{field}" do
        it_disallows entity_class, field, ""
      end
    end
  end
end
