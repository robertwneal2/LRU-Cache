class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    return 0 if self.empty? == true 
    hash_val = 0
    self.each_with_index do |ele, i|
      hash_val += ele.hash ^ i
    end
    hash_val
  end
end

class String
  def hash
    return 0 if self == ""
    hash_val = 0
    self.each_char.with_index do |char, index|
      hash_val += char.ord * index
    end
    hash_val ^ self.length.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    return 0 if self.empty? == true 
    hash_val = 0
    self.each do |k, v|
      hash_val += k.hash ^ v.hash
    end
    hash_val
  end
end

# a = 123
# b = "lol"
# c = [a,b]
# d = [a, c]
# e = a * 2
# f = {a => b, d => e}
# p a.hash
# p b.hash
# p c.hash
# p d.hash
# p e.hash
# p f.hash
# a = 124
# b = "loll"
# c = [b, a]
# d = [a, c]
# e = a * 3
# f = {d => e, a => b}
# p a.hash
# p b.hash
# p c.hash
# p d.hash
# p e.hash
# p f.hash
