//%attributes = {"invisible":true}
If (False:C215)
	//G_Insp_ViewAllCmts.
	//Handle calls from button bViewAllCmts on inspection Forms
	
	Mods_2004_CM12
	
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 14:00:59
	
	// Modified by: Costas Manousakis-(Designer)-(1/28/21 14:51:55)
	Mods_2021_WP
	//  `Write Pro
	// Modified by: Costas Manousakis-(Designer)-(2021-12-29 12:04:41)
	Mods_2021_12_bug
	//  `call INSP_SaveInspCommts
End if 

INSP_SaveInspCommts

C_LONGINT:C283($vlNumCmtPgs)
COPY NAMED SELECTION:C331([Standard Photos:36]; "StandardPhotosInUse")
//False = PrintFlag; True = bViewAllComtsFlag
C_OBJECT:C1216($params_o)
$params_o:=New object:C1471("printFlag"; False:C215; "viewComments"; True:C214)
Case of 
	: ([Inspections:27]Insp Type:6="RT@")
		$vlNumCmtPgs:=Print_RTN_Cmts_WP($params_o)
	: ([Inspections:27]Insp Type:6="CUL")
		$vlNumCmtPgs:=Print_CUL_Cmts_WP($params_o)
	Else 
		$vlNumCmtPgs:=INSP_PrintComments_WP($params_o)
		
End case 

USE NAMED SELECTION:C332("StandardPhotosInUse")
CLEAR NAMED SELECTION:C333("StandardPhotosInUse")

If ($vlNumCmtPgs=0)
	ALERT:C41("There are no Comments for this Inspection")
End if 