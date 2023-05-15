# Copyright 2017 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


module Google
  module Cloud
    module Bigquery
      class Schema
        ##
        # # Schema Field
        #
        # The fields of a table schema.
        #
        # @see https://cloud.google.com/bigquery/docs/loading-data#loading_denormalized_nested_and_repeated_data
        #   Loading denormalized, nested, and repeated data
        #
        # @example
        #   require "google/cloud/bigquery"
        #
        #   bigquery = Google::Cloud::Bigquery.new
        #   dataset = bigquery.dataset "my_dataset"
        #   table = dataset.table "my_table"
        #
        #   field = table.schema.field "name"
        #   field.required? #=> true
        #
        class Field
          # @private
          MODES = %w[NULLABLE REQUIRED REPEATED].freeze

          # @private
          TYPES = %w[STRING INTEGER INT64 FLOAT FLOAT64 NUMERIC BOOLEAN BOOL
                     BYTES TIMESTAMP TIME DATETIME DATE RECORD STRUCT].freeze

          ##
          # The name of the field.
          #
          # @return [String] The field name. The name must contain only
          #   letters (a-z, A-Z), numbers (0-9), or underscores (_), and must
          #   start with a letter or underscore. The maximum length is 128
          #   characters.
          #
          def name
            @gapi.name
          end

          ##
          # Updates the name of the field.
          #
          # @param [String] new_name The field name. The name must contain only
          #   letters (a-z, A-Z), numbers (0-9), or underscores (_), and must
          #   start with a letter or underscore. The maximum length is 128
          #   characters.
          #
          def name= new_name
            @gapi.update! name: String(new_name)
          end

          ##
          # The data type of the field.
          #
          # @return [String] The field data type. Possible values include
          #   `STRING`, `BYTES`, `INTEGER`, `INT64` (same as `INTEGER`),
          #   `FLOAT`, `FLOAT64` (same as `FLOAT`), `NUMERIC`, `BOOLEAN`, `BOOL`
          #   (same as `BOOLEAN`), `TIMESTAMP`, `DATE`, `TIME`, `DATETIME`,
          #   `RECORD` (where `RECORD` indicates that the field contains a
          #   nested schema) or `STRUCT` (same as `RECORD`).
          #
          def type
            @gapi.type
          end

          ##
          # Updates the data type of the field.
          #
          # @param [String] new_type The data type. Possible values include
          #   `STRING`, `BYTES`, `INTEGER`, `INT64` (same as `INTEGER`),
          #   `FLOAT`, `FLOAT64` (same as `FLOAT`), `NUMERIC`, `BOOLEAN`, `BOOL`
          #   (same as `BOOLEAN`), `TIMESTAMP`, `DATE`, `TIME`, `DATETIME`,
          #   `RECORD` (where `RECORD` indicates that the field contains a
          #   nested schema) or `STRUCT` (same as `RECORD`).
          #
          def type= new_type
            @gapi.update! type: verify_type(new_type)
          end

          ##
          # Checks if the type of the field is `NULLABLE`.
          #
          # @return [Boolean] `true` when `NULLABLE`, `false` otherwise.
          #
          def nullable?
            mode == "NULLABLE"
          end

          ##
          # Checks if the type of the field is `REQUIRED`.
          #
          # @return [Boolean] `true` when `REQUIRED`, `false` otherwise.
          #
          def required?
            mode == "REQUIRED"
          end

          ##
          # Checks if the type of the field is `REPEATED`.
          #
          # @return [Boolean] `true` when `REPEATED`, `false` otherwise.
          #
          def repeated?
            mode == "REPEATED"
          end

          ##
          # The description of the field.
          #
          # @return [String] The field description. The maximum length is 1,024
          #   characters.
          #
          def description
            @gapi.description
          end

          ##
          # Updates the description of the field.
          #
          # @param [String] new_description The field description. The maximum
          #   length is 1,024 characters.
          #
          def description= new_description
            @gapi.update! description: new_description
          end

          ##
          # The mode of the field.
          #
          # @return [String] The field mode. Possible values include `NULLABLE`,
          #   `REQUIRED` and `REPEATED`. The default value is `NULLABLE`.
          #
          def mode
            @gapi.mode
          end

          ##
          # Updates the mode of the field.
          #
          # @param [String] new_mode The field mode. Possible values include
          #   `NULLABLE`, `REQUIRED` and `REPEATED`. The default value is
          #   `NULLABLE`.
          #
          def mode= new_mode
            @gapi.update! mode: verify_mode(new_mode)
          end

          ##
          # Checks if the type of the field is `STRING`.
          #
          # @return [Boolean] `true` when `STRING`, `false` otherwise.
          #
          def string?
            type == "STRING"
          end

          ##
          # Checks if the type of the field is `INTEGER`.
          #
          # @return [Boolean] `true` when `INTEGER`, `false` otherwise.
          #
          def integer?
            type == "INTEGER" || type == "INT64"
          end

          ##
          # Checks if the type of the field is `FLOAT`.
          #
          # @return [Boolean] `true` when `FLOAT`, `false` otherwise.
          #
          def float?
            type == "FLOAT" || type == "FLOAT64"
          end

          ##
          # Checks if the type of the field is `NUMERIC`.
          #
          # @return [Boolean] `true` when `NUMERIC`, `false` otherwise.
          #
          def numeric?
            type == "NUMERIC"
          end

          ##
          # Checks if the type of the field is `BOOLEAN`.
          #
          # @return [Boolean] `true` when `BOOLEAN`, `false` otherwise.
          #
          def boolean?
            type == "BOOLEAN" || type == "BOOL"
          end

          ##
          # Checks if the type of the field is `BYTES`.
          #
          # @return [Boolean] `true` when `BYTES`, `false` otherwise.
          #
          def bytes?
            type == "BYTES"
          end

          ##
          # Checks if the type of the field is `TIMESTAMP`.
          #
          # @return [Boolean] `true` when `TIMESTAMP`, `false` otherwise.
          #
          def timestamp?
            type == "TIMESTAMP"
          end

          ##
          # Checks if the type of the field is `TIME`.
          #
          # @return [Boolean] `true` when `TIME`, `false` otherwise.
          #
          def time?
            type == "TIME"
          end

          ##
          # Checks if the type of the field is `DATETIME`.
          #
          # @return [Boolean] `true` when `DATETIME`, `false` otherwise.
          #
          def datetime?
            type == "DATETIME"
          end

          ##
          # Checks if the type of the field is `DATE`.
          #
          # @return [Boolean] `true` when `DATE`, `false` otherwise.
          #
          def date?
            type == "DATE"
          end

          ##
          # Checks if the type of the field is `RECORD`.
          #
          # @return [Boolean] `true` when `RECORD`, `false` otherwise.
          #
          def record?
            type == "RECORD" || type == "STRUCT"
          end

          ##
          # The nested fields if the type property is set to `RECORD`. Will be
          # empty otherwise.
          #
          # @return [Array<Field>, nil] The nested schema fields if the type
          #   is set to `RECORD`.
          #
          def fields
            if frozen?
              Array(@gapi.fields).map { |f| Field.from_gapi(f).freeze }.freeze
            else
              Array(@gapi.fields).map { |f| Field.from_gapi f }
            end
          end

          ##
          # The names of the nested fields as symbols if the type property is
          # set to `RECORD`. Will be empty otherwise.
          #
          # @return [Array<Symbol>, nil] The names of the nested schema fields
          #   if the type is set to `RECORD`.
          #
          def headers
            fields.map(&:name).map(&:to_sym)
          end

          ##
          # Retrieve a nested field by name, if the type property is
          # set to `RECORD`. Will return `nil` otherwise.
          #
          # @return [Field, nil] The nested schema field object, or `nil`.
          #
          def field name
            f = fields.find { |fld| fld.name == name.to_s }
            return nil if f.nil?
            yield f if block_given?
            f
          end

          ##
          # Adds a string field to the nested schema of a record field.
          #
          # This can only be called on fields that are of type `RECORD`.
          #
          # @param [String] name The field name. The name must contain only
          #   letters (a-z, A-Z), numbers (0-9), or underscores (_), and must
          #   start with a letter or underscore. The maximum length is 128
          #   characters.
          # @param [String] description A description of the field.
          # @param [Symbol] mode The field's mode. The possible values are
          #   `:nullable`, `:required`, and `:repeated`. The default value is
          #   `:nullable`.
          #
          def string name, description: nil, mode: :nullable
            record_check!

            add_field name, :string, description: description, mode: mode
          end

          ##
          # Adds an integer field to the nested schema of a record field.
          #
          # This can only be called on fields that are of type `RECORD`.
          #
          # @param [String] name The field name. The name must contain only
          #   letters (a-z, A-Z), numbers (0-9), or underscores (_), and must
          #   start with a letter or underscore. The maximum length is 128
          #   characters.
          # @param [String] description A description of the field.
          # @param [Symbol] mode The field's mode. The possible values are
          #   `:nullable`, `:required`, and `:repeated`. The default value is
          #   `:nullable`.
          #
          def integer name, description: nil, mode: :nullable
            record_check!

            add_field name, :integer, description: description, mode: mode
          end

          ##
          # Adds a floating-point number field to the nested schema of a record
          # field.
          #
          # This can only be called on fields that are of type `RECORD`.
          #
          # @param [String] name The field name. The name must contain only
          #   letters (a-z, A-Z), numbers (0-9), or underscores (_), and must
          #   start with a letter or underscore. The maximum length is 128
          #   characters.
          # @param [String] description A description of the field.
          # @param [Symbol] mode The field's mode. The possible values are
          #   `:nullable`, `:required`, and `:repeated`. The default value is
          #   `:nullable`.
          #
          def float name, description: nil, mode: :nullable
            record_check!

            add_field name, :float, description: description, mode: mode
          end

          ##
          # Adds a numeric number field to the schema. Numeric is a
          # fixed-precision numeric type with 38 decimal digits, 9 that follow
          # the decimal point.
          #
          # This can only be called on fields that are of type `RECORD`.
          #
          # @param [String] name The field name. The name must contain only
          #   letters (a-z, A-Z), numbers (0-9), or underscores (_), and must
          #   start with a letter or underscore. The maximum length is 128
          #   characters.
          # @param [String] description A description of the field.
          # @param [Symbol] mode The field's mode. The possible values are
          #   `:nullable`, `:required`, and `:repeated`. The default value is
          #   `:nullable`.
          #
          def numeric name, description: nil, mode: :nullable
            record_check!

            add_field name, :numeric, description: description, mode: mode
          end

          ##
          # Adds a boolean field to the nested schema of a record field.
          #
          # This can only be called on fields that are of type `RECORD`.
          #
          # @param [String] name The field name. The name must contain only
          #   letters (a-z, A-Z), numbers (0-9), or underscores (_), and must
          #   start with a letter or underscore. The maximum length is 128
          #   characters.
          # @param [String] description A description of the field.
          # @param [Symbol] mode The field's mode. The possible values are
          #   `:nullable`, `:required`, and `:repeated`. The default value is
          #   `:nullable`.
          #
          def boolean name, description: nil, mode: :nullable
            record_check!

            add_field name, :boolean, description: description, mode: mode
          end

          ##
          # Adds a bytes field to the nested schema of a record field.
          #
          # This can only be called on fields that are of type `RECORD`.
          #
          # @param [String] name The field name. The name must contain only
          #   letters (a-z, A-Z), numbers (0-9), or underscores (_), and must
          #   start with a letter or underscore. The maximum length is 128
          #   characters.
          # @param [String] description A description of the field.
          # @param [Symbol] mode The field's mode. The possible values are
          #   `:nullable`, `:required`, and `:repeated`. The default value is
          #   `:nullable`.
          #
          def bytes name, description: nil, mode: :nullable
            record_check!

            add_field name, :bytes, description: description, mode: mode
          end

          ##
          # Adds a timestamp field to the nested schema of a record field.
          #
          # This can only be called on fields that are of type `RECORD`.
          #
          # @param [String] name The field name. The name must contain only
          #   letters (a-z, A-Z), numbers (0-9), or underscores (_), and must
          #   start with a letter or underscore. The maximum length is 128
          #   characters.
          # @param [String] description A description of the field.
          # @param [Symbol] mode The field's mode. The possible values are
          #   `:nullable`, `:required`, and `:repeated`. The default value is
          #   `:nullable`.
          #
          def timestamp name, description: nil, mode: :nullable
            record_check!

            add_field name, :timestamp, description: description, mode: mode
          end

          ##
          # Adds a time field to the nested schema of a record field.
          #
          # This can only be called on fields that are of type `RECORD`.
          #
          # @param [String] name The field name. The name must contain only
          #   letters (a-z, A-Z), numbers (0-9), or underscores (_), and must
          #   start with a letter or underscore. The maximum length is 128
          #   characters.
          # @param [String] description A description of the field.
          # @param [Symbol] mode The field's mode. The possible values are
          #   `:nullable`, `:required`, and `:repeated`. The default value is
          #   `:nullable`.
          #
          def time name, description: nil, mode: :nullable
            record_check!

            add_field name, :time, description: description, mode: mode
          end

          ##
          # Adds a datetime field to the nested schema of a record field.
          #
          # This can only be called on fields that are of type `RECORD`.
          #
          # @param [String] name The field name. The name must contain only
          #   letters (a-z, A-Z), numbers (0-9), or underscores (_), and must
          #   start with a letter or underscore. The maximum length is 128
          #   characters.
          # @param [String] description A description of the field.
          # @param [Symbol] mode The field's mode. The possible values are
          #   `:nullable`, `:required`, and `:repeated`. The default value is
          #   `:nullable`.
          #
          def datetime name, description: nil, mode: :nullable
            record_check!

            add_field name, :datetime, description: description, mode: mode
          end

          ##
          # Adds a date field to the nested schema of a record field.
          #
          # This can only be called on fields that are of type `RECORD`.
          #
          # @param [String] name The field name. The name must contain only
          #   letters (a-z, A-Z), numbers (0-9), or underscores (_), and must
          #   start with a letter or underscore. The maximum length is 128
          #   characters.
          # @param [String] description A description of the field.
          # @param [Symbol] mode The field's mode. The possible values are
          #   `:nullable`, `:required`, and `:repeated`. The default value is
          #   `:nullable`.
          #
          def date name, description: nil, mode: :nullable
            record_check!

            add_field name, :date, description: description, mode: mode
          end

          ##
          # Adds a record field to the nested schema of a record field. A block
          # must be passed describing the nested fields of the record. For more
          # information about nested and repeated records, see [Preparing Data
          # for BigQuery](https://cloud.google.com/bigquery/docs/loading-data#loading_denormalized_nested_and_repeated_data).
          #
          # This can only be called on fields that are of type `RECORD`.
          #
          # @param [String] name The field name. The name must contain only
          #   letters (a-z, A-Z), numbers (0-9), or underscores (_), and must
          #   start with a letter or underscore. The maximum length is 128
          #   characters.
          # @param [String] description A description of the field.
          # @param [Symbol] mode The field's mode. The possible values are
          #   `:nullable`, `:required`, and `:repeated`. The default value is
          #   `:nullable`.
          # @yield [nested_schema] a block for setting the nested schema
          # @yieldparam [Schema] nested_schema the object accepting the
          #   nested schema
          #
          # @example
          #   require "google/cloud/bigquery"
          #
          #   bigquery = Google::Cloud::Bigquery.new
          #   dataset = bigquery.dataset "my_dataset"
          #   table = dataset.create_table "my_table"
          #
          #   table.schema do |schema|
          #     schema.string "first_name", mode: :required
          #     schema.record "cities_lived", mode: :repeated do |cities_lived|
          #       cities_lived.record "city", mode: :required do |city|
          #         city.string "name", mode: :required
          #         city.string "country", mode: :required
          #       end
          #       cities_lived.integer "number_of_years", mode: :required
          #     end
          #   end
          #
          def record name, description: nil, mode: nil
            record_check!

            # TODO: do we need to raise if no block was given?
            raise ArgumentError, "a block is required" unless block_given?

            nested_field = add_field name, :record, description: description,
                                                    mode:        mode
            yield nested_field
            nested_field
          end

          # @private
          def self.from_gapi gapi
            new.tap do |f|
              f.instance_variable_set :@gapi, gapi
              f.instance_variable_set :@original_json, gapi.to_json
            end
          end

          # @private
          def to_gapi
            @gapi
          end

          # @private
          def == other
            return false unless other.is_a? Field
            to_gapi.to_h == other.to_gapi.to_h
          end

          # @private
          def to_hash
            h = {
              name: name,
              type: type,
              mode: mode
            }
            h[:description] = description if description
            h[:fields] = fields.map(&:to_hash) if record?
            h
          end

          protected

          def frozen_check!
            return unless frozen?
            raise ArgumentError, "Cannot modify a frozen field"
          end

          def record_check!
            return unless type != "RECORD"
            raise ArgumentError,
                  "Cannot add fields to a non-RECORD field (#{type})"
          end

          def add_field name, type, description: nil, mode: :nullable
            frozen_check!

            new_gapi = Google::Apis::BigqueryV2::TableFieldSchema.new(
              name:        String(name),
              type:        verify_type(type),
              description: description,
              mode:        verify_mode(mode),
              fields:      []
            )

            # Remove any existing field of this name
            @gapi.fields ||= []
            @gapi.fields.reject! { |f| f.name == new_gapi.name }
            # Add to the nested fields
            @gapi.fields << new_gapi

            # return the public API object
            Field.from_gapi new_gapi
          end

          def verify_type type
            type = type.to_s.upcase
            unless TYPES.include? type
              raise ArgumentError, "Type '#{type}' not found"
            end
            type
          end

          def verify_mode mode
            mode = :nullable if mode.nil?
            mode = mode.to_s.upcase
            unless MODES.include? mode
              raise ArgumentError "Unable to determine mode for '#{mode}'"
            end
            mode
          end
        end
      end
    end
  end
end
