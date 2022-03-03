require 'levenshtein'
require_relative "../helpers/verify.rb"

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    include Verify

    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject
  end
end
