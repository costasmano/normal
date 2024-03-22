//%attributes = {"invisible":true}
//GP CHECK_NegCS($i)
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.

//This procedure is used by the Scripts for [Cond Units]Total Quantity and
//by the Scripts for the enterable Condition State objects vCS{i}.
//Any change to the total quantity affects the first Condition State.  If the
//change causes that Condition State to become negative, then the next
//Condition State must be modified, and so on.

C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER

$i:=$1

//Check for a negative value of a Condition State.
//This procedure is recursive (i.e., it calls itself).
If ((aCS{$i}<0) & (($i+1)<=vNoCSs))
	aCS{$i+1}:=aCS{$i+1}+aCS{$i}
	aCS{$i}:=0
	CHECK_NegCS($i+1)
End if 