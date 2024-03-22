//SC vBIE on layout [BMS Inspections];"Inspections In".
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.

//Display variable for the District Bridge Inspection Engineer.

C_TEXT:C284(vBIE)  // Command Replaced was o_C_STRING length was 44
C_LONGINT:C283($k)  //Command Replaced was o_C_INTEGER

//TRACE

If (Form event code:C388=On Load:K2:1)
	If ([BMS Inspections:44]Inspection ID:1=0)
		//This is a new record.    
		QUERY:C277([Personnel:42]; [Personnel:42]Job Code:8=1; *)
		QUERY:C277([Personnel:42];  & ; [Personnel:42]Division No:7="044"+String:C10(Num:C11([Bridge MHD NBIS:1]Item2:60)))
		If (Records in selection:C76([Personnel:42])=1)
			[BMS Inspections:44]DBrInspEngr:5:=[Personnel:42]Person ID:1
		End if 
	End if 
	$k:=Find in array:C230(aPeople_ID; [BMS Inspections:44]DBrInspEngr:5)
	If ($k>0)
		vBIE:=aPeople{$k}
	Else 
		vBIE:="Select Insp. Engineer"
	End if 
End if 