require 'bundler'
Bundler.require

require './block'
require './transaction'

class Miner
  def initialize(node)
    @node = node
  end

  def run
    loop do
      trans = @node.transactions.first
      current = @node.current

      fin = i = rand(2**32)
      i += 1
      while fin != i
        Block.new(current, trans.data, i)
      end
    end
  end
end
