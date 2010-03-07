module Paperclip::ClassMethods
  def validates_attachment_presence name, options = {}
    attachment_definitions[name][:has_attachment_presence_validation] = true
    message = options[:message] || "must be set."
    validates_presence_of :"#{name}_file_name", 
                          :message => message,
                          :if      => options[:if],
                          :unless  => options[:unless]
  end
end