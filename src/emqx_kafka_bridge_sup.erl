%% Copyright (c) 2018 EMQ Technologies Co., Ltd. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(emqx_kafka_bridge_sup).

-behaviour(supervisor).

-include("emqx_kafka_bridge.hrl").


%% API
-export([start_link/0]).
-export([init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    {ok, PoolEnv} = application:get_env(?APP, broker),
    PoolSpec = ecpool:pool_spec(?APP, ?APP, ?APP, PoolEnv),
    {ok, {{one_for_all, 10, 3600}, [PoolSpec]}}.
