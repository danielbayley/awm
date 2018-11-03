#! /usr/bin/ruby -r yaml -r json

inject = -> *, uid:, config:, ** {
  return unless code = Dir["objects/#{uid}.*"].first
  config["#{code[/apple/]}script"] = File.read(code).lines[1..-1].join
}

info = YAML.load ARGF.read, symbolize_names: true
# Reinject [any] seperate scripts.
info[:objects].reduce self, &inject
# Reinject README
readme = Dir.glob 'README*', File::FNM_CASEFOLD
info[:readme] = File.read readme.first if readme.any?

print JSON[info]
