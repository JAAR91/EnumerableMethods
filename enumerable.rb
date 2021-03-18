module Enumerable
  def my_each()
    i = 0
    while (i - self.length).negative?
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index()
    length.times do |i|
      yield(self[i], i)
    end
  end

  def my_select()
    newarray = []
    array.each do |item|
      newarray.push(item) if yield(item)
    end
    newarray
  end

  def my_all?()
    output = true
    my_each { |item| output = false unless yield(item) }
    output
  end

  def my_any?()
    output = false
    self.my_each{|item| output = true if yield(item)}
    output
  end

  def my_none?()
    output = true
    my_each { |item| output = false if yield(item) }
    output
  end

  def my_count()
    count = 0
    self.my_each{|item| count += 1 if yield(item)}
    count
  end
end

