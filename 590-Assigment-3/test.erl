-module(test).
-export([main_loop/0, factorial/1]).

main_loop() ->
    process_number(),
    main_loop().

process_number() ->
    io:format("Enter a number: "),
    Input = io:get_line(""),
    
    case parse_integer(string:trim(Input)) of
        {ok, N} ->
            handle_integer(N);
        error ->
            io:format("Not an integer.~n"),
            ok 
    end.

parse_integer(String) ->
    try 
        {Int, Rest} = string:to_integer(String),
        case Rest of
            "" -> {ok, Int};
            _  -> error
        end
    catch
        _:_ -> 
            error
    end.

handle_integer(N) when N < 0 ->
    Result = math:pow(abs(N), 7),
    io:format("~w raised to the 7th power is: ~w~n", [abs(N), Result]);
handle_integer(0) ->
    io:format("You entered 0. Ending program.~n"),
    halt();
handle_integer(N) when N > 0 ->
    if 
        N rem 7 == 0 -> 
            Root5 = math:pow(N, 1/5),
            io:format("The 5th root of ~w is: ~.2f~n", [N, Root5]);
        true ->
            Fact = factorial(N),
            io:format("The factorial of ~w is: ~w~n", [N, Fact])
    end.

factorial(0) -> 1;
factorial(N) when N > 0 -> N * factorial(N - 1).