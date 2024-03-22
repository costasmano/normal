//%attributes = {"invisible":true}
If (False:C215)
	//GP Check_DupCU
	//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
	
	//Check for duplicate Condition Unit.
	//Look for duplicate Inspection ID/Element ID/Environment combination.
	Mods_2005_CM06
	Mods_2005_CM17
End if 

C_BOOLEAN:C305($0)  //Returns true if duplicate was found.
C_LONGINT:C283($CU_ID; $InspID; $NumDupCUsFound)
C_LONGINT:C283($ElemID; $Env)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($FoundDup)
C_TEXT:C284($Text)  // Command Replaced was o_C_STRING length was 255

$CU_ID:=[Cond Units:45]Cond Unit ID:1
$InspID:=[Cond Units:45]Inspection ID:2
$ElemID:=[Cond Units:45]Element ID:3
$Env:=[Cond Units:45]Environment:4
If (False:C215)
	PUSH RECORD:C176([Cond Units:45])
	CUT NAMED SELECTION:C334([Cond Units:45]; "Check_DupCU")
	QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2=$InspID; *)
	QUERY:C277([Cond Units:45];  & ; [Cond Units:45]Element ID:3=$ElemID; *)
	QUERY:C277([Cond Units:45];  & ; [Cond Units:45]Environment:4=$Env; *)
	QUERY:C277([Cond Units:45];  & ; [Cond Units:45]Cond Unit ID:1#$CU_ID)
	$FoundDup:=(Records in selection:C76([Cond Units:45])>0)
	USE NAMED SELECTION:C332("Check_DupCU")
	POP RECORD:C177([Cond Units:45])
Else 
	SET QUERY DESTINATION:C396(Into variable:K19:4; $NumDupCUsFound)
	QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2=$InspID; *)
	QUERY:C277([Cond Units:45];  & ; [Cond Units:45]Element ID:3=$ElemID; *)
	QUERY:C277([Cond Units:45];  & ; [Cond Units:45]Environment:4=$Env; *)
	QUERY:C277([Cond Units:45];  & ; [Cond Units:45]Cond Unit ID:1#$CU_ID)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	$FoundDup:=($NumDupCUsFound>0)
	
End if 

$0:=$FoundDup