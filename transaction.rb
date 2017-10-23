require 'bundler'
Bundler.require

class Transaction < Struct.new(nil, :data, :on_fixed)
end
