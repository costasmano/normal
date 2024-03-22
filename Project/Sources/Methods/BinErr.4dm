//%attributes = {"invisible":true}
//GP BinErr
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//This procedure returns a binary error value, given an error number.

C_LONGINT:C283($1; $0)  //Command Replaced was o_C_INTEGER

$0:=2^($1-1)