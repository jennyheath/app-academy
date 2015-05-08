require_relative 'question_database'
require_relative 'question'

class Reply

  def self.find_by_id(id)
    params = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      id = ?
    SQL

    Reply.new(params.first)
  end

  def self.find_by_user_id(user_id)
    params = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      replies
    WHERE
      user_id = ?
    SQL

    params.map { |reply| Reply.new(reply) }
  end

  def self.find_by_question_id(question_id)
    params = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      replies
    WHERE
      question_id = ?
    SQL

    params.map { |reply| Reply.new(reply) }
  end

  attr_accessor :id, :question_id, :user_id, :parent_id, :body

  def initialize(options = {})
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
    @parent_id = options['parent_id']
    @body = options['body']
  end


  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    question.replies.select { |reply| reply.parent_id == @id }
  end
end

if __FILE__ == $PROGRAM_NAME
  # p Reply.find_by_id(1).child_replies
  # p Reply.find_by_user_id(2)
  # p Reply.find_by_question_id(2)
  # p Reply.find_by_question_id(1)
end
