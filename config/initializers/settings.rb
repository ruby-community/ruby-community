config_path = Rails.root.join("config", "application.yml")

unless File.exist?(config_path)
  abort "Please copy config/application.example.yml to config/application.yml!"
end

RubyCommunity::Settings = YAML.load_file(config_path)
