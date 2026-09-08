#!/usr/bin/env ruby
# seed-cache.rb — Prefill ./.linkyee-cache/ with sample plugin data.
#
# Run this once after cloning so the very first `bundle exec ruby ./scaffold.rb`
# produces a useful page even if you have no GitHub token, no network, or
# the GitHub unauth API rate limit (60/hour) is exhausted from frequent
# `preview.sh` rebuilds.
#
# The cache files use the same SHA1-of-key naming scheme that
# Plugin::cache(key, ttl:) uses, so the next successful network fetch
# transparently overwrites them with fresh data.
#
# Edit the `seeds` hash below to match the plugins enabled in your config.yml.

require 'json'
require 'fileutils'
require_relative 'plugins/Plugin'  # for Plugin.disk_cache_path

dir = Plugin.disk_cache_dir
FileUtils.mkdir_p(dir)

seeds = {
  # ── GithubLastCommitPlugin ────────────────────────────────────────────
  'gh-last-commit:barcuspatty/links' => {
    'sha'     => '0000000',
    'date'    => '2026-01-01',
    'message' => 'Initial commit'
  }

  # Add entries here for any other plugins you enable in config.yml, e.g.
  #   'gh-stars:owner/repo'            => '0',
  #   'gh-profile:v2:username'         => { 'followers' => 0, 'following' => 0, 'repos' => 0 },
  #   'rss:https://example.com/feed.xml' => [{ 'title' => 'Post', 'url' => 'https://example.com/post', 'date' => '2026-01-01' }],
  #   'yt-latest:@handle'              => { 'title' => 'Video', 'url' => 'https://youtube.com/watch?v=id' }
}


seeds.each do |key, value|
  path = Plugin.disk_cache_path(key)
  File.write(path, JSON.generate(value))
  puts "  #{key.ljust(48)} -> #{File.basename(path)}"
end
puts "\nWrote #{seeds.size} cache entries to #{dir}/"
