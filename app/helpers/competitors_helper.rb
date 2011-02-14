module CompetitorsHelper
  
  def field_asterisk(field)
    field[:required?] ? ' *' : ''
  end
end
