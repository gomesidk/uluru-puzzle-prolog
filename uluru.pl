consecutive(X,Y,Board) :-
    append(Prefix,[X,Y|Suffix], Board).

next_to(X,X,_).
next_to(X,Y,[A,B,C,D,E,F]) :-
    consecutive(X,Y,[A,B,C,D,E,F]).
next_to(X,Y,[A,B,C,D,E,F]) :-
    consecutive(Y,X,[A,B,C,D,E,F]).

anywhere(X,Board) :-
    member(X,Board).

one_space(X,Y,Board) :-
    append(Prefix,[X,_,Y|Suffix], Board).
one_space(X,Y,Board) :-
    append(Prefix,[Y,_,X|Suffix], Board).

across(X,Y,Board) :-
    Board = [X,_,_,Y,_,_];
    Board = [X,_,_,_,Y,_];
    Board = [X,_,_,_,_,Y];
    Board = [_,X,_,Y,_,_];
    Board = [_,X,_,_,Y,_];
    Board = [_,X,_,_,_,Y].
across(X,Y,Board) :-
    Board = [Y,_,_,X,_,_];
    Board = [_,Y,_,_,X,_];
    Board = [Y,_,_,_,_,X];
    Board = [_,Y,_,X,_,_];
    Board = [_,Y,_,_,X,_];
    Board = [_,Y,_,_,_,X].

same_edge(X,Y,Board) :-
    Board = [X,_,_,_,_,Y];
    Board = [Y,_,_,_,_,X].
    Board = [_,X,_,_,Y,_];
    Board = [_,Y,_,_,X,_].
    Board = [_,_,X,_,_,Y];
    Board = [_,_,Y,_,_,X]. 
same_edge(X,Y,Board) :-
    Board = [_,_,_,X,_,Y];
    Board = [_,_,_,Y,_,X].
    Board = [_,_,_,_,X,Y];
    Board = [_,_,_,_,Y,X].      
same_edge(X,Y,Board) :-
    Board = [X,Y,_,_,_,_];
    Board = [Y,X,_,_,_,_].
    Board = [_,X,Y,_,_,_];
    Board = [_,Y,X,_,_,_].
    Board = [_,_,X,Y,_,_];      
    Board = [_,_,Y,X,_,_].
same_edge(X,Y,Board) :-
    Board = [_,_,_,X,Y,_];
    Board = [_,_,_,Y,X,_].            
    Board = [_,_,_,_,X,Y];
    Board = [_,_,_,_,Y,X].
same_edge(X,Y,Board) :-
    Board = [_,_,_,_,_,X,Y];
    Board = [_,_,_,_,_,Y,X].

position(X, L, Board) :-
    nth1(L, Board, X). 
position(X, L1, Y, L2, Board) :-
    nth1(L1, Board, X),
    nth1(L2, Board, Y).
position(X, L1, Y, L2, Z, L3, Board) :-
    nth1(L1, Board, X),
    nth1(L2, Board, Y),
    nth1(L3, Board, Z). 
position(X, L1, Y, L2, Z, L3, W, L4, Board) :-
    nth1(L1, Board, X),
    nth1(L2, Board, Y),
    nth1(L3, Board, Z),
    nth1(L4, Board, W).
position(X, L1, Y, L2, Z, L3, W, L4, V, L5, Board) :-
    nth1(L1, Board, X),
    nth1(L2, Board, Y),
    nth1(L3, Board, Z),
    nth1(L4, Board, W),
    nth1(L5, Board, V).
position(X, L1, Y, L2, Z, L3, W, L4, V, L5, U, L6, Board) :-
    nth1(L1, Board, X),
    nth1(L2, Board, Y),
    nth1(L3, Board, Z),
    nth1(L4, Board, W),
    nth1(L5, Board, V),
    nth1(L6, Board, U).

solve(Constraints, Board) :-
    Board = [_,_,_,_,_,_],
    permutation([a,b,c,d,e,f], Board),
    maplist({Board}/[Constraint]>>call(Constraint, Board), Constraints).



