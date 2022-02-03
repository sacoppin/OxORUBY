#La classe BoardCase représente une case de notre morpion.
#On a besoin seulement qu'elle ait un id et de savoir ce qu'il y a dedans.
class BoardCase

    attr_accessor :symbol
    attr_reader :id

    def initialize(id, symbol = " ")
        @symbol = symbol
        @id = id
    end

end
