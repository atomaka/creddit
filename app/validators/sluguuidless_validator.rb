# validators/sluguuidless_validator.rb
class SluguuidlessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.slug.match /([a-z0-9]+\-){4}[a-z0-9]+\z/
      record.errors[attribute] << "#{value} must be unique"
    end
  end
end
