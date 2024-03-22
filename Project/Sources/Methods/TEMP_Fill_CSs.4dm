//%attributes = {"invisible":true}
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(1/23/2006 09:07:58)
	Mods_2006_CM03
	
	//GP TEMP_Fill_CSs
	//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
	
	//This procedure will merge the many [Cond State Insp] records
	//into their [Cond Units] parent record.
	
	//It is intended that this procedure be used once and then the new
	//structure will be used.
	
	//C_LONGINT($LRecs;$i;$j)
	//C_BOOLEAN($Corrupted)
	//ARRAY POINTER($a_ptr_CS;5)
	//
	//  `TRACE
	//
	//$a_ptr_CS{1}:=->[Cond Units]CondState1
	//$a_ptr_CS{2}:=->[Cond Units]CondState2
	//$a_ptr_CS{3}:=->[Cond Units]CondState3
	//$a_ptr_CS{4}:=->[Cond Units]CondState4
	//$a_ptr_CS{5}:=->[Cond Units]CondState5
	//
	//NewWindow (200;30;0;4;"Processing")
	//GOTO XY(1;0)
	//MESSAGE("Processing CU Recs…")
	//
	//ALL RECORDS([Cond Units])
	//$LRecs:=Records in selection([Cond Units])
	//For ($i;1;$LRecs)
	//RELATE MANY([Cond Units]Cond Unit ID)
	//ORDER BY([Cond State Insp];[Cond State Insp]Cond State No)
	//$Corrupted:=False
	//For ($j;1;5)
	//If ($j<=Records in selection([Cond State Insp]))
	//If ($j=[Cond State Insp]Cond State No)
	//$a_ptr_CS{$j}->:=[Cond State Insp]Amount
	//Else 
	//$a_ptr_CS{$j}->:=-999.999
	//$Corrupted:=True
	//End if 
	//Else 
	//$a_ptr_CS{$j}->:=-1
	//End if 
	//NEXT RECORD([Cond State Insp])
	//End for 
	//If ($Corrupted)
	//ALERT("Corruption - CU:"+String([Cond Units]Cond Unit ID))
	//End if 
	//SAVE RECORD([Cond Units])
	//NEXT RECORD([Cond Units])
	//
	//If ($i%10=0)  `Don't slow down things just to display
	//GOTO XY(6;1)
	//MESSAGE("Record "+String($i)+" of "+String($LRecs))
	//End if 
	//End for 
	//
	//CLOSE WINDOW
End if 
