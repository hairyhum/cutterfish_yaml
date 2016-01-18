-module(yaml_parser).

-export([file/1]).

file(FileName) ->
    application:start(yamerl),
    lager:error("FileName ~p", [FileName]),
    try yamerl:decode_file(FileName) of
        [Doc | _] -> to_cuttlefish_conf(Doc)
    catch Type:Reason ->
        {error, Reason}
    end.

to_cuttlefish_conf(Doc) ->
    lists:map(
        fun({K, V}) -> {string:tokens(K, "."), V};
           (Other)  -> Other
        end,
        Doc).