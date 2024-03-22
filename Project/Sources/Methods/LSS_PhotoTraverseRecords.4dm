//%attributes = {"invisible":true}
//Method: LSS_PhotoTraverseRecords
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/05/18, 12:58:52
	// ----------------------------------------------------
	//Created : 
	Mods_2018_06_bug  //Make changes to [LSS_Photos] input to try and fix problems with blank [Activity Log] records
	//Modified by: Chuck Miller (6/5/18 15:10:36)
End if 
//
C_LONGINT:C283($Choice_L)
GOTO SELECTED RECORD:C245([LSS_Photos:166]; LSS_SelectedRow_L)

If (LSS_AllowInspectionEdit_B)
	$Choice_L:=ut_LoadRecordInteractiveV2(->[LSS_Photos:166])
Else 
	$Choice_L:=2
End if 



FM_PhotoInput(On Load:K2:1)
//OBJECT SET ENTERABLE(*;"bValidate@";Not($Choice_L=2))
//OBJECT SET ENTERABLE(*;"bDelete@";Not($Choice_L=2))
//OBJECT SET ENTERABLE(*;"bLast@";Not($Choice_L=2))
//OBJECT SET ENTERABLE(*;"bFirst@";Not($Choice_L=2))
//OBJECT SET ENTERABLE(*;"bPrevious@";Not($Choice_L=2))
//OBJECT SET ENTERABLE(*;"bNext@";Not($Choice_L=2))


//End LSS_PhotoTraverseRecords