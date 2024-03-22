//SC vTotQ on layout[Cond Units];"Cond Units In".
//Copyright © 1996-97, Thomas D. Nee, All Rights Reserved.

//Run only if modified.  The variable vNoCSs is the number of Condition
//State records, which has already been set in GP SETUP_CSs.
//The array aCS{i} is the intermediary between the Condition State values stored
//in the [Cond State Insp] records and the pointer array a_ptr_CS{i}
//(also initialized in GP SETUP_CSs), points to the enterable objects vCSi.
//aCS{i} is always a quantity;  vCSi can be either a quantity or a percent.

C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER

If ([BMS Elements:47]Units:6="EA")
	//This element must be recorded in whole numbers.
	vTotQ:=Round:C94(vTotQ; 0)
End if 

If ([BMS Inspections:44]Metric:14)
	[Cond Units:45]Total Quantity:5:=vTotQ
Else 
	[Cond Units:45]Total Quantity:5:=MetricizeQ(vTotQ; [BMS Elements:47]Units:6)
End if 

vTotQ:=Round:C94(vTotQ; 1)

PushChange(2; ->[Cond Units:45]Total Quantity:5)

If ([BMS Categories:49]Record as Each:6)
	//The Total Quantity must be in one and only one Condition State. 
	AllInOneCS
Else 
	//Make sure the CS amounts add up to the total quantity.  Assume that any
	//change to the total quantity modifies the first Condition State.
	aCS{1}:=[Cond Units:45]Total Quantity:5
	For ($i; 2; vNoCSs)
		aCS{1}:=aCS{1}-aCS{$i}
	End for 
	
	//Don't allow negative values; keep as much as possible in the worst
	//Condition States.
	CHECK_NegCS(1)
End if 

DISPLAY_CS