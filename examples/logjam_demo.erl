-module(logjam_demo).

-export([run/0]).

% -include_lib("kernel/include/logger.hrl").

% run() ->
%     ?'LOG_DEBUG'("This is a debug-level message"),
%     ?LOG_INFO("This is a info-level message"),
%     ?LOG_NOTICE("This is a notice-level message"),
%     ?LOG_WARNING("This is a warning-level message"),
%     ?LOG_ERROR("This is a error-level message"),
%     ?LOG_CRITICAL("This is a critical-level message"),
%     ?LOG_ALERT("This is a alert-level message"),
%     ?LOG_EMERGENCY("This is a emergency-level message"),
%     ?LOG_INFO(#{some => "structured",
%                 logging => "examples",
%                 might => "be useful too"}).

-include_lib("logjam/include/logjam.hrl").

run() ->
    ?'log-debug'("This is a debug-level message"),
    ?'log-info'("This is a info-level message"),
    ?'log-notice'("This is a notice-level message"),
    ?'log-warn'("This is a warning-level message"),
    ?'log-err'("This is a error-level message"),
    ?'log-crit'("This is a critical-level message"),
    ?'log-alert'("This is a alert-level message"),
    ?'log-emergency'("This is a emergency-level message"),
    ?'log-info'(#{some => "structured",
                  logging => "examples",
                  might => "be useful too"}).
