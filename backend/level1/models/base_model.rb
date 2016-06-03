require 'active_model'

# This is a homemade base model that provides rails like methodes like
# attributes initializer and reader
# It also grant models with JSON serialization capabilities
class BaseModel
  include ActiveModel::Serializers::JSON

  # Read data.json once for all models
  DATASTORE = JSON.parse(File.new('data.json').read)

  def initialize(params = {})
    params ||= {}
    params.each_pair do |k, v|
      public_send(:"#{k}=", v) if v.present?
    end
  end

  # All instance variables are delivered as a hash
  def attributes
    instance_values
  end

  def self.find(id)
    all.find { |e| e.id == id.to_i }
  end

  # Turn data.json data into models and wrap the list on a special Array defined
  # in models/base_model/relation
  def self.all
    Relation.new(
      DATASTORE[datastore_name].map { |attrs| new(attrs) },
      self)
  end

  def self.datastore_name
    name.downcase.tableize.tr('/', '_')
  end
end
