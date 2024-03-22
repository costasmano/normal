//%attributes = {"invisible":true}
//Method: NTI_SaveandUpdateComments
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/21/17, 16:35:41
	// ----------------------------------------------------
	//Created : 
	Mods_2017_12
	// Modified by: Costas Manousakis-(Designer)-(7/5/18 12:29:42)
	Mods_2018_07_bug
	//  `change stack level to 1 when doing GENERAL REMARKS and relation type in FlushGrpChags is 2 (was 1)
	Mods_2021_Delete
	
End if 
//  //
//C_BOOLEAN($FromDropDown_B)
//$FromDropDown_B:=False
//C_LONGINT($mod_L)

//If (Count parameters=1)
//C_BOOLEAN($1)
//$FromDropDown_B:=$1
//End if 
//If (TINInspCommentTypes_atxt{0}="GENERAL REMARKS")
//$mod_L:=PON_ChangeStackLvl_L
//PON_ChangeStackLvl_L:=1  // stack is 1 for [tin_inspections]

//NTI_ElmtRemarksArea (->[TIN_Inspections]Comments;AreaGeneralRemarks;On Losing Focus)
//PON_ChangeStackLvl_L:=$mod_L

//Else 
//C_TEXT($vsStrValue)
//WR GET AREA PROPERTY (AreaGeneralRemarks;wr modified;$mod_L;$vsStrValue)
//If ($mod_L=1)
//C_LONGINT($Count_L)
//$Count_L:=WR Count (AreaGeneralRemarks;wr nb characters)

//$mod_L:=PON_ChangeStackLvl_L
//PON_ChangeStackLvl_L:=3
//If (Records in selection([TIN_Insp_Comments])=0)
//If ($Count_L>0)
//CREATE RECORD([TIN_Insp_Comments])
//[TIN_Insp_Comments]InspectionID:=[TIN_Inspections]InspectionID
//[TIN_Insp_Comments]ISOCreatedDate_s:=ISODateTime (Current date;Current time)
//[TIN_Insp_Comments]CreatedBy_s:=Current user
//[TIN_Insp_Comments]CommentType_s:=TINInspCommentTypes_atxt{0}
//Inc_Sequence ("TIN_Insp_Comments";->[TIN_Insp_Comments]TIN_InspCommentID_L)
//LogNewRecord (->[TIN_Inspections]InspectionID;->[TIN_Insp_Comments]InspectionID;->[TIN_Insp_Comments]TIN_InspCommentID_L;2;"TIN_Insp_Comments")
//End if 

//Else 
//If ($Count_L>0)
//[TIN_Insp_Comments]ISOModifiedDate_s:=ISODateTime (Current date;Current time)
//[TIN_Insp_Comments]ModifiedBy_s:=Current user
//Else 
//LogDeletion (->[TIN_Inspections]InspectionID;->[TIN_Insp_Comments]InspectionID;->[TIN_Insp_Comments]TIN_InspCommentID_L;2)
//DELETE RECORD([TIN_Insp_Comments])
//WR EXECUTE COMMAND (AreaGeneralRemarks;wr cmd clear)
//End if 
//End if 
//If ($Count_L>0)
//ARRAY TEXT($Fieldstoskip_atxt;0)
//APPEND TO ARRAY($Fieldstoskip_atxt;Field name(->[TIN_Insp_Comments]TIN_InspCommentID_L))
//APPEND TO ARRAY($Fieldstoskip_atxt;Field name(->[TIN_Insp_Comments]TIN_INSP_CommentsUUIDKey_S))
//APPEND TO ARRAY($Fieldstoskip_atxt;Field name(->[TIN_Insp_Comments]InspectionID))
//INSP_4DWRITE_SaveToFld (AreaGeneralRemarks;->[TIN_Insp_Comments]Comment_blb;3)

//ACT_PushGroupChanges (Table(->[TIN_Insp_Comments]);3;->$Fieldstoskip_atxt)
//FlushGrpChgs (3;->[TIN_Inspections]InspectionID;->[TIN_Insp_Comments]InspectionID;->[TIN_Insp_Comments]TIN_InspCommentID_L;2)

//SAVE RECORD([TIN_Insp_Comments])

//End if 
//  //TINInspCommentTypes_atxt{0}:=TINInspCommentTypes_atxt{TINInspCommentTypes_atxt}

//PON_ChangeStackLvl_L:=$mod_L
//End if 
//End if 
//If ($FromDropDown_B)
//If (TINInspCommentTypes_atxt{TINInspCommentTypes_atxt}="GENERAL REMARKS")
//$mod_L:=PON_ChangeStackLvl_L
//PON_ChangeStackLvl_L:=1  // stack is 1 for [tin_inspections]

//NTI_ElmtRemarksArea (->[TIN_Inspections]Comments;AreaGeneralRemarks;On Load)
//PON_ChangeStackLvl_L:=$mod_L

//Else 
//QUERY([TIN_Insp_Comments];[TIN_Insp_Comments]InspectionID=[TIN_Inspections]InspectionID;*)
//QUERY([TIN_Insp_Comments]; & ;[TIN_Insp_Comments]CommentType_s=TINInspCommentTypes_atxt{TINInspCommentTypes_atxt})
//If (ut_LoadRecord (->[TIN_Insp_Comments];5))
//NTI_ElmtRemarksArea (->[TIN_Insp_Comments]Comment_blb;AreaGeneralRemarks;On Load)
//  //TINInspCommentTypes_atxt{0}:=TINInspCommentTypes_atxt{TINInspCommentTypes_atxt}

//Else 
//ALERT("Could not load [TIN_Insp_Comments] record")
//End if 

//End if 
//REDRAW(AreaGeneralRemarks)
//End if 
//  //End NTI_SaveandUpdateComments