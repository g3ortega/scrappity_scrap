class String

  def remove_punctuation
    gsub(/[^[[:word:]]\s]/, '')
  end
end