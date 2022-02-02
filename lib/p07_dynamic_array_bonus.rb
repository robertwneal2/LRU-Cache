require 'byebug'

class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray

  include Enumerable

  attr_accessor :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    # debugger
    return nil if i >= capacity
    i = @count + i if i < 0
    @store[i]
  end

  def []=(i, val)
    if i > capacity - 1
      resize!
      self[i] = val
    end
    i = @count + i if i < 0
    @count += 1 if @store[i] == nil
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.each do |ele|
      return true if ele == val
    end
    false
  end

  def push(val)
    resize! if @count == capacity
    @store[@count] = val
    @count += 1
  end

  def unshift(val)
    resize! if @count == capacity
    (1..capacity - 1).reverse_each do |i|
      @store[i], @store[i-1] = @store[i-1], @store[i]
    end
    @store[0] = val
    @count +=1
  end

  def pop
    return nil if @count == 0
    pop_val = last
    @count -= 1
    @store[@count] = nil
    pop_val
  end

  def shift
    # debugger
    return nil if @count == 0
    shift_val = first
    @store[0] = nil
    (0...capacity - 1).each do |i|
      @store[i], @store[i+1] = @store[i+1], @store[i]
    end
    @count -= 1
    shift_val
  end

  def first
    @store[0]
  end

  def last
    @store[@count-1]
  end

  def each
    i = 0
    while i < @count
      yield @store[i]
      i += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    (0...capacity).each do |i|
      return false if self[i] != other[i]
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    # debugger
    old_store = @store
    old_capacity = capacity
    @store = Array.new(capacity*2)
    (0...old_capacity).each do |i|
      @store[i] = old_store[i]
    end
  end
end
