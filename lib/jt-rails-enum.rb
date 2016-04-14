module JT
	module Rails
		module Enum
			extend ActiveSupport::Concern

			class_methods do

				def jt_enum(definitions)
					klass = self

					definitions.each do |field, values|

						enum_values = ActiveSupport::HashWithIndifferentAccess.new

						klass.singleton_class.send(:define_method, field.to_s.pluralize) { enum_values }

						values.each_with_index do |value, i|
							value_method_name = "#{field}_#{value}"

							enum_values[value] = i

							define_method("#{value_method_name}?") { self[field] == i }
							define_method("#{value_method_name}!") { update! field => i }

							klass.scope value_method_name, -> { klass.where field => i }
						end

						validates field, allow_nil: true, inclusion: { in: klass.send(field.to_s.pluralize).values } 

					end
				end
			end
		end
	end
end

ActiveRecord::Base.send :include, JT::Rails::Enum