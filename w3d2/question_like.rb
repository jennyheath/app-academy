require_relative 'question_database'
require_relative 'user'
require_relative 'question'

class QuestionLike
  def self.likers_for_question_id(question_id)
    params = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.id, users.fname, users.lname
    FROM
      question_likes
    INNER JOIN
      users ON users.id = question_likes.user_id
    WHERE
      question_likes.question_id = ?
    SQL

    params.map { |user| User.new(user) }
  end

  def self.num_likes_question_id(question_id)
    num = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      COUNT(*)
    FROM
      question_likes
    INNER JOIN
      questions ON questions.id = question_likes.question_id
    WHERE
      questions.id = ?
    SQL

    num.first.values.first
  end

  def self.liked_questions_for_user_id(user_id)
    params = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      questions.id, questions.title, questions.body, questions.author_id
    FROM
      question_likes
    INNER JOIN
      questions ON questions.id = question_likes.question_id
    WHERE
      question_likes.user_id = ?
    SQL

    params.map { |question| Question.new(question) }
  end

  def self.most_liked_questions(n)
    params = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT
      questions.id, questions.title, questions.body, questions.author_id
    FROM
      question_likes
    INNER JOIN
      questions ON questions.id = question_likes.question_id
    GROUP BY
      question_id
    ORDER BY
      COUNT(*) DESC
    SQL

    most_liked = params.map { |question| Question.new(question) }
    most_liked.shift(n)
  end

  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end


if __FILE__ == $PROGRAM_NAME
  # p QuestionLike.most_liked_questions(2)
  # p QuestionLike.liked_questions_for_user_id(2)
end
