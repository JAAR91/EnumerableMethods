module Enumerable
  def my_each()
    i = 0
    while (i < self.length)
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index()
    self.length.times do |i|
      yield(self[i], i)
    end
  end

  def my_select()
    newarray = []
    my_each{ |item| newarray.push(item) if yield(item)}
    newarray
  end

  def my_all?()
    output = true
    my_each { |item| output = false unless yield(item) }
    output
  end

  def my_any?()
    output = false
    my_each { |item| output = true if yield(item) }
    output
  end

  def my_none?()
    output = true
    my_each { |item| output = false if yield(item) }
    output
  end

  def my_count()
    count = 0
    my_each { |item| count += 1 if yield(item) }
    count
  end

  def my_map(proc = nil)
    newarray = []
    if proc.nil?
      my_each { |item| newarray.push(yield(item)) }
    else
      my_each { |item| newarray.push(proc[item]) }
    end
    newarray
  end

  def my_inject()
    result = self[0]
    my_each { |item| result = yield(result, item) }
    result
  end

  def multiply_els()
    my_inject { |factora, factorb| factora * factorb }
  end
end

p [1,2,3,4].my_select{|item| item == 2 }
