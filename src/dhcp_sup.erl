
-module(dhcp_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->

    Server = {dhcp_server,{dhcp_server, start_link,[]},
            permanent,2000,worker,[dhcp_server]},

    Spy = {dhcp_spy, {dhcp_spy, start_link, []},
            permanent,2000,worker,[dhcp_spy]},

    {ok,{{one_for_one,5,3600}, [Server, Spy]}}.

