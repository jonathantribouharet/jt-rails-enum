module JT
	module Rails
		module Enum

			module Enumerable
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
								klass.scope "#{field}_not_#{value}", -> { klass.where.not(field => i) }
							end

							validates field, allow_nil: true, inclusion: { in: klass.send(field.to_s.pluralize).values } 

						end
					end
				end
			end

			class Railtie < ::Rails::Railtie
				initializer 'jt_rails_enum.insert_into_active_record' do |app|
					ActiveSupport.on_load :active_record do
						ActiveRecord::Base.send(:include, JT::Rails::Enum::Enumerable)
					end
				end

			end

		end
	end
end
