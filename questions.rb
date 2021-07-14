require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton
    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end

end

class Question

    attr_accessor :id, :title, :body, :author_id

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
        data.map { |datum| Question.new(datum)}
    end

    def initialize(options)
        @id= options['id']
        @title=options['title']
        @body=options['body']
        @author_id=options['author_id']
    end

    def find_by_id(num)
        quest=QuestionsDatabase.instance.execute("select * FROM questions Where id = ?",num)
        Question.new(quest)
    end

    def find_by_user(user_id)
        name=QuestionsDatabase.instance.execute("select * FROM questions Where author_id = ?",user_id)
        Question.new(name)
    end

    def author
        QuestionsDatabase.instance.execute("SELECT fname, lname FROM users where id = ?",self.author_id)
    end

    def replies
        Replies.find_by_id(self.id)
    end
end

class User

    attr_accessor :id, :fname, :lname

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map { |datum| Users.new(datum)}
    end

    def initialize(options)
        @id= options['id']
        @fname= options['fname']
        @lname= options['lname']
    end


    def find_by_name(str1,str2)
        name=QuestionsDatabase.instance.execute("select * FROM user Where fname = ? and lname = ?",str1,str2)
        User.new(name)
    end

    def authored_questions
        Question.find_by_owner(self.id)
    end


end

class QuestionFollows

    attr_accessor :id, :questions_follows, :user_q_follows

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM questions_follows")
        data.map { |datum| QuestionFollows.new(datum)}
    end

    def initialize(options)
        @id= options['id']
        @questions_follows = options['questions_follows']
        @user_q_follows = options['user_q_follows']
    end


    def find_by_id(num)
        follows=QuestionsDatabase.instance.execute("select * FROM questions_follows Where id = ?",num.)
        QuestionFollows.new(follows)
    end

end

class Replies

    attr_accessor :id, :body, :reply_Q, :reply_PAR, :reply_OWN

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
        data.map { |datum| QuestionFollows.new(datum)}
    end

    def initialize(options)
        @id= options['id']
        @body= options['body']
        @reply_Q = options['reply_Q']
        @reply_OWN = options['reply_OWN']
        @reply_PAR = options['reply_PAR']
    end



    def find_by_id(num)
        replies=QuestionsDatabase.instance.execute("select * FROM replies Where id = ?",num)
        QuestionFollows.new(replies)
    end

    def find_by_questioin(quest_id)
        replies=QuestionsDatabase.instance.execute("select * FROM replies Where reply_Q = ?",quest_id)
        QuestionFollows.new(replies)
    end

    def find_by_parent(quest_id)
        replies=QuestionsDatabase.instance.execute("select * FROM replies Where reply_PAR = ?",quest_id)
        QuestionFollows.new(replies)
    end

    def find_by_owner(quest_id)
        replies=QuestionsDatabase.instance.execute("select * FROM replies Where reply_OWN = ?",quest_id)
        QuestionFollows.new(replies)
    end


end

class QuestionLikes

    attr_accessor :id, :user_like, :user, :question

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
        data.map { |datum| QuestionFollows.new(datum)}
    end

    def initialize(options)
        @id= options['id']
        @user_like= options['user_like']
        @user = options['user']
        @question = options['question']
    end


    def find_by_id(num)
        likes=QuestionsDatabase.instance.execute("select * FROM question_likes Where id = ?",num)
        QuestionFollows.new(likes)
    end

    def find_by_questioin(quest_id)
        likes=QuestionsDatabase.instance.execute("select * FROM question_likes Where question = ?",quest_id)
        QuestionFollows.new(likes)
    end

    def find_by_user(user_id)
        likes=QuestionsDatabase.instance.execute("select * FROM question_likes Where user = ?",user_id)
        QuestionFollows.new(likes)
    end
end