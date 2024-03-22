//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/25/06, 14:27:18
	// ----------------------------------------------------
	// Method: M_WRT_CsltRating_Compl_DPM
	// Description
	// Create a letter to the director of project management for 
	// the completion of ratings
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM04
	// Modified by: Costas Manousakis-(Designer)-(6/22/21 15:45:12)
	Mods_2021_WP
	//  `
End if 
C_TEXT:C284(vContractNo)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284(vContactName; vAddress1; vAddress2)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vCompanyName)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vLastName)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vDirectCostList)
C_TEXT:C284($BDept)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284($mypath; vAssignmentList)
C_DATE:C307(vToday; vFeePropReceived)
C_LONGINT:C283($i; vAssignNo)  //Command Replaced was o_C_INTEGER
C_REAL:C285(vDirectSalary; vDirectCostTotal)
C_LONGINT:C283($Recs)
C_BOOLEAN:C305($bCreateLetter)
C_TEXT:C284(vPlural; vPlural_Cons)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vPlural_have; vPlural_is)  // Command Replaced was o_C_STRING length was 5

//for multiple bridges
//$Recs:=Records in set("UserSet")
$Recs:=Records in selection:C76([Conslt Rating:63])

If ($Recs>20)
	CONFIRM:C162("Are you sure you want to include all the selected bridges in the letter?"; "Yes"; "No")
	If (Ok=1)
		$bCreateLetter:=True:C214
	Else 
		$bCreateLetter:=False:C215
	End if 
Else 
	$bCreateLetter:=($Recs>0)
End if 

If ($bCreateLetter=True:C214)
	
	READ ONLY:C145([Templates:86])
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WPTemplate_CsltRtg_ComplDPM")
	If (Records in selection:C76([Templates:86])=0)
		//  If ($mypath="")      
		ALERT:C41("Document template does not exist!")
		
	Else 
		vToday:=Current date:C33(*)
		vAssignmentList:=""
		
		If ($Recs>1)
			vPlural:="s"
			vPlural_have:="have"
			vPlural_is:="are"
		Else 
			vPlural:=""
			vPlural_have:="has"
			vPlural_is:="is"
		End if 
		
		READ ONLY:C145([Conslt Rating:63])
		UNLOAD RECORD:C212([Conslt Rating:63])
		vPlural_Cons:=""
		
		If (False:C215)
			For ($i; 1; $Recs)
				GOTO SELECTED RECORD:C245([Conslt Rating:63]; $i)
				LOAD RECORD:C52([Conslt Rating:63])
				RELATE ONE:C42([Conslt Rating:63]BIN:1)
				$BDept:=Insert string:C231([Bridge MHD NBIS:1]BDEPT:1; "-"; 2)
				$BDept:=Insert string:C231($BDept; "-"; 5)
				vAssignmentList:=vAssignmentList+[Bridge MHD NBIS:1]Town Name:175+<>sTab
				vAssignmentList:=vAssignmentList+$BDept+<>sTab+[Conslt Rating:63]BIN:1
				vAssignmentList:=vAssignmentList+<>sTab+Substring:C12([Bridge MHD NBIS:1]Item2:60; 2; 1)
				vAssignmentList:=vAssignmentList+<>sTab+[Conslt Rating:63]AssignRatCons:5
				vAssignmentList:=vAssignmentList+<>sCR
				
			End for 
		Else 
			ARRAY TEXT:C222($Bdept_ar_s; 0)  //Command Replaced was o_ARRAY string length was 6
			ARRAY TEXT:C222($BINS_ar_s; 0)  //Command Replaced was o_ARRAY string length was 3
			ARRAY TEXT:C222($aItem2_ar_s; 0)  //Command Replaced was o_ARRAY string length was 2
			ARRAY TEXT:C222($aTwnName_ar_s; 0)  //Command Replaced was o_ARRAY string length was 80
			ARRAY TEXT:C222($aConsName_ar_s; 0)  //Command Replaced was o_ARRAY string length was 80
			SELECTION TO ARRAY:C260([Conslt Rating:63]BIN:1; $BINS_ar_s; [Conslt Rating:63]AssignRatCons:5; $aConsName_ar_s; [Bridge MHD NBIS:1]BDEPT:1; $Bdept_ar_s; [Bridge MHD NBIS:1]Item2:60; $aItem2_ar_s; [Bridge MHD NBIS:1]Town Name:175; $aTwnName_ar_s)
			For ($i; 1; $Recs)
				$BDept:=Insert string:C231($Bdept_ar_s{$i}; "-"; 2)
				$BDept:=Insert string:C231($BDept; "-"; 5)
				vAssignmentList:=vAssignmentList+$aTwnName_ar_s{$i}+<>sTab
				vAssignmentList:=vAssignmentList+$BDept+<>sTab+$BINS_ar_s{$i}
				vAssignmentList:=vAssignmentList+<>sTab+Substring:C12($aItem2_ar_s{$i}; 2; 1)
				vAssignmentList:=vAssignmentList+<>sTab+$aConsName_ar_s{$i}
				vAssignmentList:=vAssignmentList+<>sCR
				If ($i>1)
					If ($aConsName_ar_s{$i}#$aConsName_ar_s{($i-1)})
						vPlural_Cons:="s"
					End if 
					
				End if 
				
			End for 
			
		End if 
		
		READ WRITE:C146([Conslt Rating:63])
		C_TEXT:C284(vWriterInitial)  // Command Replaced was o_C_STRING length was 30
		GetBIEinfo
		GetBridgeEngineer
		GetPersonInfo_DPM
		GetPersonInfo_CREng
		GetPersonInfo_IHEng
		vWriterInitial:=vBIEInitial+"/"+Lowercase:C14(vBIEInitial)
		
		//````4D WR commands
		G_WP_MakeDocument
		vAssignmentList:=""
		
	End if 
	
End if   //matches If ($bCreateLetter=True)