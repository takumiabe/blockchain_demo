require 'bundler'
Bundler.require
require 'digest/sha2'

class Block
  attr_reader :index, :prev_hash, :data, :on_fixed, :nonce

  def initialize(prev, data, nonce)
    # root object
    if prev == nil
      @index = 0
      @prev_hash = ""
      @data = "global-root"
    else
      @index = prev.index + 1
      @prev_hash = prev.hash
      @data = data
      @on_fixed = on_fixed
    end
    @nonce = nonce
  end

  def eq?(other)
    hash == other.hash
  end

  def hash
    @hash ||= Digest::SHA256.hexdigest [index, data, prev_hash].join
  end

  def inspect
    "#{index}:#{hash[0,6]}:{#{data}}"
  end
end
