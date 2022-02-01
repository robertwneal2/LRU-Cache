require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    # debugger
    if @map.include?(key)
      val = @store.remove(key)
      update_node!(key,val)
    else
      val = calc!(key)
      if count > @max
        eject!
      end
      val
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    node = @store.append(key,val)
    @map.set(key,node)
    val
  end

  def update_node!(key,val)
    # suggested helper method; move a node to the end of the list
    node = @store.append(key,val)
    @map.set(key,node)
    val
  end

  def eject!
    delete_key = @store.first.key
    @store.remove(delete_key)
    @map.delete(delete_key)
  end
end
