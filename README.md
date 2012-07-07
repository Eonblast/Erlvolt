Erlvolt
=======

Erlang VoltDB driver by Eonblast.

-------------------------------------------------------------------------  

    File        : README                                                     
    Version     : 0.3.00/alpha                                              
    Description : Erlang-VoltDB client API                                  
    Copyright   : VoltDB, LLC - http://www.voltdb.com                       
    Production  : Eonblast Corporation - http://www.eonblast.com            
    Author      : H. Diedrich <hd2010@eonblast.com>                         
    License     : GPLv3                                                     
    Created     : 17 Apr 2010                                               
    Changed     : 07 Jul 2012                                                

-------------------------------------------------------------------------
                                                                             
Erlvolt is an Erlang interface to a VoltDB server. It allows for      
Erlang programs to talk with the VoltDB server as VoltDB clients.     
                                                                             
NOTE:  The  VoltDB wire protocol  has changed and this project is in  
catch up mode. The extensive unit test cases are currently dated and  
may deliver false positives as well as false negatives.                                                                         
                                                                             
-------------------------------------------------------------------------
                                                                             
This API is being contributed to VoltDB by Eonblast Corporation.      
                                                                             
-------------------------------------------------------------------------
                                                                             
## STATUS                                                                
                                                                             
Clearing up bit rot since VoltDB 1.0.01                               
                                                                             
## REQUIREMENTS                                                          
                                                                             
       + VoltDB 2.5                                                          
       + Tested on Java 1.6.0-26 (use -18+!)                                 
       + Tested on Erlang R15B                                               
                                                                             
## TESTS                                                                 
                                                                             
       + Get Erlunit from http://github.com/Eonblast/Erlunit/tarball/master  
         and put it into subfolder test/erlunit.                             
       + run: make test                                                      
                                                                             
## SAMPLE                                                                
                                                                             
       + run: make hello                                                      
                                                                             
## DOCS                                                                  
                                                                             
       + point your browser to doc/index.html                                 
                                                                             
-------------------------------------------------------------------------
                                                                             
Erlvolt is used for G-MOD at Eonblast http://www.eonblast.com.      
                                                                             
-------------------------------------------------------------------------
                                                                             
Erlvolt is a native  Erlang  driver  for  VoltDB.  It allows for an   
Erlang program  to be a  VoltDB client. Erlvolt clients:               
                                                                      
* can be many                                                         
* can make synchronous request                                        
                                                                      
Erlvolt communicates with the VoltDB server using the binary VoltDB   
wire protocol.  The server does not know wether it is  talking to a   
Java or an Erlang client.                                               
                                                                       
In many cases the  Erlang  program  will itself be a server and the   
VoltDB server its database back end.  Implementation of  Erlvolt is   
at this point as a  library.  It will  become an  app and allow for   
asynchronous communication very shortly now.                          
                                                                             
-------------------------------------------------------------------------
                                                                             
Erlvolt 0.3.00/alpha - an Erlang-VoltDB client API.                  
Copyright (C) 2010 VoltDB, LLC http://www.voltdb.com                 
Author H. Diedrich <hd2010@eonblast.com> http://www.eonblast.com     
                                                                     
This program is  free software:  you can redistribute it and / or    
modify it  under the terms of the  GNU  General Public License as    
published  by the Free Software Foundation,  either version  3 of    
the License,  or (at your option) any later version.                 
                                                                     
This program is distributed  in the hope  that it will be useful,    
but  WITHOUT ANY WARRANTY;  without  even the implied warranty of    
MERCHANTABILITY  or  FITNESS FOR  A PARTICULAR PURPOSE.  See  the    
GNU General Public License for more details.                         
                                                                     
You should have received a copy of the GNU General Public License    
along with this program. If not, see <http://www.gnu.org/licenses/>. 
                                                                     
