//%attributes = {"invisible":true}
//Method: NTI_Print_CommentsWP_TIN
//Description
// Assemble comments pages and print
// Parameters
// $0 : $pageCount
// $1 : $param_obj
//  .printFlag : boolean   .viewComments : boolean
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/08/21, 17:49:50
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_LONGINT:C283(NTI_Print_CommentsWP_TIN; $0)
	C_OBJECT:C1216(NTI_Print_CommentsWP_TIN; $1)
	
End if 
//
C_LONGINT:C283($0)  //return number of pages printed.

C_BOOLEAN:C305($bGeneral; $bOtherCmts)
C_LONGINT:C283($vAllElmts; $numpages)
C_BOOLEAN:C305(PrintFlag; $bViewAllCmtsFlag)
C_LONGINT:C283(viInspPreviewErr)  // **replaced _ o _C_INTEGER()
C_LONGINT:C283(INSP_PrevElmtParntID)
INSP_PrevElmtParntID:=0

$0:=0  //initialize to zero

C_BOOLEAN:C305($PrintCmts_b; $ShowAllComments_b)
$PrintCmts_b:=True:C214
$ShowAllComments_b:=False:C215
If (Count parameters:C259>0)
	C_OBJECT:C1216($1)
	
	Case of 
		: ($1.printFlag=Null:C1517)
		: (Value type:C1509($1.printFlag)#Is boolean:K8:9)
		Else 
			$PrintCmts_b:=$1.printFlag
	End case 
	Case of 
		: ($1.viewComments=Null:C1517)
		: (Value type:C1509($1.viewComments)#Is boolean:K8:9)
		Else 
			$ShowAllComments_b:=$1.viewComments
	End case 
	
End if 

C_TEXT:C284($vElmTitle)

//create main write pro area
C_OBJECT:C1216($WPArea_)
$WPArea_:=INSP_InitializeWPArea(New object:C1471("templateType"; "Normal"))

C_LONGINT:C283($CommentLoop_L)

For ($CommentLoop_L; 1; Size of array:C274(TINInspCommentTypes_atxt))
	If (TINInspCommentTypes_atxt{$CommentLoop_L}="GENERAL REMARKS")
		If (BLOB size:C605([TIN_Inspections:184]Comments:23)>0)
			
			G_AddElmtTxt2Area_WP($WPArea_; "GENERAL REMARKS"; [TIN_Inspections:184]Comments:23)
			
		End if 
	Else 
		QUERY:C277([TIN_Insp_Comments:188]; [TIN_Insp_Comments:188]InspectionID:1=[TIN_Inspections:184]InspectionID:2; *)
		QUERY:C277([TIN_Insp_Comments:188];  & ; [TIN_Insp_Comments:188]CommentType_s:8=TINInspCommentTypes_atxt{$CommentLoop_L})
		If (TINInspCommentTypes_atxt{$CommentLoop_L}="CAUSE OF DAMAGE")
			//for damge print first the date and damage by
			INSP_AddTextToArea_WP($WPArea_; "DATE OF DAMAGE"; String:C10([TIN_Inspections:184]DamageDate_d:48; Internal date short:K1:7))
			
			INSP_AddTextToArea_WP($WPArea_; "DAMAGE BY"; [TIN_Inspections:184]DamageBy_s:47)
			
		End if 
		If (Records in selection:C76([TIN_Insp_Comments:188])=1) & (BLOB size:C605([TIN_Insp_Comments:188]Comment_blb:9)>0)
			G_AddElmtTxt2Area_WP($WPArea_; TINInspCommentTypes_atxt{$CommentLoop_L}; [TIN_Insp_Comments:188]Comment_blb:9)
			
		End if 
	End if 
	
End for 

vtHeaderLbl:=""
C_LONGINT:C283($i)
For ($i; 1; Records in selection:C76([NTI_ELEM_TIN_INSP:185]))
	//RELATE ONE([ElementsSafety]ElementNo)
	GOTO SELECTED RECORD:C245([NTI_ELEM_TIN_INSP:185]; $i)
	If (BLOB size:C605([NTI_ELEM_TIN_INSP:185]ELEM_NOTES:9)>0)
		QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
		If ([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
			$vElmTitle:=[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5
			QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7)
			$vElmTitle:=[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5+" ("+String:C10([NTI_ELEM_DEFS:182]ELEM_KEY:4)+") - "+$vElmTitle
		Else 
			$vElmTitle:=[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5+" ("+String:C10([NTI_ELEM_DEFS:182]ELEM_KEY:4)+")"
		End if 
		G_AddElmtTxt2Area_WP($WPArea_; $vElmTitle; [NTI_ELEM_TIN_INSP:185]ELEM_NOTES:9)
	End if 
	//NEXT RECORD([NTI_ELEM_TIN_INSP])
End for 

//Build the Sketch/Chart/Photo index

NTI_CreateImageLog_WP($WPArea_)

$numpages:=WP Get page count:C1412($WPArea_)

If ($PrintCmts_b)
	C_TEXT:C284($name_txt)
	$name_txt:=FM_ReturnInspectionTitle
	vPage2Title:=$name_txt+" REMARKS"
	
	NTI_PrintRemarks_WP($WPArea_)
	
End if 

If ($ShowAllComments_b)
	INSP_ViewAllComments_WP($WPArea_)
End if 

$0:=$numpages

//End NTI_Print_CommentsWP_TIN