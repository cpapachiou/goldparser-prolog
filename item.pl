:- module(item, [
                 property/6,
                 entry_value/3,
                 entry_value/6,
                 value/3,
                 entries/2,
                 entries/3,
                 entries_to_list/2,
                 entry_member/2,
                 entries_nd/2,
                 entries_size/2
                ]).

property(character_set_table, index,          0, short, item(V, _, _, _E), V).
property(character_set_table, unicode_plane,  1, short, item(_, V, _, _E), V).
property(character_set_table, range_count,    2, short, item(_, _, V, _E), V).

property(dfa_table, index,        0, short,   item(V, _, _, _E), V).
property(dfa_table, accept_state, 1, boolean, item(_, V, _, _E), V).
property(dfa_table, accept_index, 2, short,   item(_, _, V, _E), V).

property(group_table, index,           0, short,  item(V, _, _, _, _, _, _, _E), V).
property(group_table, name,            1, string, item(_, V, _, _, _, _, _, _E), V).
property(group_table, container_index, 2, short,  item(_, _, V, _, _, _, _, _E), V).
property(group_table, start_index,     3, short,  item(_, _, _, V, _, _, _, _E), V).
property(group_table, end_index,       4, short,  item(_, _, _, _, V, _, _, _E), V).
property(group_table, advance_mode,    5, short,  item(_, _, _, _, _, V, _, _E), V).
property(group_table, ending_mode,     6, short,  item(_, _, _, _, _, _, V, _E), V).

property(initial_states, dfa,  0, short, item(V, _), V).
property(initial_states, lalr, 1, short, item(_, V), V).

property(lalr_table, index, 0, short, item(V, _E), V).

property(property, index, 0, short,  item(V, _, _), V).
property(property, name,  1, string, item(_, V, _), V).
property(property, value, 2, string, item(_, _, V), V).

property(rule_table, index,      0, short, item(V, _, _E), V).
property(rule_table, head_index, 1, short, item(_, V, _E), V).

property(symbol_table, index, 0, short,  item(V, _, _), V).
property(symbol_table, name,  1, string, item(_, V, _), V).
property(symbol_table, kind,  2, short,  item(_, _, V), V).

property(table_counts, symbol_table,        0, short, item(V, _, _, _, _, _), V).
property(table_counts, character_set_table, 1, short, item(_, V, _, _, _, _), V).
property(table_counts, rule_table,          2, short, item(_, _, V, _, _, _), V).
property(table_counts, dfa_table,           3, short, item(_, _, _, V, _, _), V).
property(table_counts, lalr_table,          4, short, item(_, _, _, _, V, _), V).
property(table_counts, group_table,         5, short, item(_, _, _, _, _, V), V).

entries(rule_table,  item(_, _, E), E).
entries(lalr_table,  item(_, E), E).
entries(dfa_table,   item(_, _, _, E), E).
entries(character_set_table, item(_, _, _, E), E).
entries(group_table, item(_, _, _, _, _, _, _, E), E).

entry_value(rule_table, symbol_index, 0, short, entry(V), V).

entry_value(lalr_table, symbol_index, 0, short, entry(V, _, _), V).
entry_value(lalr_table, action,       1, short, entry(_, V, _), V).
entry_value(lalr_table, target,       2, short, entry(_, _, V), V).

entry_value(dfa_table, character_set_index, 0, short, entry(V, _), V).
entry_value(dfa_table, target_index,        1, short, entry(_, V), V).

entry_value(character_set_table, start_character, 0, short, entry(V, _), V).
entry_value(character_set_table, end_character,   1, short, entry(_, V), V).

entry_value(group_table, group_index, 0, short, entry(V), V).

%%	value(+Name:atom, +Item:term, -Value) is det.
value(Name, Item, Value) :-
    property(_, Name, _, _, Item, Value), !.

value(Name, Item, Value) :-
    var(Value),
    !,
    domain_error(Item, Name).

%%	entry_value(+Name:atom, +Entry:term, -Value) is det.
entry_value(Name, Entry, Value) :-
    entry_value(_, Name, _, _, Entry, Value), !.

entry_value(Name, Entry, Value) :-
    var(Value),
    !,
    domain_error(Entry, Name).

entries(Item, Entries) :-
    functor(Item, _, Size),
    arg(Size, Item, Entries).


%%	entries_to_list(+EntryTerm:term, ?Entries:list) is det.
% converts the term entry to a list of entries (using univ).
% succeeds if entries is already a list.
entries_to_list(Entries, Entries) :-
    is_list(Entries), !.
entries_to_list(EntryTerm, Entries) :-
    EntryTerm =.. [entries | Entries].

entry_member(Entries, Entry) :-
    entries_to_list(Entries, EntryList),
    member(Entry, EntryList).

entries_nd(Item, Entry) :-
    entries(Item, Entries),
    entry_member(Entries, Entry).

entries_size(Entries, Size) :-
    functor(Entries, entries, Size), !.

entries_size(Entries, Size) :-
    length(Entries, Size), !.








