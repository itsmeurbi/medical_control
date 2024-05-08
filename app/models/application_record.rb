# frozen_string_literal: true

require 'csv'

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.to_csv
    attributes = column_names
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.find_each do |patient|
        csv << attributes.map { |attr| patient.send(attr) }
      end
    end
  end
end
