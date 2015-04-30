def super_print(str, params={})
  defaults = { times: 1,
               upcase: false,
               reverse: false }
  if params.empty?
    puts str
  else
    updated_hash = defaults.merge(params)

    str.upcase! if updated_hash[:upcase]
    str.reverse! if updated_hash[:reverse]
    updated_hash[:times].times{ puts str}
  end
end

super_print("Hello")                                    #=> "Hello"
super_print("Hello", :times => 3)                       #=> "Hello" 3x
super_print("Hello", :upcase => true)                   #=> "HELLO"
super_print("Hello", :upcase => true, :reverse => true) #=> "OLLEH"
