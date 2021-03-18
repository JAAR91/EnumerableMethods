module Enumerable
  def my_each()
    i = 0
    while (i - self.length).negative?
      yield(self[i])
      i += 1
    end
  end
end