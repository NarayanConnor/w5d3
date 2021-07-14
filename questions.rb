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
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
        data.map { |datum| Question.new(datum)}
    end

    def find_by_id(num)
        quest=QuestionsDatabase.instance.execute("select * FROM questions Where id = ?",num)
        Question.new(quest)
    end

end

class User
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map { |datum| Users.new(datum)}
    end

    def find_by_name(str1,str2)
        name=QuestionsDatabase.instance.execute("select * FROM user Where fname = ? and lname = ?",str1,str2)
        User.new(name)
    end

end

class QuestionFollows
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM questions_follows")
        data.map { |datum| QuestionFollows.new(datum)}
    end

    def find_by_id(num)
        follows=QuestionsDatabase.instance.execute("select * FROM questions_follows Where id = ?",num)
        QuestionFollows.new(follows)
    end

end

class Replies
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
        data.map { |datum| QuestionFollows.new(datum)}
    end

    def find_by_id(num)
        replies=QuestionsDatabase.instance.execute("select * FROM questions_follows Where id = ?",num)
        QuestionFollows.new(replies)
    end

end

class QuestionLikes

end