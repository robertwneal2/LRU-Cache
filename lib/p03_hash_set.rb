class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if !self.include?(key)
      self[key].push(key)
      @count += 1
      if @count > num_buckets
        resize!
      end
      true
    else 
      false
    end
  end

  def include?(key)
    return self[key].include?(key)
  end

  def remove(key)
    if self.include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](val)
    # optional but useful; return the bucket corresponding to `num`
    hash_val = val.hash
    @store[hash_val % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @count = 0
    new_num_buckets = num_buckets * 2
    @store = Array.new(new_num_buckets) { Array.new }
    old_store.flatten.each { |key| self.insert(key) }
  end
end
