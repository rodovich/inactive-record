class String
  # "FooBar".underscore => "foo_bar"
  def underscore
    gsub(/(.)([A-Z])/, '\1_\2').downcase
  end

  # "thing".pluralize => 'things'
  def pluralize
    self + 's' # TODO: handle irregulars
  end
end
