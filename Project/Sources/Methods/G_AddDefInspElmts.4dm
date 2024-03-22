//%attributes = {"invisible":true}
If (False:C215)
	//procedure: G_AddDefInspElmts
	//created: Aug-2003 - v 3.3f
	//purpose: Add the default Elements for an Inspection type.
	// Modified by: costasmanousakis-(Designer)-(12/6/07 14:41:26)
	Mods_2007_CM_5401
	
End if 

C_LONGINT:C283($hlList)

RELATE ONE:C42([Inspections:27]Insp Type:6)
vInspTitle:=[Inspection Type:31]Description:2+" Inspection"
C_BOOLEAN:C305($vbStartTrans)
$vbStartTrans:=False:C215
If (Not:C34(In transaction:C397))
	//START TRANSACTION
	//$vbStartTrans:=True
End if 
MESSAGE:C88(Char:C90(13)+"Getting Default Elements...")
$hlList:=G_DefInspElmts
//Reconfigure the inspection form    
If (Not:C34($hlList=0))  //Added 12-dec-03
	C_LONGINT:C283($i)
	For ($i; 1; Size of array:C274(<>ELMTDICT_ELNum_ai))
		//Add records found on the list      
		If (List item position:C629($hlList; <>ELMTDICT_ELNum_ai{$i})#0)
			MESSAGE:C88(Char:C90(13)+"Adding Elmt "+String:C10($i)+" of "+String:C10(Size of array:C274(<>ELMTDICT_ELNum_ai))+"...")
			//This is for debugging reasons only in trace mode $debug_b is by default false - can be changed in debugger window 
			C_BOOLEAN:C305($debug_b)
			If ($debug_b)
				C_TEXT:C284($ItemText)
				C_LONGINT:C283($ItemRef)
				GET LIST ITEM:C378($hlList; List item position:C629($hlList; <>ELMTDICT_ELNum_ai{$i}); $ItemRef; $ItemText)
				$ItemRef:=Count list items:C380($hlList; *)
			End if 
			
			CREATE RECORD:C68([ElementsSafety:29])
			Inc_Sequence("ElementsSafety"; ->[ElementsSafety:29]ElmSafetyID:7)
			[ElementsSafety:29]InspID:4:=[Inspections:27]InspID:2
			[ElementsSafety:29]ElementNo:1:=<>ELMTDICT_ELNum_ai{$i}
			[ElementsSafety:29]Rating:2:="N"
			[ElementsSafety:29]AltRating:21:="N"  //Sep-2001 : made this default to 9 same as above ground rating
			[ElementsSafety:29]Deficiency:3:="N"
			[ElementsSafety:29]Description:22:=<>ELMTDICT_Txt_as{$i}  //Copy the standard definition over ASL 11/13/2001
			LogNewRecord(->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2; "ElementsSafety")
			InitChangeStack(2)
			PushChange(2; ->[ElementsSafety:29]ElementNo:1)
			If ([Inspections:27]Insp Type:6#"DV@")
				//not needed for UW inspections            
				PushChange(2; ->[ElementsSafety:29]Rating:2)
			End if 
			PushChange(2; ->[ElementsSafety:29]AltRating:21)
			PushChange(2; ->[ElementsSafety:29]Deficiency:3)
			PushChange(2; ->[ElementsSafety:29]Description:22)
			FlushGrpChgs(2; ->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
			SAVE RECORD:C53([ElementsSafety:29])
		End if 
	End for 
End if   //end of If $Hlist=0
If ($vbStartTrans)
	VALIDATE TRANSACTION:C240
End if 

//Clear the hlists
If (Is a list:C621($hlList))
	CLEAR LIST:C377($hlList; *)
End if 