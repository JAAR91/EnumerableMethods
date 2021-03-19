module Enumerable
  def my_each()
    return self.to_enum unless block_given?
    i = 0
    while (i < self.to_a.length)
      yield(self.to_a[i])
      i += 1
    end
    self
  end

  def my_each_with_index()
    return self.to_enum unless block_given?
    self.to_a.length.times do |i|
      yield(self.to_a[i], i)
    end
    self
  end

  def my_select()
    newarray = []
    my_each{ |item| newarray.push(item) if yield(item)}
    newarray
  end

  def my_all?(arg=nil)
    unless block_given?
      if arg.is_a?(Class)
        p "class"
        my_each { |item| return false unless item.is_a?(arg) }
        return true
      elsif arg.is_a?(Regexp)
        p "regexp"
        my_each { |item| return false if item.scan(arg).length.zero? }     
        return true     
      elsif arg.nil?
        p "empty"
        self.my_each{|i| return false unless !!i}
        return true
      else
        p "pattern"
        return false
      end
    end    
    my_each { |item| return false unless yield(item) }
    return true
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

p %w[one two four].my_all?(Array)
