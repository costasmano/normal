//%attributes = {"invisible":true}
If (False:C215)
	
	//GP TEMP_MetricConv
	
	//This procedure was used once and should not be used again.
	//It converts English quantities and condition states to metric.
	
	// Modified by: costasmanousakis-(Designer)-(1/23/2006 09:08:21)
	Mods_2006_CM03
	
	//C_STRING(30;$Units)
	//C_REAL($ConvFact)
	//C_LONGINT($i;$j)
	//TRACE
	//
	//ALL RECORDS([Cond Units])
	//
	//For ($i;1;Records in selection([Cond Units]))
	//START TRANSACTION
	//
	//RELATE ONE([Cond Units]Element ID)
	//$Units:=[BMS Elements]Units
	//Case of 
	//: (Substring($Units;1;2)="LM")
	//$ConvFact:=0.3048
	//: ($Units="EA/SM")
	//$ConvFact:=0.3048*0.3048
	//Else 
	//$ConvFact:=1
	//End case 
	//
	//RELATE MANY([Cond Units]Cond Unit ID)
	//For ($j;1;Records in selection([Cond State Insp]))
	//[Cond State Insp]Amount:=[Cond State Insp]Amount*$ConvFact
	//[Cond State Insp]future use:=True
	//SAVE RECORD([Cond State Insp])
	//NEXT RECORD([Cond State Insp])
	//End for 
	//
	//[Cond Units]Total Quantity:=[Cond Units]Total Quantity*$ConvFact
	//[Cond Units]Comment:="∆"+[Cond Units]Comment  `Mark this CU as done.
	//SAVE RECORD([Cond Units])
	//NEXT RECORD([Cond Units])
	//
	//VALIDATE TRANSACTION
	//End for 
	
End if 
