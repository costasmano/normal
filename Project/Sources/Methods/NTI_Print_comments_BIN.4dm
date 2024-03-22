//%attributes = {"invisible":true}
//Method: NTI_Print_comments_BIN
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/20/16, 15:00:37
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	C_LONGINT:C283(NTI_Print_comments_BIN; $0)
	Mods_2021_Delete
End if 
//

//C_LONGINT($0)  //num pages
//C_LONGINT(viInspPreviewErr)  //Command Replaced was o_C_INTEGER
//C_BOOLEAN(vbTopOfPage)  //Indicate Top of page
//C_TEXT($vElmTitle)
//C_LONGINT($mainarea)
//$mainarea:=WR New offscreen area 
//Set Doc Margins ($mainarea)
//vbTopOfPage:=True  //say we start from top of page
//C_LONGINT($i;$numpages;$numnewpages;$viNElmts)

//$viNElmts:=Records in selection([NTI_ELEM_BIN_INSP])
//If ($viNElmts>0)

//FIRST RECORD([NTI_ELEM_BIN_INSP])
//For ($i;1;$viNElmts)
//  //RELATE ONE([ElementsSafety]ElementNo)

//If (BLOB size([NTI_ELEM_BIN_INSP]ELEM_NOTES)>0)
//QUERY([NTI_ELEM_DEFS];[NTI_ELEM_DEFS]ELEM_KEY=[NTI_ELEM_BIN_INSP]ELEM_KEY)
//If ([NTI_ELEM_DEFS]DEFECTFLAG="Y")
//$vElmTitle:=[NTI_ELEM_DEFS]ELEM_LONGNAME
//QUERY([NTI_ELEM_DEFS];[NTI_ELEM_DEFS]ELEM_KEY=[NTI_ELEM_BIN_INSP]ELEM_PARENT_KEY)
//$vElmTitle:=[NTI_ELEM_DEFS]ELEM_LONGNAME+" ("+String([NTI_ELEM_DEFS]ELEM_KEY)+") - "+$vElmTitle
//Else 
//$vElmTitle:=[NTI_ELEM_DEFS]ELEM_LONGNAME+" ("+String([NTI_ELEM_DEFS]ELEM_KEY)+")"
//End if 
//G_AddElmtTxt2Area ($mainarea;$vElmTitle;[NTI_ELEM_BIN_INSP]ELEM_NOTES)
//vbTopOfPage:=False  //we have added something to the page
//End if 
//NEXT RECORD([NTI_ELEM_BIN_INSP])
//End for 
//End if 

//$numpages:=WR Count ($mainarea;wr nb pages)
//$numnewpages:=$numpages
//While ($numnewpages=$numpages)
//WR INSERT TEXT ($mainarea;<>sCR)
//$numnewpages:=WR Count ($mainarea;wr nb pages)
//End while 
//  //maybe we do maybe we dont't know why we do not need to delete the last line feed
//WR BACKSPACE ($mainarea)
//$numpages:=WR Count ($mainarea;wr nb pages)

//C_PICTURE(CommentsPrevw_P)
//For ($i;1;$numpages)
//CommentsPrevw_P:=WR Build preview ($mainarea;$i)
//PAGE BREAK(>)
//C_LONGINT($printht)
//$printht:=Print form([Inspections];"NTECmtsPrint")
//If (viInspPreviewErr#0)
//  //exit if preview error
//$i:=$numpages+1
//End if 

//End for 
//CommentsPrevw_P:=CommentsPrevw_P*0

//$0:=$numpages

//WR DELETE OFFSCREEN AREA ($mainarea)
//  //End NTI_Print_comments_BIN