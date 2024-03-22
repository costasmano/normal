//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 11/01/12, 16:10:34
//----------------------------------------------------
//Method: insp_LoadESForReport
//Description
//This method will load data from element safety into variables on the form. 
//You should call Compiler_NewInspReports before to make sure all are typed
//Assume that [Inspection Type]ElementNumbers_txt is filled as follows
//N58 the element category type folowed by a CR
//The element numbers, followed by a CR and delimted by commas
//100,101,102,103,118,106,107,108,109,110,111,112,114,115,116 
//The element labels, followed by a CR and delimted by commas
//1.,2.,3.,4.,5.,6.,7.,8.,9.,10.,11.,12.,13.,14.,15.,16.
//N59
//200,201,202,203,204,205,206,207,208,209,210,211,212, 213,214,215,216,217,218,219,220,227
//1.,2.,3.,4.,5.,6.,7.,8.,9.,10.,11.,12.,13.,14.,15.,16.
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_10  //r004 ` 
	//Modified by: Charles Miller (11/1/12 16:10:46)
	// Modified by: Costas Manousakis-(Designer)-(12/27/12 14:51:44)
	Mods_2012_12
	//  `Allow extra line for the element labels
	// Modified by: Costas Manousakis-(Designer)-(5/2/13 15:50:42)
	Mods_2013_05  //r001 ` `removed call to Compiler_NewInspReports
	//Modified by: Charles Miller (5/2/13 16:34:33)
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
End if 

C_TEXT:C284($1; $InspectionType_txt; $ElementType_txt; $ElementNumbers_txt; $T_final; $ElementLbls_txt)
$InspectionType_txt:=$1
C_LONGINT:C283($MaxOffset_L; $Offset_L; $Position_L; $Loop_l; $Size_l; $ElementPosition_l; $ElementDictPos_l)
ut_Read_Write_Tables("READ"; ->[Inspection Type:31]; ->[ElementDict:30]; ->[Element Cat:32])
C_POINTER:C301($VTptr; $VRptr; $VDptr; $VrDptr; $vRemptr)
G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4)
CREATE SET:C116([ElementsSafety:29]; "$MySet")
If ([Inspection Type:31]Code:1=$InspectionType_txt)
	
Else 
	QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=$InspectionType_txt)
End if 
$MaxOffset_L:=Length:C16([Inspection Type:31]ElementNumbers_txt:4)

$Offset_L:=1
Repeat 
	$Position_L:=Position:C15("\r"; [Inspection Type:31]ElementNumbers_txt:4; $Offset_L)
	If ($Position_L>0)
		$ElementType_txt:=Substring:C12([Inspection Type:31]ElementNumbers_txt:4; $Offset_L; $Position_L-$Offset_L)  //N58, n60 etc
		$Offset_L:=$Position_L+1
		$Position_L:=Position:C15("\r"; [Inspection Type:31]ElementNumbers_txt:4; $Offset_L)  //element numbers 100, 101, etc
		If ($Position_L>0)
			$ElementNumbers_txt:=Substring:C12([Inspection Type:31]ElementNumbers_txt:4; $Offset_L; $Position_L-$Offset_L)  //element numbers 100, 101, etc 
			$Offset_L:=$Position_L+1
			$Position_L:=Position:C15("\r"; [Inspection Type:31]ElementNumbers_txt:4; $Offset_L)  //element labels 1.,2.,a. etc
			
			If ($Position_L>0)
				$ElementLbls_txt:=Substring:C12([Inspection Type:31]ElementNumbers_txt:4; $Offset_L; $Position_L-$Offset_L)  // `element labels 1.,2.,a. etc
				$Offset_L:=$Position_L+1
			Else 
				$ElementLbls_txt:=Substring:C12([Inspection Type:31]ElementNumbers_txt:4; $Offset_L)
				$Offset_L:=$MaxOffset_L
			End if 
		Else 
			$Offset_L:=$MaxOffset_L
		End if 
		ARRAY TEXT:C222($ElementNumbers_atxt; 0)
		ARRAY TEXT:C222($ElementNumberLabels_atxt; 0)
		ut_NewTextToArray($ElementNumbers_txt; ->$ElementNumbers_atxt; ",")
		ut_NewTextToArray($ElementLbls_txt; ->$ElementNumberLabels_atxt; ",")
		
	Else 
		$Offset_L:=$MaxOffset_L
	End if 
	
	USE SET:C118("$MySet")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3=$ElementType_txt)
	$Size_l:=0
	ARRAY INTEGER:C220($ElementNo_al; $Size_l)
	ARRAY TEXT:C222($AltRating_as; $Size_l)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($Deficiency_as; $Size_l)  //Deficiencies//Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($Priority_as; $Size_l)  //Priority converted to deficieny + priority//Command Replaced was o_ARRAY string length was 5
	ARRAY TEXT:C222($Description_as; $Size_l)  //Command Replaced was o_ARRAY string length was 40
	ARRAY TEXT:C222($Rating_as; $Size_l)  //Command Replaced was o_ARRAY string length was 1
	$Size_l:=Records in selection:C76([ElementsSafety:29])
	ARRAY INTEGER:C220($ElementNo_al; $Size_l)
	ARRAY TEXT:C222($AltRating_as; $Size_l)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($Deficiency_as; $Size_l)  //Deficiencies//Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($Priority_as; $Size_l)  //Priority converted to deficieny + priority//Command Replaced was o_ARRAY string length was 5
	ARRAY TEXT:C222($Description_as; $Size_l)  //Command Replaced was o_ARRAY string length was 40
	ARRAY TEXT:C222($Rating_as; $Size_l)  //Command Replaced was o_ARRAY string length was 1
	SELECTION RANGE TO ARRAY:C368(1; $Size_l; [ElementsSafety:29]ElementNo:1; $ElementNo_al; [ElementsSafety:29]Rating:2; $Rating_as; [ElementsSafety:29]AltRating:21; $AltRating_as; [ElementsSafety:29]Deficiency:3; $Deficiency_as; [ElementsSafety:29]Priority:20; $Priority_as; [ElementsSafety:29]Description:22; $Description_as)
	
	For ($Loop_l; 1; Size of array:C274($ElementNo_al))
		//Jan-2002 : Remove spaces from Deficiency
		$Deficiency_as{$Loop_l}:=Replace string:C233($Deficiency_as{$Loop_l}; " "; "")
		//Apr-2002 : Remove spaces from Priority
		$Priority_as{$Loop_l}:=Replace string:C233($Priority_as{$Loop_l}; " "; "")
		If ($Deficiency_as{$Loop_l}="N")
			$Deficiency_as{$Loop_l}:="-"  //default display of no deficiency
		End if 
		If (Length:C16($Priority_as{$Loop_l})#0)
			$Priority_as{$Loop_l}:=$Deficiency_as{$Loop_l}+"-"+$Priority_as{$Loop_l}  //if there is a prio combine def+prio
		Else 
			$Priority_as{$Loop_l}:=$Deficiency_as{$Loop_l}  // else set it to deficiency alone            
		End if 
		
	End for 
	C_LONGINT:C283($ReturnLengthLimit_L)
	$ReturnLengthLimit_L:=INSP_ReturnCMLength
	
	For ($Loop_l; 1; Size of array:C274($ElementNumbers_atxt))
		
		$ElementPosition_l:=Find in array:C230($ElementNo_al; Num:C11($ElementNumbers_atxt{$Loop_l}))
		$ElementDictPos_l:=Find in array:C230(<>ELMTDICT_ELNum_ai; Num:C11($ElementNumbers_atxt{$Loop_l}))
		
		$VTptr:=Get pointer:C304("VT"+$ElementType_txt+"_"+String:C10($Loop_l))
		$VDptr:=Get pointer:C304("VD"+$ElementType_txt+"_"+String:C10($Loop_l))
		$VRptr:=Get pointer:C304("VR"+$ElementType_txt+"_"+String:C10($Loop_l))
		$VrDptr:=Get pointer:C304("VrD"+$ElementType_txt+"_"+String:C10($Loop_l))
		If ([Inspections:27]Insp Type:6="TOV")
			$vRemptr:=Get pointer:C304("VRM"+$ElementType_txt+"_"+String:C10($Loop_l))
		End if 
		
		If ($ElementPosition_l>0)
			Case of 
				: (Length:C16($Description_as{$ElementPosition_l})>0)
					$VTptr->:=$ElementNumberLabels_atxt{$Loop_l}+" "+$Description_as{$ElementPosition_l}
				Else 
					$VTptr->:=$ElementNumberLabels_atxt{$Loop_l}+" "+<>ELMTDICT_Txt_as{$ElementDictPos_l}
			End case 
			
			$VDptr->:=$Priority_as{$ElementPosition_l}
			$VRptr->:=$Rating_as{$ElementPosition_l}
			$VrDptr->:=$AltRating_as{$ElementPosition_l}
			C_LONGINT:C283($temparea; $count)
			If ([Inspections:27]Insp Type:6="TOV")
				GOTO SELECTED RECORD:C245([ElementsSafety:29]; $ElementPosition_l)
				LOAD RECORD:C52([ElementsSafety:29])
				If (BLOB size:C605([ElementsSafety:29]ElmComments:23)>0)
					INSP_ElemCommentsList_WP(New object:C1471("elemblob"; ->[ElementsSafety:29]ElmComments:23; \
						"charlimit"; $ReturnLengthLimit_L; "varpointer"; $vRemptr; \
						"notfit"; "See remarks in comments section."))
				Else 
					$vRemptr->:=""
				End if 
			End if 
			
			
		Else 
			If ($ElementDictPos_l>0)
				$VTptr->:=$ElementNumberLabels_atxt{$Loop_l}+" "+<>ELMTDICT_Txt_as{$ElementDictPos_l}
			Else 
				$VTptr->:=""
			End if 
			$VDptr->:="-"
			$VRptr->:="N"
			$VrDptr->:="N"
			If ([Inspections:27]Insp Type:6="TOV")
				$vRemptr->:=""
			End if 
		End if 
		If (Position:C15("BLANK"; $VTptr->)>0)
			$VTptr->:=$ElementNumberLabels_atxt{$Loop_l}
			$VDptr->:=""
			$VRptr->:=""
			$VrDptr->:=""
			If ([Inspections:27]Insp Type:6="TOV")
				$vRemptr->:=""
			End if 
		End if 
	End for 
	
Until ($Offset_L>=$MaxOffset_L)
CLEAR SET:C117("$MySet")
//End insp_LoadESForReport