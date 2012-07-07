%%%-------------------------------------------------------------------------%%%
%%% File        : CHANGES                                                   %%%
%%% Version     : 0.3.00/alpha                                              %%%
%%% Description : List of source code changes of Erlvolt                    %%%
%%% Copyright   : VoltDB, LLC - http://www.voltdb.com                       %%%
%%% Production  : Eonblast Corporation - http://www.eonblast.com            %%%
%%% Author      : H. Diedrich - <hd2010@eonblast.com>                       %%%
%%% License     : GPLv3 - see LICENSE                                       %%%
%%% Created     : 12 May 2010                                               %%%
%%% Changed     : 07 Jul 2012                                               %%%
%%%-------------------------------------------------------------------------%%%


0.3.00  07 Jul 2012

        + add: Makefiles
        + alt: dir structure, moved tests into test/, erlunit stripped to etc/
        + add: fixed error/1,2 ambiguity in erlunit

0.2.01  15 Jun 2010

        + add: extensive tests for callback id list (test3.erl)
        + alt: changes in heads and body of callProcedure, now w/callback
        + ext: connection record replaces socket-only parameter
        + add: close(Connection) added, and added to all samples.
        

0.1.03  11 Jun 2010 r33

        + ext: default encoding of array, (binary) string and integer parameters 
        + alt: default parameter encoding attempt of any type as string dropped
        + add: more parameter conversion tests

0.1.02  11 Jun 2010 r32

        + fix: timestamps now interpreted as microseconds (thx Ning)
        + License tags now termed precisely as they should

0.1.01  + Minor changes

0.1     * First public release