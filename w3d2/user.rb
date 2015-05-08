require_relative 'question_database'
require_relative 'question'
require_relative 'question_follow'
require_relative 'question_like'
require_relative 'save'

class User
  attr_accessor :id, :fname, :lname

  def initialize(options = {})
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_id(id)
    params = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
    SQL

    User.new(params.first)
  end

  def self.find_by_name(fname, lname)
    params = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE
      fname = ? AND lname = ?
    SQL

    User.new(params.first)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    id = @id
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      COUNT(DISTINCT(q.id)), CAST(COUNT(ql.question_id) AS FLOAT)
    FROM
      questions q
    LEFT OUTER JOIN
      question_likes ql ON q.id = ql.question_id
    WHERE
      q.author_id = ?
    SQL

    questions = result.first.values.first
    likes = result.first.values.last

    likes / questions
  end

  def save
    id, fname, lname = @id, @fname, @lname
    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        INSERT INTO users (fname, lname) VALUES (?, ?)
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, id, fname, lname)
        UPDATE users SET id = ?, fname = ?, lname = ?
      SQL
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  # bob = User.new({ 'fname' => 'Bob', 'lname' => 'Bobson' })
  # bob.save
  # p QuestionsDatabase.instance.execute('SELECT * FROM users')
  # kelsey = User.new({ 'id' => 1, 'fname' => 'Kelsey', 'lname' => 'Grammer' })
  # kelsey.save
  # p QuestionsDatabase.instance.execute('SELECT * FROM users')
  # p User.find_by_id(2).liked_questions
  # p User.find_by_name('Eric', 'Ashmore')
  # p User.find_by_id(2).average_karma
  # p User.find_by_id(1)
end
