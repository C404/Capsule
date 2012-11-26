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

  def perform(capsule_id, logo)
    capsule = Capsule.find(capsule_id)
    logger.info "Watermarking #{capsule.video.watermark.path} ..."
    path = capsule.video.watermark.path
    tmp_path = path.gsub(/.webm$/, '')
    File.rename path, tmp_path

    command = "avconv -y -i #{tmp_path} -vf \"movie=#{logo} [watermark]; [in][watermark] overlay=0:0, format=yuv420p [out]\" #{path} 2>&1"

    VideoWatermark.logger.debug command

    res = `#{command}`
    if $?.success?
      File.unlink tmp_path
      capsule.watermarked = true
      capsule.save!
    else
      File.rename tmp_path, path
    end

    VideoWatermark.logger.debug res
  end
end
