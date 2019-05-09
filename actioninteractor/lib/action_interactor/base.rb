# frozen_string_literal: true

module ActionInteractor
  class Base
    attr_reader :params, :results

    def initialize(params)
      @params = params
      reset!
    end

    def execute
      # if the interactor already finished execution, do nothing.
      return if finished?
      # if contract is not satisfied= (ex: params is empty), mark as failed.
      return fail! if params.nil?
      # implement some codes
      # if finished execution, mark as success.
      success!
    end

    def execute!
      execute
      success? || raise(ExecutionError.new("Failed to execute the interactor"))
    end

    def finished?
      @_finished
    end

    def unfinished?
      !finished?
    end

    def success?
      @_success
    end

    def failure?
      !success?
    end

    def aborted?
      failure? && unfinished?
    end

    def reset!
      @results = Results.new
      @_success = false
      @_finished = false
    end

    def abort!
      @_success = false
      @_finished = false
    end

    def success!
      @_success = true
      @_finished = true
    end

    def fail!
      @_success = false
      @_finished = true
    end

    class << self
      def execute(params)
        new(params).tap(&:execute)
      end

      def execute!(params)
        new(params).tap(&:execute!)
      end
    end
  end

  class ExecutionError < StandardError; end
end
