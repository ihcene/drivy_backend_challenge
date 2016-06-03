class BaseModel
  # Like ActiveRecord::Relation, we define here a special Array that hold
  # our model instances and make various operations on it, like exporting as a
  # JSON
  class Relation < Array
    def initialize(array, klass)
      super(array)
      self.klass = klass
    end

    def json_export(target)
      File.open(target, 'w') do |f|
        f.write(JSON.pretty_generate(klass.datastore_name => as_json))
      end
    end

    private

    attr_accessor :klass
  end
end
