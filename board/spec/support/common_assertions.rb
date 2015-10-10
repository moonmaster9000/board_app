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
      entity = entity_class.new(field => value)

      expect(entity).not_to be_valid
      expect(entity.validation_errors.find { |ve| ve.field_name == field }).to be
    end

    def validation_error(entity, field)
      entity.validation_errors.find { |ve| ve.field_name == field }
    end
  end

  module ClassMethods
    def assert_private_attribute(entity_class)
      it_validates_inclusion_of entity_class, :private, values: [true, false]

      it "defaults the 'private' field to true" do
        expect(entity_class.new.private).to be(true)
      end
    end

    def it_requires(entity_class, field)
      it "does not allow 'nil' for #{field}" do
        it_disallows entity_class, field, nil
      end

      it "does not allow an empty string for #{field}" do
        it_disallows entity_class, field, ""
      end
    end

    def it_validates_inclusion_of(entity_class, field, values:)
      it "requires #{field} to be one of the following values: #{values}" do
        entity = entity_class.new(field => rand)
        expect(validation_error(entity, field)).to be

        values.each do |value|
          entity = entity_class.new(field => value)
          expect(validation_error(entity, field)).not_to be
        end
      end
    end
  end
end
