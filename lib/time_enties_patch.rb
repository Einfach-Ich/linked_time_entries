module TimeEntries
	module Patches
		module LinkedTimeEntriesPatch
			def self.included(base) # :nodoc:
				#base.extend(ClassMethods)
				base.send(:include, InstanceMethods)

				base.class_eval do
					alias_method_chain :format_criteria_value, :linked			
				end
			end
      
		module ClassMethods
			
		end
      
		module InstanceMethods	  
			def format_criteria_value_with_linked(criteria_options, value)
				if value.blank?
					  "[#{l(:label_none)}]"
					elsif k = criteria_options[:klass]
					  obj = k.find_by_id(value.to_i)
					  if obj.is_a?(Issue)
						obj.visible? ? link_to_issue(obj) : "##{obj.id}"
					  else
						obj
					  end
					elsif cf = criteria_options[:custom_field]
					  format_value(value, cf)
					else
					  value.to_s
				end
			end
		end
	end
  end
end

