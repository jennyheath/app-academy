#!/usr/bin/env ruby

def maze_solver
  file_name = ARGV[0]
  maze = []
  current = [0,0]
  file = File.open(file_name).read
  file.each_line do |line|
    row = line.chomp.chars
    maze << row
  end


  maze.each_with_index do | y, index_y |
    y.each_with_index do | x, index_x |
      if x == "S"
        current = [index_x, index_y]
      end
    end
  end
  y = current[0]
  x = current[1]


  while maze[x][y] != "E"
    if maze[x - 1][y] == " "
      maze[x - 1][y] = "X"
      x -= 1
    elsif maze[x][y + 1] == " "
      maze[x][y + 1] = "X"
      y += 1
    elsif maze[x + 1][y] == " "
      maze[x + 1][y] = "X"
      x += 1
    elsif maze[x][y - 1] == " "
      maze[x][y - 1] = "X"
      y -= 1
    else
      break
    end
  end

    if [maze[x - 1][y], maze[x][y + 1], maze[x + 1][y], maze[x][y - 1]].include?("E")
      p maze
      p "you won!"
    else
      p "you're stuck"
    end
end

maze_solver
