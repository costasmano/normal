//%attributes = {"invisible":true}
//M_WRT_BrInspRpt
//````````` Used to create "Bridge Inspection Report" Memo and Letter
//````````` (For multiple bridges)
//````````` $1:  name of the 4D Write template to open
//````````` $2:  Retrieve town address
If (False:C215)
	//``````````````````````````````````````````````````````````````````````````
	//````````` SJH  1/29/2004
	//``````````````````````````````````````````````````````````````````````````
	// Modified by: costasmanousakis-(Designer)-(1/17/2007 15:14:44)
	Mods_2007_CM04
	Mods_2011_06  //r002 CJ Miller`06/03/11, 16:11:27      `Make vDistrict alpha 2
	// Modified by: Costas Manousakis-(Designer)-(6/22/21 15:45:12)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2022-04-20 18:01:01)
	Mods_2022_04
	//  `make [Templates] Read only
End if 

C_TEXT:C284($1; $sTemplateName)  // Command Replaced was o_C_STRING length was 80
C_BOOLEAN:C305($2; $bTownLetter)

$sTemplateName:=$1
$bTownLetter:=$2

C_TEXT:C284(vPlural)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vPluralCopy)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284(vDistrict)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284(vContactName; vTownName; vAddressedTo; vAddress1; vAddress2; vOfficialTownName)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vLastName)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vAssignmentList)
C_DATE:C307(vToday)
C_LONGINT:C283($i; vAssignNo)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Recs)
C_TEXT:C284($BDept)  // Command Replaced was o_C_STRING length was 20
C_BOOLEAN:C305($bCreateLetter)
C_TEXT:C284($district)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($town)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284($Item6; $Item7)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vWriterInitial)  // Command Replaced was o_C_STRING length was 30
C_TEXT:C284(vDBIEInitial)  // Command Replaced was o_C_STRING length was 4

//multiple bridges
$Recs:=Records in set:C195("UserSet")

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
	
	COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "PrePrintBrgList")
	USE SET:C118("UserSet")
	$sTemplateName:=WP_4WRTemplNameToWP($sTemplateName)
	READ ONLY:C145([Templates:86])
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2=$sTemplateName)
	If (Records in selection:C76([Templates:86])=0)
		//  If ($mypath="")      
		ALERT:C41("Document template "+$sTemplateName+" does not exist!")
		
	Else 
		
		vToday:=Current date:C33(*)
		vAssignmentList:=""
		vWriterInitial:="ENTER_WRITER_INITIAL"
		
		FIRST RECORD:C50([Bridge MHD NBIS:1])
		For ($i; 1; $Recs)
			$town:=[Bridge MHD NBIS:1]Town Name:175
			$district:=Substring:C12([Bridge MHD NBIS:1]Item2:60; 2; 1)
			$BDept:=Insert string:C231([Bridge MHD NBIS:1]BDEPT:1; "-"; 2)
			$BDept:=Insert string:C231($BDept; "-"; 5)
			$Item6:=F_RemoveFeatIntCode([Bridge MHD NBIS:1]Item6A:63)
			$Item7:=F_RemoveFeatIntCode([Bridge MHD NBIS:1]Item7:65)
			If ($bTownLetter)
				vAssignmentList:=vAssignmentList+<>sTab+$BDept+<>sTab+"("+[Bridge MHD NBIS:1]BIN:3+")"+<>sTab+$Item7+" / "+$Item6+<>sCR
			Else 
				vAssignmentList:=vAssignmentList+$BDept+<>sTab+"("+[Bridge MHD NBIS:1]BIN:3+")"+<>sTab+$Item7+" / "+$Item6+<>sCR
			End if 
			NEXT RECORD:C51([Bridge MHD NBIS:1])
		End for 
		
		vDistrict:=$district
		GetDBIEinfo($district)
		vWriterInitial:=vDBIEinitial+"/"+Lowercase:C14(vDBIEinitial)
		GetDHDinfo($district)
		
		If ($bTownLetter)
			//This applies to only letter and not to memo      
			vContactName:="Contact_Name"
			vTownName:="Town_Name"
			vAddressedTo:="Addressed_To"
			vAddress1:="Address_Line_1"
			vAddress2:="Address_Line_2"
			GetTownAddress($town)
			GetBridgeEngineer
			If ($Recs>1)
				vPlural:="s"
				vPluralCopy:="are copies"
			Else 
				vPlural:=""
				vPluralCopy:="is a copy"
			End if 
		End if 
		
		//````4D WR commands
		G_WP_MakeDocument
		
	End if 
	USE NAMED SELECTION:C332("PrePrintBrgList")
	CLEAR NAMED SELECTION:C333("PrePrintBrgList")
	HIGHLIGHT RECORDS:C656("UserSet")
	REDRAW WINDOW:C456
End if   //matches If ($bCreateLetter=True)