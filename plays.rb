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

    

end

class Users

end

class QuestionFollows

end

class Replies

end

class QuestionLikes

end