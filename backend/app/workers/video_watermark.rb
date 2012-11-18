# -*- coding: utf-8 -*-
##
## video_watermark.rb
## Login : <lta@still>
## Started on  Sun Nov 18 06:03:05 2012 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2012 Lta Akr
##

class VideoWatermark
  class << self
    def logger
      @logger = Logger.new(Rails.root.join('log', 'watermark.log')) unless @logger
      @logger
    end
  end

  include Sidekiq::Worker

  def perform(path, logo)
    tmp_path = File.basename(path, File.basename(path))
    tmp_path = "#{File.dirname path}/#{tmp_path}_watermark-tmp#{File.extname path}"
    puts `ls -la #{tmp_path}`
    File.rename path, tmp_path
    puts "avconv –i #{tmp_path} -vf \"movie=#{logo} [watermark]; [in][watermark] overlay=main_w-overlay_w-10:main_h-overlay_h-10 [out]\" #{path} 2>&1"
    res = `avconv –i #{tmp_path} -vf "movie=#{logo} [watermark]; [in][watermark] overlay=main_w-overlay_w-10:main_h-overlay_h-10 [out]" #{path} 2>&1`
    File.unlink tmp_path
    puts res
    VideoWatermark.logger.info res
  end
end
