class Game

    def initialize #Initialisation du plateau et des joueurs
        @nul = false
        @board = Board.new
        @player1 = Player.new("", "#{Rainbow("X").blue}")
        @player2 = Player.new("", "#{Rainbow("O").red}")
        @restart = false
    end

    def ask_name_player(player1, player2) #On demande à chaque joueur son nom
        puts "Player 1 :"
        print "> "
        player1.name = gets.chomp #Et on le modifie dans chaque instance de la classe joueur
        puts "Welcome #{Rainbow(player1.name).bright}. You play with #{Rainbow("X").blue.bright.underline}."

        puts "Player 2 :"
        print "> "
        player2.name = gets.chomp
        puts "Welcome #{Rainbow(player2.name).bright}. You play with #{Rainbow("O").red.bright.underline}."
    end

    def random_start
        if Random.new.rand(2) == 0
            @player1.turn = true #Tirage au sort du joueur qui commence.
            puts "#{Rainbow(@player1.name).bright} start !"
        else
            @player2.turn = true
            puts "#{Rainbow(@player2.name).bright} start !"
        end
    end

#La fonction qui suit gère la victoire.
#On lui donne un joueur, elle vérifie si il remplit les conditions de victoire du jeu.
# (3 cases sur une ligne, une colonne ou une diagonale)
#Pour ça, on test chaque possibilité de victoire indépendamment.

    def win?(player)
        if @board.tab_board[0].symbol == player.symbol && @board.tab_board[1].symbol == player.symbol && @board.tab_board[2].symbol == player.symbol
            player.won = true
        elsif @board.tab_board[3].symbol == player.symbol && @board.tab_board[4].symbol == player.symbol && @board.tab_board[5].symbol == player.symbol
            player.won = true
        elsif @board.tab_board[6].symbol == player.symbol && @board.tab_board[7].symbol == player.symbol && @board.tab_board[8].symbol == player.symbol
            player.won = true
        elsif @board.tab_board[0].symbol == player.symbol && @board.tab_board[3].symbol == player.symbol && @board.tab_board[6].symbol == player.symbol
            player.won = true
        elsif @board.tab_board[1].symbol == player.symbol && @board.tab_board[4].symbol == player.symbol && @board.tab_board[7].symbol == player.symbol
            player.won = true
        elsif @board.tab_board[2].symbol == player.symbol && @board.tab_board[5].symbol == player.symbol && @board.tab_board[8].symbol == player.symbol
            player.won = true
        elsif @board.tab_board[2].symbol == player.symbol && @board.tab_board[4].symbol == player.symbol && @board.tab_board[6].symbol == player.symbol
            player.won = true
        elsif @board.tab_board[0].symbol == player.symbol && @board.tab_board[4].symbol == player.symbol && @board.tab_board[8].symbol == player.symbol
            player.won = true
        else
            compter = 0
            @board.tab_board.each do |boardcase| #Cette boucle là permet de gérer les matchs nuls.
                if boardcase.symbol == " "
                    compter += 1
                end
            end
            if compter == 0 #Si plus de cases vides dans le tableau. C'est un match nul.
                @nul = true
            end
        end
    end

    def turn(player_turn_on, player_turn_off)
        puts "#{Rainbow(player_turn_on.name).bright} - Choose a number between 1 and 9 : "
        while true
            print "> " #La fonction tour, demande au joueur où il souhaite jouer.
            player_choice = gets.chomp
            if !/^[1-9]{1}$/.match(player_choice) #Gère les entrées autres que des chiffres entre 1 et 9.
                puts "Choose a real number, !"
            else
                player_choice = player_choice.to_i
                player_choice -= 1
                if @board.tab_board[player_choice].symbol != " " #Et les entrées de cases déjà prises.
                    puts "Choose an empty case :"
                else
                    break
                end
            end
        end #Quand le tour est terminé, le joueur passe à l'autre joueur.
        player_turn_on.turn = false
        player_turn_off.turn = true
        @board.tab_board[player_choice].symbol = player_turn_on.symbol
        win?(player_turn_on)
        system("clear") #Cette ligne permet d'avoir un affichage statique et non une console qui défile.
    end

    def restart_game #Avant de commencer une nouvelle partie,
        @player1.turn = false #On initialise les variables de tour,
        @player2.turn = false #Et de victoire sur false.
        @player1.won = false
        @player2.won = false
        @board.tab_board.each do |boardcase| #On vide toutes les cases du tableau.
            boardcase.symbol = " "
        end
    end

    def start_game #Au lancement d'une partie
        puts "Hello, do you want to play morpions ?"
        ask_name_player(@player1, @player2) 
        while true #tant que les joueurs veulent jouer
            if @restart == true
                restart_game #On initialise tout
            end
            random_start #On choisit un joueur au hasard
            print "To start, push Enter"
            gets.chomp
            system("clear") #clear la console
            while @player1.won != true && @player2.won != true && @nul != true #Tant qu'aucun joueur n'a gagné
                puts " #{Rainbow(@player1.name).blue} vs #{Rainbow(@player2.name).red}"
                @board.display_board # On affiche la board
                if @player1.turn == true
                    turn(@player1, @player2) #La méthode turn va demander aux joueurs ce qu'ils veulent jouer ...
                elsif @player2.turn == true
                    turn(@player2, @player1)
                end
            end
            puts " #{Rainbow(@player1.name).blue} vs #{Rainbow(@player2.name).red}"
            @board.display_board
            if @player1.won == true #conditions de victoire
                puts "You won #{Rainbow(@player1.name).bright} !" 
            elsif @player2.won == true
                puts "You won #{Rainbow(@player2.name).bright} !"
            elsif @nul == true
                puts "Draw !"
            end
            puts "Do you want to play again? (y / n)" 
            print "> "
            user_restart = gets.chomp.downcase
            if user_restart == "non" || user_restart == "n" || user_restart == "no"
                @restart = false
                break #On casse la boucle 
            else
                @restart = true
            end
        end
    end

end
