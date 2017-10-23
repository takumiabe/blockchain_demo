
require './node'
require './miner'

root = Block.new(nil, "root", 0)

a = Node.new("node1", root)
b = Node.new("node2", root)
c = Node.new("node3", root)
b.connect(a)
c.connect(a)

# node thread
th0 = Thread.new {
  loop {
    a.each {|block| ap block }
    ap a.transactions
    sleep 2
    a.update
  }
}

# user thread
th1 = Thread.new {
  i = 0
  loop {
    i += 1
    trans = Transaction.new("hoge#{i}") {
      puts "yay! i got #{i}"
    }
    puts "i want #{i}"
    a.entry(trans)
    sleep 1
  }
}

# miner thread
th2 = Thread.new {
  miner = Miner.new(a)
  miner.run
}

th0.join
th1.join
th2.join
