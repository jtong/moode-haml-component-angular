require "moode-haml-component-angular/version"

class  Object < BasicObject

  template_path = File.expand_path('../moode-haml-component-angular', __FILE__)

  haml_files = File.join(template_path, "*.haml")
  Dir.glob haml_files do |file|
    file_name = File.basename file , ".haml"
    method_name = file_name[1, file_name.length].to_sym
    if(not self.respond_to? method_name, true)
      self.send :define_method, method_name do |args = {}|
        template = File.read("#{template_path}/_#{method_name}.haml")
        Haml::Engine.new(template).render Object.new, args
      end
    end
  end

  containers_files = File.join(template_path, "container", "*.haml")
  Dir.glob containers_files do |file|
    file_name = File.basename file , ".haml"
    method_name = file_name[1, file_name.length].to_sym
    if(not self.respond_to? method_name)
      self.send :define_method, method_name do |args = {}, &block|
        container "#{template_path}/container/_#{method_name}.haml", args, &block
      end
    end
  end


end