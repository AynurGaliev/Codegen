class String

  def upcase_first
    letters = self.split('')
  	letters.first.upcase!
  	letters.join
  end

  def lowercase_first
    letters = self.split('')
  	letters.first.downcase!
  	letters.join
     letters.join
  end

end