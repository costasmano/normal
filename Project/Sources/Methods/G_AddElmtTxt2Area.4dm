//%attributes = {"invisible":true}
If (False:C215)
	//G_AddElmtTxt2Area
	//Append current [ElementsSafety]ElmComments styled text to an area with a title. 
	
	//G_AddElmtTxt2Area(area;Title)
	
	Mods_2004_CM11
	
	Mods_2007_CM04
	// Modified by: Costas Manousakis-(Designer)-(11/2/12 15:12:25)
	Mods_2012_11  //Copied to Server on : 11/02/12, 15:13:14
	//  `Declare vInspFontNumber and assign it only if > 0
	// Modified by: Costas Manousakis-(Designer)-(4/24/14 11:03:09)
	Mods_2014_04_bug
	//  `removed calls to set the font and fontnumber
	// Modified by: Costas Manousakis-(Designer)-(5/20/16 15:25:39)
	Mods_2016_05
	//  `Added optional 3rd parameter to pass the sytled text blob
	// Modified by: Costas Manousakis-(Designer)-(12/26/17 17:46:04)
	Mods_2017_12
	//  `when moving to end of doc, use twice the char count to avoid miscounting by 4DWR
	// Modified by: Costas Manousakis-(Designer)-(10/22/19 16:23:20)
	Mods_2019_10_bug
	//  `delete the last char if it is a carr.ret CallReference #655
	// Modified by: Costas Manousakis-(Designer)-(11/1/19 14:53:58)
	Mods_2019_11_bug
	//  `fixes for CallReference #668
	Mods_2021_Delete
	
End if 

//C_LONGINT($1)
//C_TEXT($vElmTitle;$2)  // **Replaced old C_STRING length 132
//C_LONGINT($i;$numpages;$numnewpages;$vlStartSel;$vlEndSel;$vlCol;$vlLine;$vlPos)
//C_LONGINT($mainarea)
//C_BOOLEAN(vbTopOfPage)

//$mainarea:=$1
//$vElmTitle:=$2

//C_BLOB($StyledText_x)

//If (Count parameters>2)
//C_BLOB($3)
//$StyledText_x:=$3
//Else 
//$StyledText_x:=[ElementsSafety]ElmComments
//End if 


//C_TEXT($vTitleTxt;vtHeaderLbl)
//If (vtHeaderLbl#"")
//$vTitleTxt:=vtHeaderLbl+<>sCR+<>sCR+$vElmTitle
//vtHeaderLbl:=""
//Else 
//$vTitleTxt:=$vElmTitle
//End if 

//$numpages:=WR Count ($mainarea;wr nb pages)  //$numpages : page count at start
//WR GET SELECTION ($mainarea;$vlStartSel;$vlEndSel)  //$vlStartSel := gets where we are at start - at the end of the text inserted before.

//If (Not(vbTopOfPage))  //if at top of page no need to add lines

//WR INSERT TEXT ($mainarea;<>sCR)
//G_ApplySheet ($mainarea;1)
//G_Insp_ApplyLineSpacing ($mainarea)
//WR GET CURSOR POSITION ($mainarea;$numnewpages;$vlCol;$vlLine;$vlPos)  //check if we went to next page 
//$i:=0

//If ($numnewpages=$numpages)
//  //if still on same page then add one more linefeed  
//WR INSERT TEXT ($mainarea;<>sCR)
//$i:=1  //number of CRs to be deleted later if the text goes into another page

//End if 
//  //G_Insp_ApplyLineSpacing ($mainarea)

//End if 

//G_ApplySheet ($mainarea;1)
//G_Insp_ApplyLineSpacing ($mainarea)

//WR SET TEXT PROPERTY ($mainarea;wr bold;1)
//WR SET TEXT PROPERTY ($mainarea;wr underline;1)  //underline - continuous underline
//WR GET CURSOR POSITION ($mainarea;$numpages;$vlCol;$vlLine;$vlPos)  //$vlLine : first line where the label will be inserted - update the starting page number
//WR INSERT TEXT ($mainarea;$vTitleTxt)
//WR INSERT TEXT ($mainarea;<>sCR)
//G_ApplySheet ($mainarea;1)
//WR INSERT STYLED TEXT ($mainarea;$StyledText_x)

//C_TEXT($PlainText_txt;$lastchar_txt)
//$PlainText_txt:=WR Get text ($mainarea;0;(2*WR Count ($mainarea;wr nb characters)))
//C_LONGINT($total_L)
//$total_L:=Length($PlainText_txt)
//  //get the last char
//$lastchar_txt:=Substring($PlainText_txt;$total_L;1)
//If ($lastchar_txt=Char(Carriage return))
//WR BACKSPACE ($mainarea)
//End if 

//  //ut_Send2Clipboard ("Apply spacing.."+<>sCR)
//G_Insp_ApplyLineSpacing ($mainarea)

//C_LONGINT($charCount_L)
//$charCount_L:=2*(WR Count ($mainarea;wr nb characters))  //use twice the count to avoid miscounting by 4DWR
//WR SET SELECTION ($mainarea;$charCount_L;$charCount_L)  //move to end of document 
//$numnewpages:=WR Count ($mainarea;wr nb pages)
//If ($numnewpages>$numpages)
//  //ut_Send2Clipboard ("Fixing paragraphs.."+<>sCR)
//G_InspParagProt ($mainarea;$numpages;$vlLine;$vlStartSel;$i;$vElmTitle)
//End if 

//SET BLOB SIZE($StyledText_x;0)