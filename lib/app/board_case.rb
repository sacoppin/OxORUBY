class BoardCase
    attr_accessor :position, :sign
    def initialize (position)
        @sign = " "
        @postion = position
    end

    def array 
    self.sign = @sign
    end

    def update (position, sign)
    self.sign = sign
    self.position = position
    end
end

class BoardCase
    #TO DO : la classe a 2 attr_accessor, sa valeur en string (X, O, ou vide), ainsi que son identifiant de case
    def initialize
      #TO DO : doit régler sa valeur, ainsi que son numéro de case
    end
end