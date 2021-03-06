:- module(group, [
                  advance_mode/2,
                  ending_mode/2,
                  by_symbol/4,
                  nestable/2,
                  append_chars/3
                 ]).

:- use_module(table,  []).
:- use_module(item,   []).

advance_mode(0, token).
advance_mode(1, character).

ending_mode(0, open).
ending_mode(1, closed).

by_symbol(Tables, Kind-SymbolIndex, GroupIndex, Group) :-
    table:items(group_table, Tables, GroupIndex, Group),
    (   item:value(Kind, Group, SymbolIndex)
    ->  !
    ;   true
    ).

nestable(Group, NestableIndex) :-
    item:entries_nd(Group, Nested),
    item:entry_value(group_index, Nested, NestableIndex).

append_chars(Groups0, Appendee, GroupsN) :-
    Groups0 = [group(Group, ContainerToken0, AM, EM, EC) | Groups1],
    symbol:append(ContainerToken0, Appendee, ContainerToken1),
    GroupsN = [group(Group, ContainerToken1, AM, EM, EC) | Groups1 ].
