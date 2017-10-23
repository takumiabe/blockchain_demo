require 'bundler'
Bundler.require

require './block'
require './transaction'

class Node
  attr_reader :name
  attr_reader :nodes, :transactions
  attr_reader :root, :current, :heads

  def initialize(name, root)
    @name = name

    # connected nodes
    @nodes = Set.new

    @blocks = {}
    @current = @root = root
    @heads = Set.new
    @blocks[root.hash] = root

    @transactions = []
  end

  def entry(transaction)
    @transactions << transaction
  end

  def append(block)
    return false unless block.hash.to_i(16) < 2 ** 16

    @blocks[block.hash] = block
    @heads << block

    true
  end

  def [](hash)
    @blocks[hash]
  end

  def each(head = nil)
    return enum_for(:each) unless block_given?

    b = head || current
    loop do
      yield b
      b = @blocks[b.prev_hash]
      break unless b
    end
  end

  def connect(block_chain)
    @nodes.add(block_chain.nodes)
  end

  # 生きている全nodeとの多数決でcurrentを進める？
  def update

    @heads.each do |head|

      rate = nodes.count { |node| !node[block].nil? }.to_r / nodes.size
      if rate > 0.5
      end
    end

    # currentが進んだら、headは全て破棄する？
    @heads.clear
  end
end
