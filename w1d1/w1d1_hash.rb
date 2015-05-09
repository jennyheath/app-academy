class MyHashSet
  attr_reader :store

  def initialize
    @store = Hash.new
  end

  def insert(el)
    @store[el] = true
  end

  def include?(el)
    if @store[el] == true
      true
    else
      false
    end
  end

  def delete(el)
    if @store.include?(el)
      @store.delete(el)
      return true
    else
      return false
    end
  end

  def to_a
    arr = []
    @store.each do |key, value|
      arr << key
    end
    return arr
  end

  def union(set2)
    unionized = MyHashSet.new
    @store.each { | key, value | unionized.insert(key) }
    set2.store.each do | key, value |
      if !unionized.include?(key)
        unionized.insert(key)
      end
    end
    return unionized
  end

  def intersect(set2)
    intersection = MyHashSet.new
    @store.each do |key, value|
      if set2.store.include?(key)
        intersection.insert(key)
      end
    end
    return intersection
  end

  def minus(set2)
    minus = MyHashSet.new
    @store.each do |key, value|
      if !set2.store.include?(key)
        minus.insert(key)
      end
    end
    return minus
  end
end

test_set = MyHashSet.new
test_set.insert(:a)
test_set.insert(:b)
test_set.insert(:c)
# p test_set.include?(:d)
# p test_set.to_a
test_set_2 = MyHashSet.new
test_set_2.insert(:d)
test_set_2.insert(:b)
# puts test_set
# p test_set.union(test_set_2)
# p test_set.intersect(test_set_2)
