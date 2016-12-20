module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(filtering_params)
      results = self.where(nil)
      filtering_params.each do |key, value|
        # The value will be downcased to make it a case insensitive query
        value.downcase! if value.is_a?(String)
        results = results.public_send(key, value) if value.present?
      end
      results
    end
  end
end
