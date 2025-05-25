# frozen_string_literal: true

module Searchable
  extend ActiveSupport::Concern

  included do
    # Dynamically define searchable attributes based on string columns
    def self.searchable_attributes
      @searchable_attributes ||= columns_hash.select do |name, column|
        column.type == :string && name != 'id'
      end.keys.freeze
    end

    pg_search_scope :whose_fullname_contains,
                    against: :name,
                    using: {
                      tsearch: { prefix: true }
                    }

    def self.advanced_search(params) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
      return all if params.blank? || params[:attribute_name].blank? || params[:attribute_value].blank?

      # Validate that the attribute is searchable
      return none unless searchable_attributes.include?(params[:attribute_name])

      column = columns_hash[params[:attribute_name]]
      value = params[:attribute_value]

      case column&.type
      when :integer, :bigint
        if defined_enums[params[:attribute_name]]
          # For enum columns, search in the enum values
          enum_values = defined_enums[params[:attribute_name]].keys
          matching_values = case params[:match_type]
                            when 'starts_with'
                              enum_values.select { |v| v.to_s.downcase.start_with?(value.downcase) }
                            when 'ends_with'
                              enum_values.select { |v| v.to_s.downcase.end_with?(value.downcase) }
                            when 'contains'
                              enum_values.select { |v| v.to_s.downcase.include?(value.downcase) }
                            else
                              enum_values.select { |v| v.to_s.downcase == value.downcase }
                            end

          if matching_values.any?
            where(params[:attribute_name] => matching_values)
          else
            none
          end
        else
          # For regular integer columns, use exact matching
          where(params[:attribute_name] => value.to_i)
        end
      when :date, :datetime, :timestamp
        # For date columns, try to parse the date
        begin
          parsed_date = Date.parse(value)
          where(params[:attribute_name] => parsed_date)
        rescue Date::Error
          # If date parsing fails, return no results
          none
        end
      else
        # For text columns, use ILIKE with the specified match type
        case params[:match_type]
        when 'starts_with'
          where("#{params[:attribute_name]} ILIKE ?", "#{value}%")
        when 'ends_with'
          where("#{params[:attribute_name]} ILIKE ?", "%#{value}")
        when 'contains'
          where("#{params[:attribute_name]} ILIKE ?", "%#{value}%")
        else
          where(params[:attribute_name] => value)
        end
      end
    end
  end
end
