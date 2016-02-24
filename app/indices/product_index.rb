ThinkingSphinx::Index.define :product, :with => :active_record do
  # fields
  indexes name, :sortable => true
  indexes description

  has subcategory_id

  set_property :enable_star => true
  set_property :min_infix_len => 1
  set_property :charset_type => 'utf-8'

end