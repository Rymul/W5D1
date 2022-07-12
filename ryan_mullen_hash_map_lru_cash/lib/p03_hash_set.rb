class HashSet
  # attr_reader :count
  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if self.include?(key.hash)
      return false
    else
      self[key.hash] << key.hash
      self.count += 1
      resize! if self.count >= num_buckets
    end
  end

  def include?(key)
    self[key.hash].include?(key.hash)
  end

  def remove(key)
    if self.include?(key)
      self[key.hash].delete(key.hash)
      self.count -= 1
    end
  end

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
