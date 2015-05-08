def save
  ivar_keys = self.instance_variables.map { |key| key.to_s[1..-1].to_sym }
  ivar_vals = ivar_keys.map { |key| self.send(key) }
  db_name = self.class.to_s.downcase + 's'

  if self.id.nil?
    ivar_keys = ivar_keys[1..-1].join(", ")
    ivar_vals = "'" + ivar_vals.compact.join("', '") + "'"

    QuestionsDatabase.instance.execute(<<-SQL, db_name, ivar_keys, ivar_vals)
      INSERT INTO ? (?) VALUES (?)
    SQL

    self.id = QuestionsDatabase.instance.last_insert_row_id
  else
    ivars = ivar_keys.zip(ivar_vals).map {|pair| pair.join(' = ') }
    ivars = ivars.join(', ')
    
    QuestionsDatabase.instance.execute(<<-SQL, db_name, ivars)
      UPDATE ? SET ?
    SQL
  end
end
