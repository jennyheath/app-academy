require_relative 'question_database'
require_relative 'user'
require_relative 'question'

class QuestionFollow
  def self.followers_for_question_id(question_id)
    params = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      u.id, u.fname, u.lname -- users.*
    FROM
      question_follows
    INNER JOIN
      users u ON u.id = question_follows.user_id
    WHERE
      question_follows.question_id = ?
    SQL

    params.map { |user| User.new(user) }
  end

  def self.followed_questions_for_user_id(user_id)
    params = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      questions.id, questions.title, questions.body, questions.author_id
      -- questions.*
    FROM
      question_follows
    INNER JOIN
      questions ON questions.id = question_follows.question_id
    WHERE
      question_follows.user_id = ?
    SQL

    params.map { |question| Question.new(question) }
  end

  def self.most_followed_questions(n)
    params = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT
      questions.id, questions.title, questions.body, questions.author_id
    FROM
      question_follows
    INNER JOIN
      questions ON questions.id = question_follows.question_id
    GROUP BY
      questions.id
    ORDER BY
      COUNT(questions.id) DESC
    -- LIMIT
    -- :limit
    SQL

    all_question_counts = params.map { |count| Question.new(count) }
    all_question_counts.shift(n)
  end

  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end


if __FILE__ == $PROGRAM_NAME
  # p QuestionFollow.followed_questions_for_user_id(2)
  # p QuestionFollow.most_followed_questions(2)
end
