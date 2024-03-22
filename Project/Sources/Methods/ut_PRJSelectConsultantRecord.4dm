//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJSelectConsultantRecord
// User name (OS): cjmiller
// Date and time: 11/30/06, 10:50:31
// ----------------------------------------------------
// Description
// This method will control selection of project manager
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJMv2  //04/30/07, 12:00:48`Fix compiler errors
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_BOOLEAN:C305($DoNothing_b; $CreateConslt_NameRecord_b)
$DoNothing_b:=False:C215
$CreateConslt_NameRecord_b:=True:C214
C_LONGINT:C283($Width_l; $Height_l)
FORM GET PROPERTIES:C674([Conslt_Name:127]; "PRJ_Selection.o"; $Width_l; $Height_l)
ORDER BY:C49([Conslt_Name:127]; [Conslt_Name:127]ConsultantName_s:2; >)

NewWindow($Width_l; 700; 0; 0; "Project Details")
PRJ_DetailInfo_txt:="Design Contract Number is "+String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)+Char:C90(Carriage return:K15:38)

If (Records in selection:C76([PRJ_ProjectFile:117])=1)
	PRJ_DetailInfo_txt:=PRJ_DetailInfo_txt+"Project File Number is "+String:C10([PRJ_ProjectFile:117]PF_FileNumber_l:3)+Char:C90(Carriage return:K15:38)
End if 

FORM SET OUTPUT:C54([Conslt_Name:127]; "PRJ_Selection.o")
FORM SET INPUT:C55([Conslt_Name:127]; "PRJ_Empty")
MODIFY SELECTION:C204([Conslt_Name:127]; *)
CLOSE WINDOW:C154


//End ut_PRJSelectConsultantRecord