require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    cols = DBConnection.instance.execute2("SELECT * FROM #{table_name}")

    cols.first.map { |col| col.to_sym }
  end

  def self.finalize!
    columns.map do |col|
      define_method("#{col}=") do |val|
        attributes[col] = val
      end
    end

    columns.map do |col|
      define_method("#{col}") do
        attributes[col]
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.to_s.tableize
  end

  def self.all
    results = DBConnection.instance.execute("SELECT #{table_name}.* FROM #{table_name}")

    parse_all(results)
  end

  def self.parse_all(results)
    results.map do |attrs|
      self.new(attrs)
    end
  end

  def self.find(id)
    result = DBConnection.instance.execute("SELECT * FROM #{table_name} WHERE id = ?", id)

    parse_all(result).first
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      if self.class.columns.include?(attr_name.to_sym)
        send(:attributes)[attr_name.to_sym] = value
      else
        raise "unknown attribute '#{attr_name}'"
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |attr_name| self.send(:attributes)[attr_name] }
  end

  def insert
    attr_names = self.class.columns.join(", ")
    q_marks = (["?"] * self.class.columns.length).join(", ")

    DBConnection.instance.execute(<<-SQL, *attribute_values)
    INSERT INTO
      #{self.class.table_name} (#{attr_names})
    VALUES
      (#{q_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    to_update = self.class.columns.map { |attr_name| "#{attr_name} = ?"}
    update_str = to_update.join(", ")

    DBConnection.instance.execute(<<-SQL, *attribute_values, id)
    UPDATE
      #{self.class.table_name}
    SET
      #{update_str}
    WHERE
      id = ?
    SQL
  end

  def save
    id.nil? ? self.insert : self.update
  end
end
