//%attributes = {"invisible":true}
//G_addItemtoWr
// Add a text item with a label to a 4DWRtie area
//$1 : 4D Write area
//$2 : Label of item
//$3 : Text of item
//$4 : 2nd Line Indent (optional)
If (False:C215)
	
	Mods_2004_CM11
	
	Mods_2007_CM04
	Mods_2011_06  // CJ Miller`06/13/11, 16:47:36      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(11/1/19 17:15:00)
	Mods_2019_11_bug
	//  `fixes for CallReference #668
	Mods_2021_Delete
	
End if 

//C_LONGINT($1;$Area)
//C_TEXT($2;$Label)  // **Replaced old C_STRING length 255
//C_TEXT($3;$ItmTxt)
//C_REAL($4;$vrParIndent)
//C_BOOLEAN(vbTopOfPage)

//$Area:=$1
//$Label:=$2
//$ItmTxt:=$3

//If (Count parameters=4)
//$vrParIndent:=$4
//End if 

//C_TEXT($vTitleTxt;vtHeaderLbl)
//If (vtHeaderLbl#"")
//$vTitleTxt:=vtHeaderLbl+<>sCR+<>sCR+$Label
//vtHeaderLbl:=""
//Else 
//$vTitleTxt:=$Label
//End if 

//C_LONGINT($numpages;$numnewpages;$vlStartSel;$vlEndSel;$vlCol;$vlLine;$vlPos;$i)
//C_LONGINT($vlLineSt;$vlLine2;$vlStartInsert;$vlEndInsert)
//C_LONGINT($irnumtabs;$viAlignment;$viFindRes;$viNumPars)  // **replaced _ o _C_INTEGER()
//C_REAL($vrOrigPos)
//C_TEXT($vsFillChar)  // **Replaced old C_STRING length 80
//C_TEXT($vtWordst)

//$numpages:=WR Count ($Area;wr nb pages)
//WR GET SELECTION ($Area;$vlStartSel;$vlEndSel)

//If (Not(vbTopOfPage))  //if at top of page no need to add lines
//WR INSERT TEXT ($Area;<>sCR)
//G_ApplySheet ($Area;1)
//G_Insp_ApplyLineSpacing ($Area)
//WR GET CURSOR POSITION ($Area;$numnewpages;$vlCol;$vlLine;$vlPos)  //check if we went to next page
//$i:=0
//If ($numnewpages=$numpages)
//  //if still on same page then add one more linefeed  
//WR INSERT TEXT ($Area;<>sCR)
//$i:=1  //number of CRs to be deleted later if the text goes into another page
//End if 

//End if 

//G_ApplySheet ($Area;1)
//G_Insp_ApplyLineSpacing ($Area)

//  //WR SET TEXT PROPERTY ($Area;wr underline ;wr continuous underline )
//WR SET TEXT PROPERTY ($Area;wr bold;1)
//WR SET TEXT PROPERTY ($Area;wr underline;1)
//WR GET CURSOR POSITION ($Area;$numpages;$vlCol;$vlLine;$vlPos)  //$vlLine : first line where the label will be inserted - update the starting page number

//WR INSERT TEXT ($Area;$vTitleTxt)
//WR INSERT TEXT ($Area;<>sCR)
//G_ApplySheet ($Area;1)
//WR EXECUTE COMMAND ($Area;wr cmd plain)
//WR GET SELECTION ($Area;$vlLineSt;$vlLine2)
//If (Count parameters=4)
//WR SET TEXT PROPERTY ($Area;wr left margin;$vrParIndent)
//WR SET TEXT PROPERTY ($Area;wr first indent;(-$vrParIndent))
//C_REAL($viNumtabs)
//C_LONGINT($Uniform)  // **replaced _ o _C_INTEGER()

//$viNumtabs:=WR Get text property ($Area;wr tab;$Uniform)
//If ($viNumtabs>0)
//WR GET TAB ($Area;1;$vrOrigPos;$viAlignment;$vsFillChar)
//WR SET TAB ($Area;1;$vrParIndent;$viAlignment;$vsFillChar)
//Else 
//WR ADD TAB ($Area;1;$vrParIndent;"")
//End if 
//End if 
//WR INSERT TEXT ($Area;$ItmTxt)

//G_Insp_ApplyLineSpacing ($Area)

//If (Count parameters=4)
//WR GET SELECTION ($Area;$vlStartInsert;$vlEndInsert)
//  //now adjust the paragraphs for all except the 1st one.
//WR SET SELECTION ($Area;$vlLine2;$vlLine2)  //move to the start of the insert
//$viFindRes:=WR Find ($Area;<>sCR;0;0;0)  //Find the next line feed
//While ($viFindRes=1)
//WR GET SELECTION ($Area;$vlLineSt;$vlLine2)
//WR SET SELECTION ($Area;$vlLine2;$vlLine2)
//$vtWordst:=WR Get text ($Area;$vlLine2;($vlLine2+4))
//If (($vtWordst#"PHOT") & ($vtWordst#"SKET") & ($vtWordst#"CHAR"))
//WR SET TEXT PROPERTY ($Area;wr first indent;0)
//End if 
//WR GET SELECTION ($Area;$vlLineSt;$vlLine2)
//$viFindRes:=WR Find ($Area;<>sCR;0;0;0)  //Find the next line feed
//End while 
//  //Now reset the selection
//WR SET SELECTION ($Area;$vlStartInsert;$vlEndInsert)
//End if 

//$numnewpages:=WR Count ($Area;wr nb pages)
//If ($numnewpages>$numpages)
//G_InspParagProt ($Area;$numpages;$vlLine;$vlStartSel;$i;$Label)
//End if 
//C_LONGINT($charCount_L)
//$charCount_L:=2*(WR Count ($Area;wr nb characters))  //use twice the count to avoid miscounting by 4DWR
//WR SET SELECTION ($Area;$charCount_L;$charCount_L)  //move to end of document 