//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/09/06, 22:39:56
	// ----------------------------------------------------
	// Method: CM_PrintExtTimeLetter
	// Description
	// Print the extension time Letter for a contract extension
	// in Contract Mgmt module
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMz1
	// Modified by: costasmanousakis-(Designer)-(3/1/2007 09:10:22)
	Mods_2007_CM07
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(6/22/21 15:45:12)
	Mods_2021_WP
	//  `
End if 
C_TEXT:C284(vWriterInitial)  // Command Replaced was o_C_STRING length was 30
C_TEXT:C284($mypath)
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Recs)
C_TEXT:C284($BDept)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284($sTemplateName)
$sTemplateName:="WRP_CM_ExtTimeLetter"
READ ONLY:C145([Templates:86])
QUERY:C277([Templates:86]; [Templates:86]TemplateName:2=$sTemplateName)
If (Records in selection:C76([Templates:86])=0)
	//  If ($mypath="")      
	ALERT:C41("Document template "+$sTemplateName+"does not exist!")
Else 
	[ExtendTime_Maintenance:98]DateDocSentToContracts:4:=Current date:C33(*)
	
	CM_GetPersonnelData
	GetBridgeEngineer
	
	G_WP_MakeDocument
	
End if 
READ WRITE:C146([Templates:86])