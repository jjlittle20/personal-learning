def createNewBoard
  return Array.new(3) {
           Array.new(3, ".")
         }
end

$currentBoard = createNewBoard()
$currentPlayer
$secondRowOffset = 3
$thirdRowOffset = 6
$player1
$player2

class Player
  def initialize(id, name, symbol)
    @player_id = id
    @player_name = name
    @player_symbol = symbol
  end

  def name
    @player_name
  end

  def id
    @player_id
  end

  def symbol
    @player_symbol
  end
end

def gameOver
  puts `clear`
  puts ""
  puts "Well done #{$currentPlayer.name}! You are the winner!"
  puts ""
  drawBoard($currentBoard)
  puts ""
  puts "Would you like to play again? y/n"
end

def drawBoard(board)
  puts ""
  for value in board
    puts "#{value[0]} #{value[1]} #{value[2]}"
  end
  puts ""
end

def clearBoard
  $currentBoard = createNewBoard()
end

def drawAvailibleMoves
  for rowIndex in 0..$currentBoard.length
    rowAvailibleMoves = []
    if ($currentBoard[rowIndex] != nil)
      for cellIndex in 0..$currentBoard[rowIndex].length
        if ($currentBoard[rowIndex][cellIndex] == ".")
          cellNumber = cellIndex + 1
          if (rowIndex == 1)
            cellNumber = cellNumber + $secondRowOffset
          end
          if (rowIndex == 2)
            cellNumber = cellNumber + $thirdRowOffset
          end
          rowAvailibleMoves.push(cellNumber)
        else rowAvailibleMoves.push("-")         end
      end
    end
    puts "#{rowAvailibleMoves[0]} #{rowAvailibleMoves[1]} #{rowAvailibleMoves[2]}"
  end
end

def updateBoard(cellNumber)
  rowIndex = 0
  offset = 0

  if (cellNumber > 3 and cellNumber < 7)
    rowIndex = 1
    offset = $secondRowOffset
  end
  if (cellNumber > 6 and cellNumber < 10)
    rowIndex = 2
    offset = $thirdRowOffset
  end
  cell = (cellNumber - 1) - offset
  if ($currentBoard[rowIndex][cell] == $player1.symbol or $currentBoard[rowIndex][cell] == $player2.symbol)
    gameLoop("Invalid Move - try a different squaer")
  else
    $currentBoard[rowIndex][cell] = $currentPlayer.symbol
    isWinner = isWinner()
    if (isWinner)
      gameOver()
    else
      switchPlayer()
      gameLoop("")
    end
  end
end

def clearTerminal
  puts `clear`
  puts "Welcome to my Ruby Noughts & Crosses game!"
  puts "created by: James Little 21/11/22"
end

def isWinner()
  symbol = $currentPlayer.symbol
  winningCords = [[[0, 0], [0, 1], [0, 2]], [[0, 1], [1, 1], [2, 1]], [[0, 2], [1, 2], [2, 2]], [[0, 0], [1, 0], [2, 0]], [[1, 0], [1, 1], [1, 2]], [[2, 0], [2, 1], [2, 2]], [[0, 0], [1, 1], [2, 2]], [[0, 2], [1, 1], [2, 0]]]
  isWin = false
  for combo in winningCords
    count = 0
    if ($currentBoard[combo[0][0]][combo[0][1]] == symbol and $currentBoard[combo[1][0]][combo[1][1]] == symbol && $currentBoard[combo[2][0]][combo[2][1]] == symbol)
      isWin = true
      break
    end
  end

  return isWin
end

def switchPlayer
  if ($currentPlayer.id == 1)
    $currentPlayer = $player2
  else
    $currentPlayer = $player1
  end
end

def gameLoop(message)
  clearTerminal()
  puts message
  drawBoard($currentBoard)

  puts "Player #{$currentPlayer.name}"
  puts ""
  puts "Select your turn from the numbers below: "
  puts ""
  drawAvailibleMoves()
  cell = gets.chomp

  if (cell.to_i > 9 || cell.to_i < 1)
    gameLoop("This is not a valid move")
  else
    updateBoard(cell.to_i)
  end
end

def playerSetup(playerToSetup)
  puts "Player #{playerToSetup} what is your name?"
  playerName = gets.chomp
  puts "#{playerName} what is your symbol? - single character only"
  playerSymbol = gets.chomp

  if (playerToSetup == 1)
    $player1 = Player.new(1, playerName, playerSymbol)
    $currentPlayer = $player1
    playerSetup(2)
  else
    $player2 = Player.new(2, playerName, playerSymbol)
    gameLoop("")
  end
end

playerSetup(1)
