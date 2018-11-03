#! /usr/bin/ruby -r json -r yaml

languages = {
  sh: '/bin/bash',
  php: '/usr/bin/php',
  rb: '/usr/bin/ruby',
  py: '/usr/bin/python',
  pl: '/usr/bin/perl',
  zsh: '/bin/zsh',
  applescript: '/usr/bin/osascript',
  js: '/usr/bin/osascript -l JavaScript'
}

scripts = -> key, value { key =~ /script$/ and value.lines.length > 1 }

extract = -> *, uid:, config:, ** {
  return unless code = config.find(&scripts)&.last
  ext, bin = languages.entries[config[:type]||6]
  `mkdir -p objects`
  File.write "objects/#{uid}.#{ext}", "#! #{bin}\n#{code}"
  code.clear
}
class Hash
  def compact!
    reduce(self) do | hash, (key, value) |
      case
      when value.class == Hash
        value.empty? ? hash.delete(key) : value.compact!
      when value.class == Array
        value.map { |i| i.compact! if i.respond_to? :compact! }
      when value.to_s.empty? || value == 0 then hash.delete key
      end
      hash
    end
  end
end

info = JSON.parse ARGF.read, symbolize_names: true

# Extract [any] scripts to seperate files.
info[:objects].reduce({}, &extract)

# Remove [any] unexported variables.
info[:variables]&.delete_if { |v| info[:variablesdontexport].include? v.to_s }
info.delete :variablesdontexport

info.delete :disabled
info.delete :readme

# Sort keys.
order = %i[
  name
  version
  description
  category
  bundleid
  createdby
  webaddress
]
rest = info.keys - order += [:objects]
order += rest.sort
info = order.zip(info.values_at *order).to_h

info.compact! # Strip [any] empty data.

print JSON.parse(JSON[info]).to_yaml line_width: -1
