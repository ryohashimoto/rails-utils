# frozen_string_literal: true

require "forwardable"

module ActionInteractor
  # == Action \Interactor \Results
  # Provides a +Hash+ like object to Action Interactors execution results.
  class Results
    include Enumerable
    extend Forwardable

    attr_reader :results

    def_delegators :@results, :clear, :keys, :values, :[], :delete

    def initialize(*)
      @results = {}
    end

    # Add +result+ to the results hash.
    def add(attribute, result)
      results[attribute.to_sym] = result
    end

    # Delete a result for +key+.
    def delete(key)
      attribute = key.to_sym
      results.delete(attribute)
    end

    # Iterates through each result key, value pair in the results hash.
    def each
      results.each_key do |attribute|
        yield attribute, results[attribute]
      end
    end
  end
end
