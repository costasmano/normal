//%attributes = {"invisible":true}
//Method: LSS_AddAddtlCmnts
//Description
// print the Additional Comments field;
// copy from LSS_AddHeader
// Parameters
// $1 : $CommentArea_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/19/16, 10:12:17
	// ----------------------------------------------------
	//Created : 
	Mods_2016_02_bug
	
	C_LONGINT:C283(LSS_AddAddtlCmnts; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(2/23/21 11:43:46)
	Mods_2021_02
	//  `adjusted logic of prepending carriage returns - add only one line when damage inspection , two otherwise
	Mods_2021_Delete
End if 
//  //
//C_LONGINT($1)
//C_LONGINT($i;$StartPages_L;$vlStartSel;$CommentArea_L;$StartSelection_L;$EndSelection_L;$PagesAfterInsert_L;$vlCol;$vlLine;$vlPos;$Loop_L)
//$CommentArea_L:=$1
//C_TEXT($TextToAdd_txt)
//$TextToAdd_txt:=Uppercase("Additional Comments")

//C_BOOLEAN($InHeader_B)
//$InHeader_B:=False
//$StartPages_L:=WR Count ($CommentArea_L;wr nb pages)  //$StartPages_L : page count at start
//WR GET SELECTION ($CommentArea_L;$StartSelection_L;$EndSelection_L)  //$vlStartSel := gets where we are at start - at the end of the text inserted before.
//WR GET CURSOR POSITION ($CommentArea_L;$StartPages_L;$vlCol;$vlLine;$vlPos)

//If ($InHeader_B)
//If (Not(vbTopOfPage))  //if at top of page no need to add lines
//WR INSERT TEXT ($CommentArea_L;<>sCR)
//G_ApplySheet ($CommentArea_L;1)
//WR GET CURSOR POSITION ($CommentArea_L;$PagesAfterInsert_L;$vlCol;$vlLine;$vlPos)  //check if we went to next page 
//$i:=0
//If ($PagesAfterInsert_L=$StartPages_L)
//  //if still on same page then add one more linefeed  
//WR INSERT TEXT ($CommentArea_L;<>sCR)
//$i:=1  //number of CRs to be deleted later if the text goes into another page
//End if 
//End if 

//G_ApplySheet ($CommentArea_L;1)
//WR SET TEXT PROPERTY ($CommentArea_L;wr bold;1)
//WR SET TEXT PROPERTY ($CommentArea_L;wr underline;1)  //underline - continuous underline
//WR GET CURSOR POSITION ($CommentArea_L;$StartPages_L;$vlCol;$vlLine;$vlPos)  //$vlLine : first line where the label will be inserted
//WR INSERT TEXT ($CommentArea_L;$TextToAdd_txt+<>sCR)

//$PagesAfterInsert_L:=WR Count ($CommentArea_L;wr nb pages)
//If ($PagesAfterInsert_L>$StartPages_L)
//WR SET CURSOR POSITION ($CommentArea_L;$StartPages_L;$vlCol;$vlLine;$vlPos)
//WR INSERT TEXT ($CommentArea_L;<>sCR)
//End if 
//WR EXECUTE COMMAND ($CommentArea_L;wr cmd plain)
//Else 
//If ((Not(($vlLine=1) & ($vlPos=1))))  //if at top of page no need to add lines
//WR INSERT TEXT ($CommentArea_L;<>sCR)
//G_ApplySheet ($CommentArea_L;1)
//WR GET CURSOR POSITION ($CommentArea_L;$PagesAfterInsert_L;$vlCol;$vlLine;$vlPos)  //check if we went to next page 
//If ($PagesAfterInsert_L=$StartPages_L)
//  //if still on same page then add one more linefeed  
//WR INSERT TEXT ($CommentArea_L;<>sCR)
//C_TEXT(vInspTitlePr)
//If (Position("Damage";vInspTitlePr)>0)
//  //if Damage inspection - add only one line.
//Else 
//  // for others add two lines
//WR GET CURSOR POSITION ($CommentArea_L;$PagesAfterInsert_L;$vlCol;$vlLine;$vlPos)  //check if we went to next page 
//If ($PagesAfterInsert_L=$StartPages_L)
//  //if still on same page then add one more linefeed  
//WR INSERT TEXT ($CommentArea_L;<>sCR)
//End if 

//End if 
//End if 
//End if 

//WR EXECUTE COMMAND ($CommentArea_L;wr cmd plain)
//WR SET TEXT PROPERTY ($CommentArea_L;wr bold;1)
//WR SET TEXT PROPERTY ($CommentArea_L;wr underline;1)
//WR GET CURSOR POSITION ($CommentArea_L;$StartPages_L;$vlCol;$vlLine;$vlPos)  //$vlLine : first line where the label will be inserted

//WR INSERT TEXT ($CommentArea_L;$TextToAdd_txt+<>sCR)
//WR EXECUTE COMMAND ($CommentArea_L;wr cmd plain)
//$PagesAfterInsert_L:=WR Count ($CommentArea_L;wr nb pages)
//If ($PagesAfterInsert_L>$StartPages_L)
//WR SET CURSOR POSITION ($CommentArea_L;$StartPages_L;$vlCol;$vlLine;$vlPos)
//WR INSERT TEXT ($CommentArea_L;<>sCR)
//End if 

//WR SET SELECTION ($CommentArea_L;WR Count ($CommentArea_L;wr nb characters);WR Count ($CommentArea_L;wr nb characters))  //move to end of document
//WR EXECUTE COMMAND ($CommentArea_L;wr cmd plain)
//WR INSERT TEXT ($CommentArea_L;[LSS_Inspection]LSS_AdditionalComments_txt)
//  //$PagesAfterInsert_L:=WR Count ($CommentArea_L;wr nb pages )

//End if 
//G_Insp_ApplyLineSpacing ($CommentArea_L)
//WR SET SELECTION ($CommentArea_L;WR Count ($CommentArea_L;wr nb characters);WR Count ($CommentArea_L;wr nb characters))  //move to end of document

//  //End LSS_AddAddtlCmnts