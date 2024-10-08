module VestalVersions
  # Provides a way for information to be associated with specific versions as to who was
  # responsible for the associated update to the parent.
  module Users
    extend ActiveSupport::Concern

    included do
      attr_accessor :updated_by
      Version.class_eval do
        belongs_to :user, :polymorphic => true

        # Overrides the +user+ method created by the polymorphic +belongs_to+ user association. If
        # the association is absent, defaults to the +user_name+ string column. This allows
        # VestalVersions::Version#user to either return an ActiveRecord::Base object or a string,
        # depending on what is sent to the +user_with_name=+ method.
        def user
          super || user_name
        end

        # Overrides the +user=+ method created by the polymorphic +belongs_to+ user association.
        # Based on the class of the object given, either the +user+ association columns or the
        # +user_name+ string column is populated.
        def user=(value)
          case value
          when ActiveRecord::Base then super(value)
          else self.user_name = value
          end
        end
      end
    end

    # Methods added to versioned ActiveRecord::Base instances to enable versioning with additional
    # user information.

    private

    # Overrides the +version_attributes+ method to include user information passed into the
    # parent object, by way of a +updated_by+ attr_accessor.
    def version_attributes
      super.merge(:user => updated_by)
    end
  end
end
