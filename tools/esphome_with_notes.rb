#!/usr/bin/env ruby
# frozen_string_literal: true

require "set"

ROOT = File.expand_path("..", __dir__)
ESPHOME = File.join(ROOT, ".venv", "bin", "esphome")
$stdout.sync = true

def usage
  warn "Usage: ruby tools/esphome_with_notes.rb <config|compile> <device.yaml> [esphome args...]"
  exit 2
end

def collect_files(path, seen = Set.new)
  absolute = File.expand_path(path, ROOT)
  return [] if seen.include?(absolute) || !File.file?(absolute)

  seen.add(absolute)
  files = [absolute]
  base = File.dirname(absolute)

  File.readlines(absolute, chomp: true).each do |line|
    next if line.lstrip.start_with?("#")

    match = line.match(/!include\s+([^\s#]+)/)
    next unless match

    include_path = match[1].delete_prefix('"').delete_suffix('"').delete_prefix("'").delete_suffix("'")
    next if include_path.start_with?("github://", "http://", "https://")

    files.concat(collect_files(File.expand_path(include_path, base), seen))
  end

  files
end

def compatibility_block(lines, start)
  block = []
  lines[start..].each do |line|
    stripped = line.strip
    break if stripped.empty?
    break if stripped.start_with?("# ----")
    break unless stripped.start_with?("#")

    block << stripped.sub(/^#\s?/, "")
  end
  block
end

usage if ARGV.length < 2

command = ARGV[0]
config_path = ARGV[1]
usage unless %w[config compile].include?(command)

puts "Compatibility notes:"
notes_found = false

collect_files(config_path).each do |file|
  lines = File.readlines(file, chomp: true)
  lines.each_with_index do |line, index|
    next unless line.strip == "# Compatibility:"

    notes_found = true
    relative = file.delete_prefix("#{ROOT}/")
    puts "- #{relative}"
    compatibility_block(lines, index).each do |entry|
      puts "  #{entry}"
    end
  end
end

puts "- none declared" unless notes_found
puts

exec(ESPHOME, *ARGV)
