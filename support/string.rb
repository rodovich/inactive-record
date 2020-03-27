class String
  # "FooBar".underscore => "foo_bar"
  def underscore
    gsub(/(.)([A-Z])/, '\1_\2').downcase
  end

  # "foo_bar".camelize => "FooBar"
  def camelize
    split('_').map(&:capitalize).join
  end

  # "thing".pluralize => "things"
  def pluralize
    self + 's' # TODO: handle irregulars
  end

  # "things".singularize => "thing"
  def singularize
    self.gsub(/s$/, '') # TODO: handle irregulars
  end
end
