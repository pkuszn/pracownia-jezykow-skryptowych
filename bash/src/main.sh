#!/bin/bash

declare -A matrix
rows=3
cols=3
game_over=false
filename="./data/file.txt"

function init() {
    for ((i=1;i<=rows;i++)) do
        for ((j=1;j<=cols;j++)) do
            matrix[$i,$j]="?"
        done
    done
}

function print() {
    f1="%$((${#rows}+1))s"
    f2="%9s"

    printf "$f1" ''
    for ((i=1;i<=rows;i++)) do
        printf "$f2" $i
    done
    echo

    for ((j=1;j<=cols;j++)) do
        printf "$f1" $j
        for ((i=1;i<=rows;i++)) do
            printf "$f2" ${matrix[$i,$j]}
            done
        echo
    done
}

function game() {
    readonly start_msg="Enter your choice: "
    readonly start_opt="Start"
    readonly next_turn_msg="Next turn"
    readonly save_to_file_msg="Save match to file"
    readonly load_opt="Load previous match"
    readonly exit_opt="Exit"
    readonly choice_msg="1) ${start_opt}\n2) ${load_opt}\n3) ${exit_opt}\n"
    readonly choince_inner_msg="1) ${next_turn_msg}\n2) ${save_to_file_msg}\n3) ${exit_opt}\n"
    readonly file_save_msg="File was saved to"

    printf "$choice_msg"
    read -r -p "${start_msg}" choice
    case $choice in
        "1")
            init
            while [ "$game_over" = false ]; do
                print_new_line
                printf "$choince_inner_msg"
                read -r -p "${start_msg}" choice_inner
                case $choice_inner in
                    "1")
                        user_turn
                        sleep 1
                        computer_turn
                    ;;
                    "2")
                        save_to_file "$filename"
                        echo "$file_save_msg $filename"
                        exit 0
                    ;;
                    "3")
                        exit 0
                    ;;
                esac
            done
            ;;
        "2")
            read_from_file "$filename"
            print_new_line
            echo "Loaded match from file $filename"
            print_new_line
            print
            while [ "$game_over" = false ]; do
                print_new_line
                printf "$choince_inner_msg"
                read -r -p "${start_msg}" choice_inner
                case $choice_inner in
                    "1")
                        user_turn
                        sleep 1
                        computer_turn
                    ;;
                    "2")
                        save_to_file "$filename"
                        echo "$file_save_msg $filename"
                        exit 0
                    ;;
                    "3")
                        exit 0
                    ;;
                esac
            done
            ;;
        "3")
            exit 0
            ;;
    esac
}

function user_turn() {
    user_turn_msg="Now is user turn..."
    chose_cell_msg="Select cell... ([1-3][1-3])"
    again_msg="Wrong cell. Select cell again... ([1-3][1-3])"
    row_msg="Row: "
    col_msg="Col: "
    local empty_field=false
    local empty_field_sign="?"

    check_empty_spaces

    print_new_line
    echo "$user_turn_msg"
    print_new_line
    echo "$chose_cell_msg"

    while [ "$empty_field" = false ]; do
        read -r -p "${col_msg}" col    
        read -r -p "${row_msg}" row
        if [ "${matrix[$col,$row]}" = "$empty_field_sign" ]; then
            matrix[$col,$row]="X"
            empty_field=true
        else
            echo "$again_msg"
            print_new_line
            print
        fi
    done

    print

    print_new_line
    check_for_winner "X"
}

function computer_turn() {
    computer_turn_msg="Now is computer turn..."
    declare -A arrays_of_index
    local empty_field_sign="?"
    local inc=0
    local debug=false

    for ((i=1; i <= cols; i++)); do
        for ((j=1; j <= rows; j++)); do
            if [ "${matrix[$i,$j]}" = "$empty_field_sign" ]; then
                indexes=("${i}, ${j}")
                arrays_of_index[$inc]=$indexes
                ((inc++))
            fi
        done
    done

    if [ "${#arrays_of_index[@]}" -eq 0 ]; then
        echo "Nobody won the match..."
        exit 0
    fi

    if [ "$debug" = true ]; then
        print_new_line
        for index in "${!arrays_of_index[@]}"; do
            echo "Index $index: ${arrays_of_index[$index]}"
        done
    fi

    print_new_line
    echo "$computer_turn_msg"
    print_new_line

    random_index=$((RANDOM % ${#arrays_of_index[@]}))

    if [ "$debug" = true ]; then
        echo "Computer selected index is <$random_index>"
    fi

    random_value="${arrays_of_index[$random_index]}"
    IFS=',' read -r c r <<< "$random_value"

    column=$((c+0))
    row=$((r+0))

    echo "Computer selected position is [$column][$row]"
    print_new_line

    matrix["$column","$row"]="O"

    print
    print_new_line
    check_for_winner "O"
}

function save_to_file() {
    truncate -s 0 "$filename" 
    for ((r = 1; r <= cols; r++)); do
        for ((c = 1; c <= rows; c++)); do
            echo -n "${matrix[$c,$r]} " >> "$filename"
        done
        echo >> "$filename"
    done
}

function read_from_file() {
    local r=1
    while IFS= read -r line; do
        line=$(echo "$line" | tr -d '[:space:]')
        c=1
        for ((i = 0; i < ${#line}; i++)); do
            char="${line:i:1}"
            matrix[$c,$r]="$char"
            ((c++))
        done
        ((r++))
    done < "$filename"
}

function check_for_winner() {
    local player=$1

    echo "Checking if $player won..."

    check_rows_or_columns "$player"
    check_diagonals "$player"
}

function check_rows_or_columns() {
    local player=$1

    for ((i = 1; i <= 3; i++)); do
        if [[ ${matrix[$i,1]} == "$player" && ${matrix[$i,2]} == "$player" && ${matrix[$i,3]} == "$player" ]] || \
           [[ ${matrix[1,$i]} == "$player" && ${matrix[2,$i]} == "$player" && ${matrix[3,$i]} == "$player" ]]; then
            echo "Player $player won!"
            print_new_line
            print
            exit 0
        fi
    done
}

function check_diagonals() {
    local player=$1

    if [[ ${matrix[1,1]} == "$player" && ${matrix[2,2]} == "$player" && ${matrix[3,3]} == "$player" ]] || \
       [[ ${matrix[1,3]} == "$player" && ${matrix[2,2]} == "$player" && ${matrix[3,1]} == "$player" ]]; then
        echo "Player $player won!"
        print_new_line
        print
        exit 0
    fi
}

function check_empty_spaces() {
    local inc=0

    for ((i=1; i <= cols; i++)); do
        for ((j=1; j <= rows; j++)); do
            if [ "${matrix[$i,$j]}" = "$empty_field_sign" ]; then
                ((inc++))
            fi
        done
    done

    if [ "$inc" -eq 0 ]; then
        print_new_line
        echo "Nobody won the match..."
        exit 0
    fi
}

function print_new_line() {
    printf "\n"
}

# Main function
game

