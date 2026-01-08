:- use_module(library(lists)).

consecutive(X,Y,Board) :-
    append(_Prefix,[X,Y|_Suffix], Board).

next_to(X,X,_).
next_to(X,Y,[A,B,C,D,E,F]) :-
    consecutive(X,Y,[A,B,C,D,E,F]).
next_to(X,Y,[A,B,C,D,E,F]) :-
    consecutive(Y,X,[A,B,C,D,E,F]).

anywhere(X,Board) :-
    member(X,Board).

one_space(X,X,_).
one_space(X,Y,Board) :-
    append(_Prefix,[X,_,Y|_Suffix], Board).
one_space(X,Y,Board) :-
    append(_Prefix,[Y,_,X|_Suffix], Board).

across(X,X,_).
across(X,Y,Board) :-
    Board = [X,_,_,Y,_,_];
    Board = [X,_,_,_,Y,_];
    Board = [X,_,_,_,_,Y];
    Board = [_,X,_,Y,_,_];
    Board = [_,X,_,_,Y,_];
    Board = [_,X,_,_,_,Y];
    Board = [Y,_,_,X,_,_];
    Board = [Y,_,_,_,X,_];
    Board = [Y,_,_,_,_,X];
    Board = [_,Y,_,X,_,_];
    Board = [_,Y,_,_,X,_];
    Board = [_,Y,_,_,_,X].

same_edge(X,X,_).
same_edge(X,Y,Board) :-
    Board = [X, Y, _, _, _, _];
    Board = [_, _, _, X, Y, _];
    Board = [_, _, _, _, X, Y];
    Board = [_, _, _, X, _, Y].
same_edge(X,Y,Board) :-
    Board = [Y, X, _, _, _, _];
    Board = [_, _, _, Y, X, _];
    Board = [_, _, _, _, Y, X];
    Board = [_, _, _, Y, _, X].

position(X, L, Board) :-
    member(Pos, L),
    nth1(Pos, Board, X). 


solve(Constraints, Board) :-
    Board = [_,_,_,_,_,_],
    permutation([green, yellow, blue, orange, white, black], Board),
    check_constraints(Constraints, Board).

check_constraints([], _).
check_constraints([Constraint|Rest], Board) :-
    call(Constraint, Board),
    check_constraints(Rest, Board).

best_score(Constraints, Score) :-
    findall(S, (
        permutation([green, yellow, blue, orange, white, black], Board),
        count_satisfied(Constraints, Board, S)
    ), Scores),
    max_list(Scores, Score).

count_satisfied(Constraints, Board, Score) :-
    length(Constraints, Total),
    count_satisfied_aux(Constraints, Board, 0, Satisfied),
    Score is Satisfied - Total.

count_satisfied_aux([], _, Acc, Acc).
count_satisfied_aux([Constraint|Rest], Board, Acc, Result) :-
    (call(Constraint, Board) ->
        NewAcc is Acc + 1
    ;
        NewAcc = Acc
    ),
    count_satisfied_aux(Rest, Board, NewAcc, Result).


%% 12 solutions
example(1, [ next_to(white,orange),
    next_to(black,black),
    across(yellow,orange),
    next_to(green,yellow),
    position(blue,[1,2,6]),
    across(yellow,blue) ]).

%% 1 solution
example(2, [ across(white,yellow),
    position(black,[1,4]),
    position(yellow,[1,5]),
    next_to(green, blue),
    same_edge(blue,yellow),
    one_space(orange,black) ]).

%% no solutions (5 constraints are satisfiable)
example(3, [ across(white,yellow),
    position(black,[1,4]),
    position(yellow,[1,5]),
    same_edge(green, black),
    same_edge(blue,yellow),
    one_space(orange,black) ]).

%% same as above, different order of constraints
example(4, [ position(yellow,[1,5]),
    one_space(orange,black),
    same_edge(green, black),
    same_edge(blue,yellow),
    position(black,[1,4]),
    across(white,yellow) ]).



