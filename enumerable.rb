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
end

