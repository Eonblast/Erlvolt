%%%-------------------------------------------------------------------------%%%
%%% File        : erlvolt.hrl                                               %%%
%%% Version     : 0.1.02/alpha                                              %%%
%%% Description : Erlang-VoltDB client API                                  %%%
%%% Copyright   : VoltDB, LLC - http://www.voltdb.com                       %%%
%%% Production  : Eonblast Corporation - http://www.eonblast.com            %%%
%%% Author      : H. Diedrich <hd2010@eonblast.com>                         %%%
%%% Licence     : GPLv3                                                     %%%
%%% Created     : 25 Apr 2010                                               %%%
%%% Changed     : 26 May 2010                                               %%%
%%%-------------------------------------------------------------------------%%%
%%%                                                                         %%%
%%%   For more info, see erlvolt.erl.                                       %%%
%%%                                                                         %%%
%%%   TODO: Why is this file not part of erlvolt.erl?                       %%%
%%%                                                                         %%%
%%%-------------------------------------------------------------------------%%%
%%%                                                                         %%%
%%%    Erlvolt 0.1.02/alpha - an Erlang-VoltDB client API.                  %%%
%%%                                                                         %%%
%%%    This file is part of VoltDB.                                         %%%
%%%    Copyright (C) 2008-2010 VoltDB, LLC http://www.voltdb.com            %%%
%%%    Author H. Diedrich <hd2010@eonblast.com> http://www.eonblast.com     %%%
%%%                                                                         %%%
%%%    Copyright (C) 2008-2010 VoltDB L.L.C.                                %%%
%%%                                                                         %%%
%%%    VoltDB is free software:  you can redistribute it  and/or  modify    %%%
%%%    it under the terms of the GNU General Public License as published    %%%
%%%    by the Free Software Foundation, either version 3 of the License,    %%%
%%%    or (at your option) any later version.                               %%%
%%%                                                                         %%%
%%%    VoltDB  is distributed  in the hope  that it will be useful,  but    %%%
%%%    WITHOUT  ANY  WARRANTY;  without  even  the  implied  warranty of    %%%
%%%    MERCHANTABILITY  or  FITNESS  FOR A  PARTICULAR PURPOSE.  See the    %%%
%%%    GNU General Public License for more details.                         %%%
%%%                                                                         %%%
%%%    You should have received a copy of the GNU General Public License    %%%
%%%    along with  VoltDB.  If not,  see <http://www.gnu.org/licenses/>.    %%%
%%%                                                                         %%%
%%%-------------------------------------------------------------------------%%%


%*****************************************************************************%
%                             Message Headers                                 %
%*****************************************************************************%

-define(VOLT_HEADER_TYPE, 8/integer). % Note: _TYPE means Erlang binary type.
% Change this type if (***) is ever changed to be non-implicit.

-define(VOLT_PROTOCOL_VERSION, 0).
-define(VOLT_PROTOCOL_VERSION_TYPE, 8/integer-big).
-define(VOLT_PROTOCOL_VERSION_BINARY, <<?VOLT_PROTOCOL_VERSION:?VOLT_PROTOCOL_VERSION_TYPE>>).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                         %%%
%%%                            BASIC TYPES                                  %%%
%%%                                                                         %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%*****************************************************************************%
%                                 Strings                                     %
%*****************************************************************************%
%                                                                             %
%   Strings begin with a 4-byte integer storing the number of bytes of char-  %
%   acter data, followed by the character data.                               %
%                                                                             %
%   --- Pg. 2, VoltDB Client Wire Protocol Version 0, 05/05/10 ---            %
%                                                                             %
%   Erlang default is big endian. Erlang default <<>> scan type is integer.   %
%                                                                             %
%******************************************************************************

-define(VOLT_STRING_SIZE_BINARY_TYPE, 32/big-signed).
-define(VOLT_STRING_BINARY(B), Size:?VOLT_STRING_SIZE_BINARY_TYPE, B:Size/binary).
-define(VOLT_STRING_BINARY_W_SIZE(B,Size), Size:?VOLT_STRING_SIZE_BINARY_TYPE, B:Size).

-define(VOLT_STRING_NULL, -1:?VOLT_STRING_SIZE_BINARY_TYPE).
-define(VOLT_STRING_EMPTY, 0:?VOLT_STRING_SIZE_BINARY_TYPE).

-define(VOLT_MAX_STRING_SIZE, 1000000).


%%%----------------------------------------------------------------------------
%%% VoltDB (Java) Float NaN Bit Patterns
%%%----------------------------------------------------------------------------

% IEEE 754 does not define 'the' bit pattern for, e.g. NaN. But Java does.
% There are many bit patterns that are NaN, meaning, they don't have a
% meaningful value as float numbers. But again, Java defines one as 'the' NaN.

%  Home � Open-JDK-6.b17-src  � java � lang  � source
%  ...
%  48    * @since JDK1.0
%  49    */
%  50   public final class Float extends Number implements Comparable<Float> {
%  51       /**
%  52        * A constant holding the positive infinity of type
%  53        * {@code float}. It is equal to the value returned by
%  54        * {@code Float.intBitsToFloat(0x7f800000)}.
%  55        */
%  56       public static final float POSITIVE_INFINITY = 1.0f / 0.0f;
%  57
%  58       /**
%  59        * A constant holding the negative infinity of type
%  60        * {@code float}. It is equal to the value returned by
%  61        * {@code Float.intBitsToFloat(0xff800000)}.
%  62        */
%  63       public static final float NEGATIVE_INFINITY = -1.0f / 0.0f;
%  64
%  65       /**
%  66        * A constant holding a Not-a-Number (NaN) value of type
%  67        * {@code float}.  It is equivalent to the value returned by
%  68        * {@code Float.intBitsToFloat(0x7fc00000)}.
%  69        */
%  70       public static final float NaN = 0.0f / 0.0f;
%  ...
%  - http://www.docjar.com/html/api/java/lang/Float.java.html

%%%----------------------------------------------------------------------------

-define(VOLT_NAN,               <<16#7fc00000>>).
-define(VOLT_POSITIVE_INFINITY, <<16#7f800000>>).
-define(VOLT_NEGATIVE_INFINITY, <<16#ff800000>>).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%----------------------------------------------------------------------------
%%% VoltDB Integer Limits
%%%----------------------------------------------------------------------------

% http://en.wikipedia.org/wiki/Integer_%28computer_science%29
% Erlang has not limits for integers at all.

-define(VOLT_BYTE_MIN,    -128).
-define(VOLT_BYTE_MAX,     127).
-define(VOLT_SHORT_MIN,   -32768).
-define(VOLT_SHORT_MAX,    32767).
-define(VOLT_INTEGER_MIN, -2147483648).
-define(VOLT_INTEGER_MAX,  2147483647).
-define(VOLT_LONG_MIN,    -9223372036854775808).
-define(VOLT_LONG_MAX,     9223372036854775807).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%----------------------------------------------------------------------------
%%% VoltDB Decimal Null and Limits
%%%----------------------------------------------------------------------------

% VoltDB: "Null is serialized as the smallest representable value which is
% -170141183460469231731687303715884105728. Serializing values (Null excluded)
% that are greater than 99999999999999999999999999999999999999 or less than
% -99999999999999999999999999999999999999 will result in an error response.

-define(VOLT_DECIMAL_BINARY_TYPE(E), <<E:128/signed-big>>).

-define(VOLT_DECIMAL_MAX,    99999999999999999999999999999999999999).
-define(VOLT_DECIMAL_MIN,   -99999999999999999999999999999999999999).
-define(VOLT_DECIMAL_NULL, -170141183460469231731687303715884105728).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%----------------------------------------------------------------------------
%%% Application Specific Data Types
%%%----------------------------------------------------------------------------

% A Byte value specifying the type of a serialized value on the wire.
% * ARRAY     = -99
% * NULL      =   1
% * TINYINT   =   3
% * SMALLINT  =   4
% * INTEGER   =   5
% * BIGINT    =   6
% * FLOAT     =   8
% * STRING    =   9
% * TIMESTAMP =  11
% * DECIMAL   =  22

%%%----------------------------------------------------------------------------

-define(VOLT_ARRAY,    -99).
-define(VOLT_NULL,       1).
-define(VOLT_TINYINT,    3).
-define(VOLT_SMALLINT,   4).
-define(VOLT_SHORTINT,   4).
-define(VOLT_INTEGER,    5).
-define(VOLT_INTINT,     5).
-define(VOLT_BIGINT,     6).
-define(VOLT_FLOAT,      8).
-define(VOLT_STRING,     9).
-define(VOLT_TIMESTAMP, 11).
-define(VOLT_DECIMAL,   22).

%%%----------------------------------------------------------------------------

-define(VOLT_TINYINT_TYPE,     8/big-signed).
-define(VOLT_SMALLINT_TYPE,   16/big-signed).
-define(VOLT_SHORTINT_TYPE,   16/big-signed).
-define(VOLT_INTEGER_TYPE,    32/big-signed).
-define(VOLT_INTINT_TYPE,     32/big-signed).
-define(VOLT_BIGINT_TYPE,     64/big-signed).
-define(VOLT_FLOAT_TYPE,      32/float-big-signed).
-define(VOLT_TIMESTAMP_TYPE,  64/big-signed).
-define(VOLT_DECIMAL_TYPE,   128/big-signed).

%%%----------------------------------------------------------------------------

-define(VOLT_TINYINT_WIRE_BYTES,   1).
-define(VOLT_SMALLINT_WIRE_BYTES,  2).
-define(VOLT_SHORTINT_WIRE_BYTES,  2). % TODO: unify 'short' and 'small'
-define(VOLT_INTEGER_WIRE_BYTES,   4).
-define(VOLT_INTINT_WIRE_BYTES,    4). % TODO: make 'integer' consistent
-define(VOLT_BIGINT_WIRE_BYTES,    8).
-define(VOLT_FLOAT_WIRE_BYTES,     4).
-define(VOLT_TIMESTAMP_WIRE_BYTES, 8).
-define(VOLT_DECIMAL_WIRE_BYTES,  16).

%%%----------------------------------------------------------------------------

-define(VOLT_FLOAT_BINARY,      4/binary).
-define(VOLT_TIMESTAMP_BINARY,  8/binary).
-define(VOLT_DECIMAL_BINARY,   16/binary).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%----------------------------------------------------------------------------
%%% Procedure Call Status Code
%%%----------------------------------------------------------------------------

% A Byte value specifying the success or failure of a remote stored procedure call.
% * SUCCESS            =  1
% * USER_ABORT         = -1
% * GRACEFUL_FAILURE   = -2
% * UNEXPECTED_FAILURE = -3
% * CONNECTION_LOST    = -4

%%%----------------------------------------------------------------------------

-define(VOLT_SUCCESS,             1).
-define(VOLT_USER_ABORT,         -1).
-define(VOLT_GRACEFUL_FAILURE,   -2).
-define(VOLT_UNEXPECTED_FAILURE, -3).
-define(VOLT_CONNECTION_LOST,    -4).


%%%-----------------------------------�%�-----------------------------------%%%