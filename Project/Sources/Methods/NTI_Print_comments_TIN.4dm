//%attributes = {"invisible":true}
// Method: NTI_Print_comments_TIN
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 05/23/16, 16:54:55
	// ----------------------------------------------------
	// First Release
	Mods_2016_NTE
	C_LONGINT:C283(NTI_Print_comments_TIN; $0)
	C_BOOLEAN:C305(NTI_Print_comments_TIN; $1)
	C_BOOLEAN:C305(NTI_Print_comments_TIN; $2)
	Mods_2018_01  //removed continued from report header
	//Modified by: Chuck Miller (1/16/18 11:32:39)
	Mods_2021_Delete
	
End if 


//C_LONGINT($0)  //num pages
//C_BOOLEAN($PrintCmts_b;$ShowAllComments_b)
//$PrintCmts_b:=True
//$ShowAllComments_b:=False
//If (Count parameters>0)
//C_BOOLEAN($1)
//$PrintCmts_b:=$1
//End if 
//If (Count parameters>1)
//C_BOOLEAN($2)
//$ShowAllComments_b:=$2
//End if 
//C_LONGINT(viInspPreviewErr)  //Command Replaced was o_C_INTEGER
//C_BOOLEAN(vbTopOfPage)  //Indicate Top of page
//C_TEXT($vElmTitle)

//C_LONGINT($mainarea)
//$mainarea:=WR New offscreen area 
//Set Doc Margins ($mainarea)
//vbTopOfPage:=True  //say we start from top of page
//C_LONGINT($i;$numpages;$numnewpages;$viNElmts;$CommentLoop_L)
//C_BOOLEAN($haveWePrinted4DWtite_B)
//$haveWePrinted4DWtite_B:=False
//vbTopOfPage:=True

//For ($CommentLoop_L;1;Size of array(TINInspCommentTypes_atxt))
//If (TINInspCommentTypes_atxt{$CommentLoop_L}="GENERAL REMARKS")
//If (BLOB size([TIN_Inspections]Comments)>0)

//G_AddElmtTxt2Area ($mainarea;"GENERAL REMARKS";[TIN_Inspections]Comments)

//$haveWePrinted4DWtite_B:=True
//vbTopOfPage:=False

//End if 
//Else 
//QUERY([TIN_Insp_Comments];[TIN_Insp_Comments]InspectionID=[TIN_Inspections]InspectionID;*)
//QUERY([TIN_Insp_Comments]; & ;[TIN_Insp_Comments]CommentType_s=TINInspCommentTypes_atxt{$CommentLoop_L})
//If (TINInspCommentTypes_atxt{$CommentLoop_L}="CAUSE OF DAMAGE")
//  //for damge print first the date and damage by
//G_addItemtoWr ($mainarea;"DATE OF DAMAGE";String([TIN_Inspections]DamageDate_d;Internal date short))
//vbTopOfPage:=False  //we have added something to the page

//G_addItemtoWr ($mainarea;"DAMAGE BY";[TIN_Inspections]DamageBy_s)
//$haveWePrinted4DWtite_B:=True
//End if 
//If (Records in selection([TIN_Insp_Comments])=1) & (BLOB size([TIN_Insp_Comments]Comment_blb)>0)
//G_AddElmtTxt2Area ($mainarea;TINInspCommentTypes_atxt{$CommentLoop_L};[TIN_Insp_Comments]Comment_blb)

//$haveWePrinted4DWtite_B:=True
//vbTopOfPage:=False
//End if 
//End if 

//End for 
//  //Add Inspection comments
//  //If (BLOB size([TIN_Inspections]Comments)>0)
//  //G_AddElmtTxt2Area ($mainarea;"General Comments";[TIN_Inspections]Comments)
//  //vbTopOfPage:=False  //we have added something to the page
//  //End if 
//vtHeaderLbl:=""
//  //$viNElmts:=Records in selection([NTI_ELEM_TIN_INSP])
//  //If ($viNElmts>0)

//  //FIRST RECORD([NTI_ELEM_TIN_INSP])
//For ($i;1;Records in selection([NTI_ELEM_TIN_INSP]))
//  //RELATE ONE([ElementsSafety]ElementNo)
//GOTO SELECTED RECORD([NTI_ELEM_TIN_INSP];$i)
//If (BLOB size([NTI_ELEM_TIN_INSP]ELEM_NOTES)>0)
//QUERY([NTI_ELEM_DEFS];[NTI_ELEM_DEFS]ELEM_KEY=[NTI_ELEM_TIN_INSP]ELEM_KEY)
//If ([NTI_ELEM_DEFS]DEFECTFLAG="Y")
//$vElmTitle:=[NTI_ELEM_DEFS]ELEM_LONGNAME
//QUERY([NTI_ELEM_DEFS];[NTI_ELEM_DEFS]ELEM_KEY=[NTI_ELEM_TIN_INSP]ELEM_PARENT_KEY)
//$vElmTitle:=[NTI_ELEM_DEFS]ELEM_LONGNAME+" ("+String([NTI_ELEM_DEFS]ELEM_KEY)+") - "+$vElmTitle
//Else 
//$vElmTitle:=[NTI_ELEM_DEFS]ELEM_LONGNAME+" ("+String([NTI_ELEM_DEFS]ELEM_KEY)+")"
//End if 
//G_AddElmtTxt2Area ($mainarea;$vElmTitle;[NTI_ELEM_TIN_INSP]ELEM_NOTES)
//vbTopOfPage:=False  //we have added something to the page
//End if 
//  //NEXT RECORD([NTI_ELEM_TIN_INSP])
//End for 

//  //End if 

//  //Build the Sketch/Chart/Photo index

//NTI_CreateImageLog ($mainarea)

//$numpages:=WR Count ($mainarea;wr nb pages)
//$numnewpages:=$numpages
//While ($numnewpages=$numpages)
//WR INSERT TEXT ($mainarea;<>sCR)
//$numnewpages:=WR Count ($mainarea;wr nb pages)
//End while 
//  //maybe we do maybe we dont't know why we do not need to delete the last line feed
//WR BACKSPACE ($mainarea)
//$numpages:=WR Count ($mainarea;wr nb pages)

//If ($PrintCmts_b)
//C_TEXT($name_txt)
//$name_txt:=FM_ReturnInspectionTitle 
//C_PICTURE(CommentsPrevw_P)
//For ($i;1;$numpages)

//vPage2Title:=$name_txt+" REMARKS"

//CommentsPrevw_P:=WR Build preview ($mainarea;$i)
//PAGE BREAK(>)
//C_LONGINT($printht)
//$printht:=Print form([TIN_Inspections];"CmtsPrint")
//If (viInspPreviewErr#0)
//  //exit if preview error
//$i:=$numpages+1
//End if 

//End for 
//CommentsPrevw_P:=CommentsPrevw_P*0

//End if 

//If ($ShowAllComments_b)
//INSP_ViewAllComments ($mainarea)  //MODS_XXXX_CM
//End if 

//WR DELETE OFFSCREEN AREA ($mainarea)

//$0:=$numpages

//  //End NTI_Print_comments_BIN