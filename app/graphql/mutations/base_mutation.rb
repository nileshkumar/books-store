# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    def check_current_user
      if !context[:current_user]
        raise GraphQL::ExecutionError, "Please SignIn!"
      else
        true
      end
    end
  end
end
