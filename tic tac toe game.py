#PART 1: BUILD THE GAME BOARD

board = {7: ' ', 8: ' ', 9: ' ',
            4: ' ', 5: ' ', 6: ' ',
            1: ' ', 2: ' ', 3: ' '}

def printBoard(board):
    print(board[7] + '|' + board[8] + '|' + board[9])
    print('-+-+-')
    print(board[4] + '|' + board[5] + '|' + board[6])
    print('-+-+-')
    print(board[1] + '|' + board[2] + '|' + board[3])

printBoard(board)

#PART 2: ASK FOR PLAYER PREFERENCE

player1=input("Player 1, will you play x or o?: ")

if player1=="x":
    player2="o"
else:
    player2='x'

#PART 3: INITIATE WIN AND MOVE COUNTER
win=0
count=0
player_iter=True


while win != 1 and count<9:

#PART 4: CHOOSE WHICH PLAYER WILL MAKE A MOVE
    if player_iter==True:
        player=player1
    else:
        player=player2
    print(player + ", it's your turn!")

    pass_move=False

    while pass_move==False:
#PART 5: ASK PLAYERS THE LOCATION OF MOVE
        move = int(input("Input location of move: "))
        if board[move] != ' ':
            print('Error! Position is occupied!')
        else:
            board[move]=player
            pass_move=True

    count += 1
    printBoard(board)

#PART 6: CHECK IF SOMEONE WINS
    if board[1]==board[2] and board[1]==board[3]:
        if board[1] != ' ':
            win=1
    elif board[4]==board[5] and board[4]==board[6]:
        if board[4] != ' ':
            win=1
    elif board[7] == board[8] and board[7] == board[9]:
        if board[7] != ' ':
            win=1
    elif board[1]==board[4] and board[1]==board[7]:
        if board[1] != ' ':
            win=1
    elif board[2]==board[5] and board[2]==board[8]:
        if board[2] != ' ':
            win=1
    elif board[3]==board[6] and board[3]==board[9]:
        if board[3] != ' ':
            win=1
    elif board[1]==board[4] and board[1]==board[9]:
        if board[1] != ' ':
            win=1
    elif board[3]==board[5] and board[3]==board[7]:
        if board[3] != ' ':
            win=1

#PART 7: DISPLAY TOTAL WINS AND TOTAL MOVES
    player_iter=not(player_iter)
    print("Wins: " + str(win))
    print("Total move: "+ str(count))

#PART 8: DISPLAY WINNER/GAME OVER
if win==1:
    if player_iter==False:
        print(player1 + ", you win!")
    else:
        print(player2 + ", you won!")
else:
    print('Game over! All positions are filled!')