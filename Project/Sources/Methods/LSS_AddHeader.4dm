//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 12/04/14, 11:23:09
//----------------------------------------------------
//Method: LSS_AddHeader
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (12/4/14 11:25:31)
	Mods_2021_Delete
	
End if 
//C_LONGINT($1;$4;$i;$loop_l;$StartPages_L;$vlStartSel;$CommentArea_L;$StartSelection_L;$EndSelection_L;$PagesAfterInsert_L;$vlCol;$vlLine;$vlPos;$Loop_L)

//$CommentArea_L:=$1
//C_TEXT($2;$TextToAdd_txt)  //$LastHeader_txt-- was $5)
//$TextToAdd_txt:=$2

//C_BOOLEAN($3;$InHeader_B)
//$InHeader_B:=$3

//$Loop_L:=$4
//C_POINTER($5;$ToArray_aptr)
//$ToArray_aptr:=$5
//$StartPages_L:=WR Count ($CommentArea_L;wr nb pages)  //$StartPages_L : page count at start
//WR GET SELECTION ($CommentArea_L;$StartSelection_L;$EndSelection_L)  //$vlStartSel := gets where we are at start - at the end of the text inserted before.

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
//WR EXECUTE COMMAND ($CommentArea_L;wr cmd plain)
//WR SET TEXT PROPERTY ($CommentArea_L;wr bold;1)
//WR INSERT TEXT ($CommentArea_L;<>sCR+<>sCR)
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
//WR INSERT TEXT ($CommentArea_L;$ToArray_aptr->{$Loop_L})
//  //$PagesAfterInsert_L:=WR Count ($CommentArea_L;wr nb pages )

//End if 
//G_Insp_ApplyLineSpacing ($CommentArea_L)
//WR SET SELECTION ($CommentArea_L;WR Count ($CommentArea_L;wr nb characters);WR Count ($CommentArea_L;wr nb characters))  //move to end of document
