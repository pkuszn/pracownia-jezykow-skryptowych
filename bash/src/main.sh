#!/bin/bash

declare -A matrix
rows=3
cols=3

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
    readonly start_msg="Enter your choice..."
    readonly start_opt="Start"
    readonly load_opt="Load previous match"
    readonly exit_opt="Exit"
    readonly choice_msg="1) ${start_opt}\n2) ${load_opt}\n3) ${exit_opt}\n"

    printf "${choice_msg}"
    read -p "${start_msg}" choice
    case $choice in
        "1")
            echo "you chose $start_opt"
            init
            next_turn
            print
            ;;
        "2")
            echo "you chose $load_opt"
            ;;
        "3")
            echo "you chose $exit_opt"
            ;;
    esac
}

function next_turn() {
    readonly next_turn_msg="Next turn..."
    print
    readonly chose_cell_msg="Chose cell.. ([1-3][1-3])"
    readonly row_msg="Row..."
    readonly col_msg="Col..."
    
    read -p "${row_msg}" row
    read -p "${col_msg}" col

    matrix[$row,$col]="X"

    computer_turn
}

function computer_turn() {
    readonly computer_turn_msg="Now is computer turn..."
    declare -A arrays_of_index
    local target="?"
    local inc=0
    for ((i=1; i<=$rows; i++)); do
        for ((j=1; j<=$cols; j++)); do
            if [ "${matrix[$i,$j]}" = "$target" ]; then
                indexes=("${i}, ${j}")
                arrays_of_index[$inc]=$indexes
                ((inc++))
            fi
        done
    done

    if [ "${#arrays_of_index[@]}" -eq 0 ]; then
        return
    fi

    for index in "${!arrays_of_index[@]}"; do
        echo "Index $index: ${arrays_of_index[$index]}"
    done

    printf "$computer_turn_msg"
    random_index=$((RANDOM % ${#arrays_of_index[@]}))
    random_value="${arrays_of_index[$random_index]}"
    IFS=',' read -r r c <<< "$random_value"

    row=$((r+0))
    column=$((c+0))

    matrix["$row","$column"]="O"
    printf "\n"
}

function check_if_done() {
    for ((i=1; i<=$rows; i++)); do
        for ((j=1; j<=$cols; j++)); do
            if [ "${matrix[$i,$j]}" = "$target" ]; then
                return 
            fi
        done
    done
}

game
