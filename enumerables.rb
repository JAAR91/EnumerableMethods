# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    while i < to_a.length
      yield(to_a[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    to_a.length.times do |i|
      yield(to_a[i], i)
    end
    self
  end

  def my_select
    newarray = []
    my_each { |item| newarray.push(item) if yield(item) }
    newarray
  end

  def my_all?(arg = nil)
    unless block_given?
      if arg.is_a?(Class)
        my_each { |item| return false unless item.is_a?(arg) }
        return true
      elsif arg.is_a?(Regexp)
        my_each { |item| return false if item.scan(arg).length.zero? }
        return true
      elsif arg.nil?
        my_each { |i| return false unless i }
        return true
      end
    end
    my_each { |item| return false unless yield(item) }
    true
  end

  def my_any?(arg = nil)
    unless block_given?
      if arg.is_a?(Class)
        my_each { |item| return true if item.is_a?(arg) }
        return false
      elsif arg.is_a?(Regexp)
        my_each { |item| return true unless item.scan(arg).length.zero? }
        return false
      elsif arg.nil?
        my_each { |item| return true if item }
        return false
      end
    end
    my_each { |item| return true if yield(item) }
    false
  end

  def my_none?(arg = nil)
    unless block_given?
      if arg.is_a?(Class)
        my_each { |item| return false if item.is_a?(arg) }
        return true
      elsif arg.is_a?(Regexp)
        my_each { |item| return false unless item.scan(arg).length.zero? }
        return true
      elsif arg.nil?
        my_each { |i| return false if i }
        return true
      end
    end
    my_each { |item| return false if yield(item) }
  end

  def my_count
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

  def my_inject
    result = self[0]
    my_each { |item| result = yield(result, item) }
    result
  end

  def multiply_els
    my_inject { |factora, factorb| factora * factorb }
  end
end

p [1, 2, 3, 4].my_none?
