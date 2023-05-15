# Copyright 2015 Google LLC
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
      ##
      # # ExtractJob
      #
      # A {Job} subclass representing an export operation that may be performed
      # on a {Table}. A ExtractJob instance is created when you call
      # {Table#extract_job}.
      #
      # @see https://cloud.google.com/bigquery/docs/exporting-data
      #   Exporting Data From BigQuery
      # @see https://cloud.google.com/bigquery/docs/reference/v2/jobs Jobs API
      #   reference
      #
      # @example
      #   require "google/cloud/bigquery"
      #
      #   bigquery = Google::Cloud::Bigquery.new
      #   dataset = bigquery.dataset "my_dataset"
      #   table = dataset.table "my_table"
      #
      #   extract_job = table.extract_job "gs://my-bucket/file-name.json",
      #                                   format: "json"
      #   extract_job.wait_until_done!
      #   extract_job.done? #=> true
      #
      class ExtractJob < Job
        ##
        # The URI or URIs representing the Google Cloud Storage files to which
        # the data is exported.
        def destinations
          Array @gapi.configuration.extract.destination_uris
        end

        ##
        # The table from which the data is exported. This is the table upon
        # which {Table#extract_job} was called.
        #
        # @return [Table] A table instance.
        #
        def source
          table = @gapi.configuration.extract.source_table
          return nil unless table
          retrieve_table table.project_id,
                         table.dataset_id,
                         table.table_id
        end

        ##
        # Checks if the export operation compresses the data using gzip. The
        # default is `false`.
        #
        # @return [Boolean] `true` when `GZIP`, `false` otherwise.
        #
        def compression?
          val = @gapi.configuration.extract.compression
          val == "GZIP"
        end

        ##
        # Checks if the destination format for the data is [newline-delimited
        # JSON](http://jsonlines.org/). The default is `false`.
        #
        # @return [Boolean] `true` when `NEWLINE_DELIMITED_JSON`, `false`
        #   otherwise.
        #
        def json?
          val = @gapi.configuration.extract.destination_format
          val == "NEWLINE_DELIMITED_JSON"
        end

        ##
        # Checks if the destination format for the data is CSV. Tables with
        # nested or repeated fields cannot be exported as CSV. The default is
        # `true`.
        #
        # @return [Boolean] `true` when `CSV`, `false` otherwise.
        #
        def csv?
          val = @gapi.configuration.extract.destination_format
          return true if val.nil?
          val == "CSV"
        end

        ##
        # Checks if the destination format for the data is
        # [Avro](http://avro.apache.org/). The default is `false`.
        #
        # @return [Boolean] `true` when `AVRO`, `false` otherwise.
        #
        def avro?
          val = @gapi.configuration.extract.destination_format
          val == "AVRO"
        end

        ##
        # The character or symbol the operation uses to delimit fields in the
        # exported data. The default is a comma (,).
        #
        # @return [String] A string containing the character, such as `","`.
        #
        def delimiter
          val = @gapi.configuration.extract.field_delimiter
          val = "," if val.nil?
          val
        end

        ##
        # Checks if the exported data contains a header row. The default is
        # `true`.
        #
        # @return [Boolean] `true` when the print header configuration is
        #   present or `nil`, `false` otherwise.
        #
        def print_header?
          val = @gapi.configuration.extract.print_header
          val = true if val.nil?
          val
        end

        ##
        # The number of files per destination URI or URI pattern specified in
        # {#destinations}.
        #
        # @return [Array<Integer>] An array of values in the same order as the
        #   URI patterns.
        #
        def destinations_file_counts
          Array @gapi.statistics.extract.destination_uri_file_counts
        end

        ##
        # A hash containing the URI or URI pattern specified in
        # {#destinations} mapped to the counts of files per destination.
        #
        # @return [Hash<String, Integer>] A Hash with the URI patterns as keys
        #   and the counts as values.
        #
        def destinations_counts
          Hash[destinations.zip destinations_file_counts]
        end

        ##
        # Yielded to a block to accumulate changes for an API request.
        class Updater < ExtractJob
          ##
          # @private Create an Updater object.
          def initialize gapi
            @gapi = gapi
          end

          ##
          # @private Create an Updater from an options hash.
          #
          # @return [Google::Cloud::Bigquery::ExtractJob::Updater] A job
          #   configuration object for setting query options.
          def self.from_options service, table, storage_files, options = {}
            job_ref = service.job_ref_from options[:job_id], options[:prefix]
            storage_urls = Array(storage_files).map do |url|
              url.respond_to?(:to_gs_url) ? url.to_gs_url : url
            end
            dest_format = options[:format]
            if dest_format.nil?
              dest_format = Convert.derive_source_format storage_urls.first
            end
            req = Google::Apis::BigqueryV2::Job.new(
              job_reference: job_ref,
              configuration: Google::Apis::BigqueryV2::JobConfiguration.new(
                extract: Google::Apis::BigqueryV2::JobConfigurationExtract.new(
                  destination_uris: Array(storage_urls),
                  source_table:     table
                ),
                dry_run: options[:dryrun]
              )
            )

            updater = ExtractJob::Updater.new req
            updater.compression = options[:compression]
            updater.delimiter = options[:delimiter]
            updater.format = dest_format
            updater.header = options[:header]
            updater.labels = options[:labels] if options[:labels]
            updater
          end

          ##
          # Sets the geographic location where the job should run. Required
          # except for US and EU.
          #
          # @param [String] value A geographic location, such as "US", "EU" or
          #   "asia-northeast1". Required except for US and EU.
          #
          # @example
          #   require "google/cloud/bigquery"
          #
          #   bigquery = Google::Cloud::Bigquery.new
          #   dataset = bigquery.dataset "my_dataset"
          #   table = dataset.table "my_table"
          #
          #   destination = "gs://my-bucket/file-name.csv"
          #   extract_job = table.extract_job destination do |j|
          #     j.location = "EU"
          #   end
          #
          #   extract_job.wait_until_done!
          #   extract_job.done? #=> true
          #
          # @!group Attributes
          def location= value
            @gapi.job_reference.location = value
            return unless value.nil?

            # Treat assigning value of nil the same as unsetting the value.
            unset = @gapi.job_reference.instance_variables.include? :@location
            @gapi.job_reference.remove_instance_variable :@location if unset
          end

          ##
          # Sets the compression type.
          #
          # @param [String] value The compression type to use for exported
          #   files. Possible values include `GZIP` and `NONE`. The default
          #   value is `NONE`.
          #
          # @!group Attributes
          def compression= value
            @gapi.configuration.extract.compression = value
          end

          ##
          # Sets the field delimiter.
          #
          # @param [String] value Delimiter to use between fields in the
          #   exported data. Default is <code>,</code>.
          #
          # @!group Attributes
          def delimiter= value
            @gapi.configuration.extract.field_delimiter = value
          end

          ##
          # Sets the destination file format. The default value is `csv`.
          #
          # The following values are supported:
          #
          # * `csv` - CSV
          # * `json` - [Newline-delimited JSON](http://jsonlines.org/)
          # * `avro` - [Avro](http://avro.apache.org/)
          #
          # @param [String] new_format The new source format.
          #
          # @!group Attributes
          #
          def format= new_format
            @gapi.configuration.extract.update! \
              destination_format: Convert.source_format(new_format)
          end

          ##
          # Print a header row in the exported file.
          #
          # @param [Boolean] value Whether to print out a header row in the
          #   results. Default is `true`.
          #
          # @!group Attributes
          def header= value
            @gapi.configuration.extract.print_header = value
          end

          ##
          # Sets the labels to use for the job.
          #
          # @param [Hash] value A hash of user-provided labels associated with
          #   the job. You can use these to organize and group your jobs. Label
          #   keys and values can be no longer than 63 characters, can only
          #   contain lowercase letters, numeric characters, underscores and
          #   dashes. International characters are allowed. Label values are
          #   optional. Label keys must start with a letter and each label in
          #   the list must have a different key.
          #
          # @!group Attributes
          #
          def labels= value
            @gapi.configuration.update! labels: value
          end

          ##
          # @private Returns the Google API client library version of this job.
          #
          # @return [<Google::Apis::BigqueryV2::Job>] (See
          #   {Google::Apis::BigqueryV2::Job})
          def to_gapi
            @gapi
          end
        end
      end
    end
  end
end
