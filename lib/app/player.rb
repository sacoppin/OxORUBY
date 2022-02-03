    #TO DO : la classe a 2 attr_reader, son nom et sa valeur (X ou O).
    class Player

        attr_reader :name # indique le nom du joueur (String)
        attr_reader :symbol # indique la valeur du joueur (String : "X" ou "O")
      
        def initialize(nom, symbol)
          @name = nom
          @symbol = symbol
        end
      end

      