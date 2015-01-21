class Line

  attr_reader(:name, :direction, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @direction = attributes.fetch(:direction)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_lines = DB.exec("SELECT * FROM lines;")
    lines = []
    returned_lines.each() do |line|
      name = line.fetch("name")
      direction = line.fetch("direction")
      id = line.fetch("id").to_i()
      lines.push(Line.new({:name => name, :direction => direction, :id => id}))
    end
    lines
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO lines (name, direction) VALUES ('#{@name}', '#{@direction}')  RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end


   define_method(:==) do |another_line|
    self.name().==(another_line.name()).&(self.id().==(another_line.id()))
  end
end
