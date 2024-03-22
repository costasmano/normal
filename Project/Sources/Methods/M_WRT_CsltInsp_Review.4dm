//%attributes = {"invisible":true}
If (False:C215)
	//M_WRT_CsltInsp_Review 
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(10/12/2005 15:09:51)
	Mods_2005_CM17
	// Modified by: costasmanousakis-(Designer)-(8/31/2006 15:25:42)
	Mods_2006_CM06
	// Modified by: costasmanousakis-(Designer)-(9/26/11 15:28:44)
	Mods_2011_09
	//  `Use the new variable AreaBIEDistricts_txt from GetAreaBIEinfo
	// Modified by: Costas Manousakis-(Designer)-(6/22/21 15:45:12)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2022-04-20 18:01:01)
	Mods_2022_04
	//  `make [Templates] Read only
End if 

C_TEXT:C284(vPlural)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vPluralVerb)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($District)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vToInspEngineer; vThroughInspEngineer; vFromInspEngineer; vCompanyName)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284($mypath; vAssignmentList)
C_DATE:C307(vRptToDBIEdate)
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Recs)
C_TEXT:C284($BDept)  // Command Replaced was o_C_STRING length was 20
C_BOOLEAN:C305($bCreateLetter)

//for multiple bridges
$Recs:=Records in selection:C76([Cons Inspection:64])

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

ARRAY TEXT:C222($arr_InspResp_s; 0)  //Command Replaced was o_ARRAY string length was 5
READ ONLY:C145([Bridge MHD NBIS:1])
READ ONLY:C145([Cons Inspection:64])
READ ONLY:C145([Templates:86])
RELATE ONE SELECTION:C349([Cons Inspection:64]; [Bridge MHD NBIS:1])
DISTINCT VALUES:C339([Bridge MHD NBIS:1]InspResp:173; $arr_InspResp_s)
If (Size of array:C274($arr_InspResp_s)>1)
	ALERT:C41("There are multiple ("+String:C10(Size of array:C274($arr_InspResp_s))+") Districts in the selected list of inspections! This letter is applicable only f"+"or a single District")
	$bCreateLetter:=False:C215
End if 

If ($bCreateLetter=True:C214)
	
	COPY NAMED SELECTION:C331([Cons Inspection:64]; "PrePrintBrgList")
	
	READ ONLY:C145([Templates:86])
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WPtemplate_CsltInsp_Review")
	If (Records in selection:C76([Templates:86])=0)
		
		ALERT:C41("Document template does not exist!")
		
	Else 
		
		vToInspEngineer:=""
		vThroughInspEngineer:=""
		vFromInspEngineer:=""
		vCompanyName:="Company_Name"
		vToday:=Current date:C33(*)
		
		If ($Recs>1)
			vPlural:="s"
			vPluralVerb:="are"
		Else 
			vPlural:=""
			vPluralVerb:="is"
		End if 
		
		vAssignmentList:=""
		FIRST RECORD:C50([Cons Inspection:64])
		vCompanyName:=[Cons Inspection:64]AssignConName:5
		C_TEXT:C284($ErrMsg_txt; $BINErrMsg_txt)
		$BINErrMsg_txt:=""
		For ($i; 1; $Recs)
			$BINErrMsg_txt:=""
			RELATE ONE:C42([Cons Inspection:64]BIN:1)
			vRptToDBIEdate:=[Cons Inspection:64]ReportToDBIE:31
			$District:=Substring:C12([Bridge MHD NBIS:1]Item2:60; 2; 1)
			$BDept:=Insert string:C231([Bridge MHD NBIS:1]BDEPT:1; "-"; 2)
			$BDept:=Insert string:C231($BDept; "-"; 5)
			vAssignmentList:=vAssignmentList+$BDept+<>sTab+[Cons Inspection:64]BIN:1+<>sTab+<>sTab+[Cons Inspection:64]ConContractNo:7+" / "+String:C10([Cons Inspection:64]AssignConNumber:6)+<>sTab+<>sTab
			vAssignmentList:=vAssignmentList+[Cons Inspection:64]InspectionDate:28+<>sTab+<>sTab+String:C10([Cons Inspection:64]InspectionRecvd:29; Internal date short:K1:7)
			vAssignmentList:=vAssignmentList+<>sTab+<>sTab+<>sTab+"________"+<>sCR
			If ([Cons Inspection:64]InspectionDate:28="")
				$BINErrMsg_txt:="Blank Insp Date!"
			End if 
			If ([Cons Inspection:64]InspectionRecvd:29=!00-00-00!)
				$BINErrMsg_txt:=$BINErrMsg_txt+f_Boolean2String(($BINErrMsg_txt#""); ",")+"Blank Insp Received Date!"
			End if 
			If ($BINErrMsg_txt#"")
				$ErrMsg_txt:=$ErrMsg_txt+"BIN :"+[Cons Inspection:64]BIN:1+" Error(s) : "+$BINErrMsg_txt+<>sCR
			End if 
			
			NEXT RECORD:C51([Cons Inspection:64])
		End for 
		C_BOOLEAN:C305($vGenerateLtr_b)
		$vGenerateLtr_b:=True:C214
		If ($ErrMsg_txt#"")
			G_MyConfirm("Errors Found!"+<>sCR+$ErrMsg_txt+"Continue with creating the letter for District "+$District+"?"; "Continue")
			If (OK#1)
				$vGenerateLtr_b:=False:C215
			End if 
		End if 
		
		$BINErrMsg_txt:=""
		$ErrMsg_txt:=""
		If ($vGenerateLtr_b)
			//```````````````````````````````````````````````````````````````       
			GetDBIEinfo($District)
			If (vDBIEsuffix="")
				vToInspEngineer:=vDBIEname+", "+" District "+$District+" Bridge Inspection Engineer"
			Else 
				vToInspEngineer:=vDBIEname+vDBIEsuffix+",  District "+$District+" Bridge Inspection Engineer"
			End if 
			//```````````````````````````````````````````````````````````````    
			GetAreaBIEinfo($District)
			C_TEXT:C284($sAreaDistricts)  // Command Replaced was o_C_STRING length was 40
			If (($District="1") | ($District="2") | ($District="5"))
				$sAreaDistricts:="District 1, 2 & 5"
			Else 
				$sAreaDistricts:="District 3, 4 & 6"
			End if 
			$sAreaDistricts:="District "+AreaBIEDistricts_txt
			vThroughInspEngineer:=vAreaBIEname+", "+$sAreaDistricts+" Area Bridge Inspection Engineer"
			//```````````````````````````````````````````````````````````````       
			GetBIEinfo
			vFromInspEngineer:=vBIEname+vBIEsuffix+", Bridge Inspection Engineer"
			C_TEXT:C284(vWriterInitial)  // Command Replaced was o_C_STRING length was 30
			vWriterInitial:=vBIEinitial+"/"+Lowercase:C14(vBIEinitial)
			
			//````4D WR commands
			G_WP_MakeDocument
			
		End if 
		
	End if 
	USE NAMED SELECTION:C332("PrePrintBrgList")
	CLEAR NAMED SELECTION:C333("PrePrintBrgList")
	HIGHLIGHT RECORDS:C656("UserSet")
	REDRAW WINDOW:C456
End if   //matches If ($bCreateLetter=True)

READ WRITE:C146([Bridge MHD NBIS:1])
READ WRITE:C146([Cons Inspection:64])