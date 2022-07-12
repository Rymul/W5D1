class MaxIntSet
  attr_reader :store
  
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    if self.store[num]
      return false
    else
      self.store[num] = true
    end
  end

  def remove(num)
    validate!(num)
    self.store[num] = false
  end

  def include?(num)
    validate!(num)
    self.store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, self.store.length-1)
  end

  def validate!(num)
    raise 'Out of bounds' if !is_valid?(num)
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    if self.store.include?(num)
      return false
    else
      idx = num % 20
      self.store[idx] << num
    end
  end

  def remove(num)
    idx = num % 20
    self.store[idx].delete(num) #if self.store.include?(num)
  end

  def include?(num)
    idx = num % 20
    self.store[idx].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    idx = num % 20
    self.store[idx]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  # attr_reader :store #, :count
  attr_accessor :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    # @num_buckets = num_buckets
  end

  def insert(num)
    # idx = num % num_buckets
    if self.include?(num)
      return false
    else
      self[num] << num
      self.count += 1
      resize! if self.count >= num_buckets
    end
  end

  def remove(num)
    # idx = num % num_buckets
    if self.include?(num)
      self[num].delete(num)
      self.count -= 1
    end
  end

  def include?(num)
    # idx = num % num_buckets
    self[num].include?(num)
  end

  # def count
  #   self.count += 1 if self.insert(num)
  # end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    idx = num % num_buckets
    self.store[idx]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = self.store
    self.count = 0
    self.store = Array.new(num_buckets * 2) {Array.new}
    old_store.flatten.each { |ele| self.insert(ele) }
  end
end
