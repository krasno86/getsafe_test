# frozen_string_literal: true

require_relative 'lib/image_saver'

ImageSaver.new(ARGV[0]).call
