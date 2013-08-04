require "moode-haml-component-angular/version"

template_path = File.expand_path('../moode-haml-component-angular', __FILE__)

haml_files = File.join(template_path, "*.haml")
Dir.glob haml_files do |file|
  file_name = File.basename file , ".haml"
  puts file_name
  method_name = file_name[1, file_name.length].to_sym
  if(not self.respond_to? method_name)
    self.define_singleton_method method_name do |args = {}|
      template = load_component_template(method_name)
      Haml::Engine.new(template).render Object.new, args
    end
  end
end

containers_files = File.join(template_path, "container", "*.haml")
Dir.glob containers_files do |file|
  file_name = File.basename file , ".haml"
  method_name = file_name[1, file_name.length].to_sym
  if(not self.respond_to? method_name)
    self.define_singleton_method method_name do |args = {}, &block|
      container "component/container/#{method_name}.haml", args, &block
    end
  end
end
