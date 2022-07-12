class Integer
  # Integer#hash already implemented for you
end

class Array # [1,2,3] then [3,2,1]
  def hash
    self.each_with_index.inject(0) do |acc, (n, i)|
        acc ^ (n.hash + i.hash)
    end
  end
end

class String
  def hash
    
    arr = self.chars.map {|char| char.ord }
    arr.hash

  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = self.to_a.map {|pair| pair[0].to_s.ord.hash + pair[1].to_s.ord.hash }
    sorted = arr.sort
    sorted.hash
  end

end
