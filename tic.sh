#!/bin/bash

# Initialize the board as an array with empty values
board=("1" "2" "3" "4" "5" "6" "7" "8" "9")
player="X"

# Function to print the board
print_board() {
    echo ""
    echo " ${board[0]} | ${board[1]} | ${board[2]}"
    echo "---|---|---"
    echo " ${board[3]} | ${board[4]} | ${board[5]}"
    echo "---|---|---"
    echo " ${board[6]} | ${board[7]} | ${board[8]}"
    echo ""
}

# Function to check if the current player has won
check_winner() {
    for i in 0 3 6; do
        if [[ "${board[$i]}" == "$player" && "${board[$i+1]}" == "$player" && "${board[$i+2]}" == "$player" ]]; then
            return 0
        fi
    done
    for i in 0 1 2; do
        if [[ "${board[$i]}" == "$player" && "${board[$i+3]}" == "$player" && "${board[$i+6]}" == "$player" ]]; then
            return 0
        fi
    done
    if [[ "${board[0]}" == "$player" && "${board[4]}" == "$player" && "${board[8]}" == "$player" ]]; then
        return 0
    fi
    if [[ "${board[2]}" == "$player" && "${board[4]}" == "$player" && "${board[6]}" == "$player" ]]; then
        return 0
    fi
    return 1
}

# Function to check if the board is full (draw)
check_draw() {
    for i in "${board[@]}"; do
        if [[ "$i" != "X" && "$i" != "O" ]]; then
            return 1
        fi
    done
    return 0
}

# Main game loop
while true; do
    clear
    print_board
    echo "Player $player's turn. Enter a position (1-9): "
    read -r position

    # Validate the input
    if ! [[ "$position" =~ ^[1-9]$ ]]; then
        echo "Invalid input! Please enter a number between 1 and 9."
        continue
    fi
    if [[ "${board[position-1]}" == "X" || "${board[position-1]}" == "O" ]]; then
        echo "Position already taken! Choose another."
        continue
    fi

    # Place the player's move on the board
    board[position-1]=$player

    # Check for a win or draw
    if check_winner; then
        clear
        print_board
        echo "Player $player wins!"
        break
    elif check_draw; then
        clear
        print_board
        echo "It's a draw!"
        break
    fi

    # Switch players
    if [[ "$player" == "X" ]]; then
        player="O"
    else
        player="X"
    fi
done
