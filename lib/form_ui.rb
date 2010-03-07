module ActiveScaffold
  module Helpers
    module FormColumnHelpers
      def active_scaffold_input_paperclip(column, options)
        if @record.send("#{column.name}_file_name") 
          if @record.send(column.name).styles.include?(:thumb)
           content = image_tag(@record.send(column.name).url(:thumb), :border => 0)            
          else 
            content = @record.send("#{column.name}_file_name")            
          end
                      
          action_label, delete_attachment_field = unless @record.class.attachment_definitions[:doc][:has_attachment_presence_validation]
            [:remove_file,
            "p.next().insert('" + hidden_field("record[#{column.name}]".to_sym, "delete_#{column.name}", :value => "false") + "'); "]
          else
            [:replace_file, nil]
          end

            content_tag(
              :div, 
              link_to(content, @record.send(column.name).url, :popup => true) + " " + 
              " | " +
              link_to_function(as_(action_label), "$(this).previous().value='true'; p=$(this).up(); p.hide(); #{delete_attachment_field} p.next().insert('" + file_field(:record, column.name, options) + "'); p.next().show()")
            ) +
            content_tag(
              :div,
              '',
              :style => "display: none"
            )
        else
          file_field(:record, column.name, options)
        end
      end
    end
  end
end