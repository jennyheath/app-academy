require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    through_options = self.assoc_options[through_name]
    source_options = through_options.model_class.assoc_options[source_name]

    define_method name do
      self_f_key = self.send(through_options.foreign_key)

      # debugger
      results = DBConnection.instance.execute(<<-SQL, self_f_key)
      SELECT
        source.*
      FROM
        #{through_options.table_name} AS through
      JOIN #{source_options.table_name} AS source
        ON through.#{source_options.foreign_key} = source.#{source_options.primary_key}
      WHERE
        through.#{through_options.primary_key} = ?
      SQL

      source_options.model_class.parse_all(results).first
    end
  end
end
