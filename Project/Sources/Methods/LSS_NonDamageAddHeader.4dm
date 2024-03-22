//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 12/04/14, 11:23:09
//----------------------------------------------------
//Method: LSS_NonDamageAddHeader
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (12/4/14 11:25:31)
	// Modified by: CJMiller-(Designer)-(10/17/18 10:31:16)
	Mods_2018_10
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2/19/21 18:10:52)
	Mods_2021_02
	//  `adjusted spaces before and after printing a header label 2 spaces before , 1 after
	//  `adjusted logic of when adding linefeeds before the labels
	Mods_2021_Delete
End if 
//C_LONGINT($1;$4;$i;$StartPages_L;$vlStartSel;$CommentArea_L;$StartSelection_L;$EndSelection_L;$PagesAfterInsert_L;$vlCol;$vlLine;$vlPos;$Loop_L)
//$Loop_L:=$4
//$CommentArea_L:=$1
//C_TEXT($2;$TextToAdd_txt)  //$LastHeader_txt-- was $5)
//$TextToAdd_txt:=$2

//C_BOOLEAN($3;$InHeader_B)
//$InHeader_B:=$3
//$StartPages_L:=WR Count ($CommentArea_L;wr nb pages)  //$StartPages_L : page count at start
//WR GET SELECTION ($CommentArea_L;$StartSelection_L;$EndSelection_L)  //$vlStartSel := gets where we are at start - at the end of the text inserted before.
//WR GET CURSOR POSITION ($CommentArea_L;$StartPages_L;$vlCol;$vlLine;$vlPos)
//If ($InHeader_B)
//If ((Not(($vlLine=1) & ($vlPos=1))))  //if at top of page no need to add lines
//WR INSERT TEXT ($CommentArea_L;<>sCR)
//G_ApplySheet ($CommentArea_L;1)
//WR GET CURSOR POSITION ($CommentArea_L;$PagesAfterInsert_L;$vlCol;$vlLine;$vlPos)  //check if we went to next page 
//If ($PagesAfterInsert_L=$StartPages_L)
//  //if still on same page then add one more linefeed  
//WR INSERT TEXT ($CommentArea_L;<>sCR)
//WR GET CURSOR POSITION ($CommentArea_L;$PagesAfterInsert_L;$vlCol;$vlLine;$vlPos)  //check if we went to next page 
//If ($PagesAfterInsert_L=$StartPages_L)
//WR INSERT TEXT ($CommentArea_L;<>sCR)
//End if 
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
//WR SET SELECTION ($CommentArea_L;WR Count ($CommentArea_L;wr nb characters)-1;WR Count ($CommentArea_L;wr nb characters))  //move to end of document
//WR INSERT TEXT ($CommentArea_L;"")  // replace the last carriage return
//WR EXECUTE COMMAND ($CommentArea_L;wr cmd plain)
//Else 
//If ((Not(($vlLine=1) & ($vlPos=1))))  //if at top of page no need to add lines
//WR INSERT TEXT ($CommentArea_L;<>sCR)
//WR GET CURSOR POSITION ($CommentArea_L;$PagesAfterInsert_L;$vlCol;$vlLine;$vlPos)  //check if we went to next page 
//If ($PagesAfterInsert_L=$StartPages_L)
//  //if still on same page then add one more linefeed  
//WR INSERT TEXT ($CommentArea_L;<>sCR)

//End if 
//End if 
//  //WR INSERT TEXT ($CommentArea_L;<>sCR+<>sCR)
//WR EXECUTE COMMAND ($CommentArea_L;wr cmd plain)
//WR SET TEXT PROPERTY ($CommentArea_L;wr bold;1)
//WR GET CURSOR POSITION ($CommentArea_L;$StartPages_L;$vlCol;$vlLine;$vlPos)  //$vlLine : first line where the label will be inserted

//WR INSERT TEXT ($CommentArea_L;$TextToAdd_txt+<>sCR)
//$PagesAfterInsert_L:=WR Count ($CommentArea_L;wr nb pages)
//If ($PagesAfterInsert_L>$StartPages_L)
//WR SET CURSOR POSITION ($CommentArea_L;$StartPages_L;$vlCol;$vlLine;$vlPos)
//WR INSERT TEXT ($CommentArea_L;<>sCR)
//End if 

//WR SET SELECTION ($CommentArea_L;WR Count ($CommentArea_L;wr nb characters);WR Count ($CommentArea_L;wr nb characters))  //move to end of document
//WR EXECUTE COMMAND ($CommentArea_L;wr cmd plain)
//WR INSERT TEXT ($CommentArea_L;LSS_ElementRemarks_atxt{$Loop_L})
//  //$PagesAfterInsert_L:=WR Count ($CommentArea_L;wr nb pages )

//End if 
//G_Insp_ApplyLineSpacing ($CommentArea_L)
//WR SET SELECTION ($CommentArea_L;WR Count ($CommentArea_L;wr nb characters);WR Count ($CommentArea_L;wr nb characters))  //move to end of document

