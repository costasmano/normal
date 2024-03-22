//%attributes = {"invisible":true}
//Method: CU_Print_FM
//Description
// Method for print forms of [Cond Units]; purpose : to allow printing using print form instead of Print SElection
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/29/16, 10:02:13
	// ----------------------------------------------------
	//Created : 
	Mods_2016_08
	
	C_LONGINT:C283(CU_Print_FM; $1)  //Copied to v15 Server on : 08/29/16, 14:38:24
	
	// Modified by: Costas Manousakis-(Designer)-(9/14/16 16:15:06)
	Mods_2016_09
	//  `added search on BMS Elements ; and an extra Else in the case statement when called from Print Selection
End if 
//
C_LONGINT:C283($FormEvent_L)
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Load:K2:1)
		
		C_TEXT:C284(vBIE)  // Command Replaced was o_C_STRING length was 44
		C_LONGINT:C283($k)  //Command Replaced was o_C_INTEGER
		
		$k:=Find in array:C230(aPeople_ID; [BMS Inspections:44]DBrInspEngr:5)
		If ($k>0)
			vBIE:=aPeople{$k}
		Else 
			vBIE:=""
		End if 
		
	: ($FormEvent_L=On Header:K2:17)
		
		C_TEXT:C284(vBIE)  // Command Replaced was o_C_STRING length was 44
		C_LONGINT:C283($i; $j; $k)  //Command Replaced was o_C_INTEGER
		
		$k:=Find in array:C230(aPeople_ID; [BMS Inspections:44]DBrInspEngr:5)
		If ($k>0)
			vBIE:=aPeople{$k}
		Else 
			vBIE:=""
		End if 
		
		C_TEXT:C284(vTmLeader)  // Command Replaced was o_C_STRING length was 44
		
		$k:=Find in array:C230(aPeople_ID; [BMS Inspections:44]TeamLeader:6)
		If ($k>0)
			vTmLeader:=aPeople{$k}
		Else 
			vTmLeader:=""
		End if 
		
		C_TEXT:C284(vTmMembers)  // Command Replaced was o_C_STRING length was 80
		
		ARRAY INTEGER:C220(aInspTeamID; 0)
		//RELATE MANY([BMS Inspections])
		SELECTION TO ARRAY:C260([BMS Field Trip:56]Person ID:2; aInspTeamID)
		$j:=Size of array:C274(aInspTeamID)
		$i:=1
		vTmMembers:=""
		While ($i<=$j) & (Length:C16(vTmMembers)<50)
			If ($i>1)
				vTmMembers:=vTmMembers+", "
			End if 
			$k:=Find in array:C230(aPeople_ID; aInspTeamID{$i})
			If ($k>0)
				vTmMembers:=vTmMembers+aPeople{$k}
			Else 
				vTmMembers:=vTmMembers+"Invalid Person ID"
			End if 
			$i:=$i+1
		End while 
		
		If ($i<=$j)
			vTmMembers:=vTmMembers+", et al."
		End if 
		
		C_TEXT:C284(vDist)  // Command Replaced was o_C_STRING length was 1
		
		vDist:=String:C10(Num:C11([Bridge MHD NBIS:1]Item2:60))
		
	: ($FormEvent_L=On Printing Detail:K2:18)
		C_LONGINT:C283($formFooter_L; $printed_L; $totalHt; $totalW; $formBreak_L; $FormDetail_L; $break_footer_L; $FormHeader_L)
		$FormHeader_L:=Get print marker:C708(Form header:K43:3)
		$FormDetail_L:=Get print marker:C708(Form detail:K43:1)
		$formBreak_L:=Get print marker:C708(Form break0:K43:14)
		$formFooter_L:=Get print marker:C708(Form footer:K43:2)
		$break_footer_L:=$formFooter_L-$FormDetail_L
		$printed_L:=Get printed height:C702
		GET PRINTABLE AREA:C703($totalHt; $totalW)
		
		Case of 
			: (NTI_PrintSection_txt="Detail")
				READ ONLY:C145([BMS Elements:47])
				READ ONLY:C145([BMS Categories:49])
				QUERY:C277([BMS Elements:47]; [BMS Elements:47]Element ID:1=[Cond Units:45]Element ID:3)
				QUERY:C277([BMS Categories:49]; [BMS Categories:49]Category ID:1=[BMS Elements:47]Category ID:8)
				
				DISPLAY_1CU
				OBJECT SET VISIBLE:C603(*; "CHKLINE@"; [Cond Units:45]Percent:6)
				
				$printed_L:=Get printed height:C702
				//check space left
				//space needed = formFooter-FormHeader
				If (($printed_L+($formFooter_L-$FormHeader_L))>$totalHt)
					CANCEL:C270
				End if 
				
			: (NTI_PrintSection_txt="Header")
				CU_Print_FM(On Load:K2:1)
				CU_Print_FM(On Header:K2:17)
				$printed_L:=Get printed height:C702
				
			: (NTI_PrintSection_txt="Break0")
				SET PRINT MARKER:C709(Form break0:K43:14; $formBreak_L+($totalHt-($printed_L+$break_footer_L)); *)
				
			: (NTI_PrintSection_txt="Footer")
				CU_Print_FM(On Printing Footer:K2:20)
			Else 
				//just do normal detail as if printing selection
				READ ONLY:C145([BMS Elements:47])
				READ ONLY:C145([BMS Categories:49])
				QUERY:C277([BMS Elements:47]; [BMS Elements:47]Element ID:1=[Cond Units:45]Element ID:3)
				QUERY:C277([BMS Categories:49]; [BMS Categories:49]Category ID:1=[BMS Elements:47]Category ID:8)
				DISPLAY_1CU
				OBJECT SET VISIBLE:C603(*; "CHKLINE@"; [Cond Units:45]Percent:6)
				
		End case 
		
	: ($FormEvent_L=On Printing Footer:K2:20)
		vPage:="Page "+String:C10(Printing page:C275)
		
End case 
//End CU_Print_FM