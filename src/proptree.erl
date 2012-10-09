%%%-------------------------------------------------------------------
%%% @author Dayneko Roman <me@h0.org.ua>
%%% @copyright (C) 2012, Dayneko Roman
%%% @doc
%%%
%%% @end
%%% Created :  1 Aug 2012 by Dayneko Roman <me@h0.org.ua>
%%%-------------------------------------------------------------------
-module(proptree).

%% API
-export([get_value/2, get_value/3, delete/2, modify/3, add/3]).

%%%===================================================================
%%% API
%%%===================================================================

get_value(Path, Tree) ->
    get_value(Path, Tree, undefined).
 
get_value(Path, [[{_, _} | _] | _] = ArrOfTree, Undefined) ->
    [get_value(Path, Tree, Undefined) || Tree <- ArrOfTree];
get_value([Key | Path], [{_, _} | _] = Tree, Undefined) ->
    case proplists:is_defined(Key, Tree) of
        true ->
            case Path of 
                [] ->
                    proplists:get_value(Key, Tree, Undefined);
                _ ->
                    get_value(Path, proplists:get_value(Key, Tree)) 
            end;
        _ ->
            Undefined
    end;
get_value(_Path, _Tree, Undefined) ->
    Undefined.

delete(Path, [[{_, _} | _] | _] = ArrOfTree) ->
    [delete(Path, Tree) || Tree <- ArrOfTree];
delete([Key | Path], [{_, _} | _] = Tree) ->
    case proplists:is_defined(Key, Tree) of
        true ->
            case Path of 
                [] ->
                    proplists:delete(Key, Tree);
                _ ->
                    [{Key, delete(Path, proplists:get_value(Key, Tree))} | proplists:delete(Key, Tree)] 
            end;
        _ ->
            Tree
    end;
delete(_Path, Tree) ->
    Tree.

modify(Path, Val, [[{_, _} | _] | _] = ArrOfTree) ->
    [modify(Path, Val, Tree) || Tree <- ArrOfTree];
modify([Key | Path], Val, [{_, _} | _] = Tree) ->
    case proplists:is_defined(Key, Tree) of
        true ->
            case Path of 
                [] ->
                    [{Key, Val} | proplists:delete(Key, Tree)];
                _ ->
                    [{Key, modify(Path, Val, proplists:get_value(Key, Tree))} | proplists:delete(Key, Tree)] 
            end;
        _ ->
            Tree
    end;
modify(_Path, _Val, Tree) ->
    Tree.

add(Path, Val, [[{_, _} | _] | _] = ArrOfTree) ->
    [add(Path, Val, Tree) || Tree <- ArrOfTree];
add([Key | Path], Val, Tree) ->
    case proplists:is_defined(Key, Tree) of
        false ->
            case Path of 
                [] ->
                    [{Key, Val} | Tree];
                _ ->
                    [{Key, add(Path, Val, [])} | Tree]
            end;
        _ ->
            [{Key, add(Path, Val, proplists:get_value(Key, Tree))} |  proplists:delete(Key, Tree)]
    end.
