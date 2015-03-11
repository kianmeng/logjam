# logjam

*A Logging Library for LFE*

<a href="https://raw.githubusercontent.com/lfex/logjam/master/resources/images/logjam.jpg"><img src="resources/images/logjam-crop-small.png"></a>


## Table of Contents

* [Introduction](#introduction-)
* [Installation](#installation-)
* [Setup](#setup-)
* [Usage](#usage-)
  * [As Includes](#as-includes-)
  * [Via mod func](#via-mod-func-)
  * [Log-level Functions](#log-level-functions-)
  * [Dynamically Updating Log Levels](#dynamically-updating-log-levels-)


## Introduction [&#x219F;](#table-of-contents)

The preferred logging library in Erlang is
[lager](https://github.com/basho/lager). However, it doesn't work
out of the box with LFE, due to the fact that it uses parse transforms (the LFE
compiler uses Core Erlang and does not generate Erlang abstract terms, which
are how Erlang parse transforms work).

As such, we needed a way to easily use lager from LFE. So here you have it: a
a pile of logs for the LFE community, in a river of LFE code ...


## Installation [&#x219F;](#table-of-contents)

Just add it to your ``rebar.config`` deps:

```erlang
  {deps, [
    ...
    {logjam, ".*",
      {git, "git@github.com:lfex/logjam.git", "master"}}
      ]}.
```

And then do the usual:

```bash
    $ make compile
```


## Setup [&#x219F;](#table-of-contents)

First things first, make sure you have an ``lfe.config`` file with the
appropriate lager configuration options set. For instance:

```cl
#(logging (
   #(log-level info)
   #(backend lager)
   #(options (#(lager_console_backend info)
              #(lager_file_backend (
                #(file "log/error.log")
                #(level error)
                #(size 10485760)
                #(date "$D0")
                #(count 5)))
              #(lager_file_backend (
                #(file "log/console.log")
                #(level info)
                #(size 10485760)
                #(date "$D0")
                #(count 5)))))))
```

Any legal lager configuration will work (as long as you translate it into LFE
syntax first!).

Next, setup logjam:

```cl
> (logjam:setup)
ok
> 23:15:06.522 [info] Application lager started on node nonode@nohost
```

As you might guess, this will start up lager. You may or may not see a message
logged to the console, depending upon your settings in ``lfe.config``.


## Usage [&#x219F;](#table-of-contents)

### As Includes [&#x219F;](#table-of-contents)


You can include logjam functions in your LFE files with the following:

```cl
> (include-lib "logjam/include/logjam.lfe")
loaded-logjam
> (info "...")
...
```

### Via mod func [&#x219F;](#table-of-contents)

In some instances, it may not be perferable to use ``(include-lib ...)`` and
you may prefer ``mod:func`` calls instead. The ``logjam`` module includes the
functions so that this usage is possible:

```cl
> (logjam:info "...")
...
```

### Log-level Functions [&#x219F;](#table-of-contents)

Now you'll be able to use logjam. The following log types are defined:
 * ``debug``
 * ``info``
 * ``notice``
 * ``warning``
 * ``error`` (supported by both sets of ``error`` and ``err`` functions)
 * ``critical``
 * ``alert``
 * ``emergency``

Each of these has arity 1, 2, 3, and 4 functions of the same name:
* arity 1: pass a message
* arity 2: pass an ``(io_lib:format ...)`` format string and arguments for the
  format string
* arity 3: pass a module, a function, and a message
* arity 4: pass a module, a function, an ``(io_lib:format ...)`` format string,
  and arguments for the format string

Examples:

```cl
> (info "wassup?")
ok
> 23:37:19.206 [info] wassup?
```

```cl
> (critical "~s~shey!" '("a " "critical thing, hey-"))
ok
> 23:37:38.594 [critical] a critical thing, hey-hey!
```

```cl
> (notice (MODULE) 'my-func "You better check this out ...")
ok
> 23:45:45.097 [notice] [-no-module:my-func] You better check this out ...
```

```cl
> (alert (MODULE) 'my-func "~s~shey!" '("whoa! " "red alert, "))
ok
> 23:41:35.176 [alert] [-no-module:my-func] whoa! red alert, hey!
```


### Dynamically Updating Log Levels [&#x219F;](#table-of-contents)

logjam provides the following wrappers for this same functionality in lager:
 * ``logjam:set-level/1`` - set the level of the console backend
 * ``logjam:set-level/2`` - set the log level of a given backend
 * ``logjam:set-level/3`` - set the log level of a given backend's' logfile

Examples:

```cl
> (logjam:set-level 'debug)
ok
 ```

```cl
> (logjam:set-level 'lager_console_backend 'debug)
ok
```

```cl
> (logjam:set-level 'lager_file_backend "log/console.log" 'debug)
21:32:03.894 [notice] Changed loglevel of log/console.log to debug
ok
```

```cl
(logjam:set-level 'lager_file_backend "log/error.log" 'warning)
21:34:32.131 [notice] Changed loglevel of log/error.log to warning
ok
```
