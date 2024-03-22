//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: M_QuickReport
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Jim Steinman
	//Date:  10/1/95
	
	//Purpose: Displays the Quick Report Editor to the user
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	<>fJ_Steinman:=False:C215
	
	Mods_2005_CM10
	// Modified by: Costas Manousakis-(Designer)-(2/10/12 19:37:26)
	Mods_2012_02
	//  `changed auto relations before the QR to true;true from true;false
	// Modified by: Costas Manousakis-(Designer)-(5/21/13 09:46:26)
	Mods_2013_05
	//  `Added sorting at the end
End if 
SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
QR REPORT:C197(pFile->; Char:C90(1); True:C214; False:C215; False:C215)
SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
C_TEXT:C284(GEN_SORTLISTCMD_txt)

If (GEN_SORTLISTCMD_txt#"")
	EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
End if 

//End of procedure