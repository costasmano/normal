//%attributes = {"invisible":true}
If (False:C215)
	//G_Insp_AddOrientation 
	//Add Orientation text to a 4D Write Area
	
	//$1=4D Write Area ID
	
	Mods_2004_CM11
	
	Mods_2007_CM04
	// Modified by: Costas Manousakis-(Designer)-(4/29/13 16:07:16)
	Mods_2013_04
	//  `Added special case for Tunnel type inspections TAL, TOV, TSP
	// Modified by: Costas Manousakis-(Designer)-(4/25/14 11:23:10)
	Mods_2014_04
	//  `removed setting font and size
	// Modified by: Costas Manousakis-(Designer)-(2/13/15 11:46:12)
	Mods_2015_02
	//  `Case for Tunnel type inspections changed to T@
	// Modified by: Costas Manousakis-(Designer)-(10/22/19 16:23:20)
	// Modified by: Costas Manousakis-(Designer)-(10/22/19 16:23:20)
	Mods_2019_10_bug
	//  `delete the last char if it is a carr.ret CallReference #655
	//  `when moving to the end of the area, use twice the char count - CallReference #658
	// Modified by: Costas Manousakis-(Designer)-(11/1/19 11:34:34)
	Mods_2019_11_bug
	//  `use G_AddElmtTxt2Area for CallReference #668
	Mods_2021_Delete
End if 

//C_LONGINT($1;$mainarea)
//$mainarea:=$1

//C_TEXT($Title_txt)

//Case of 
//: ([Inspections]Insp Type="T@")
//$Title_txt:="TUNNEL ORIENTATION"
//Else 
//$Title_txt:="BRIDGE ORIENTATION"
//End case 

//If (False)
//C_LONGINT($numnewpages;$numpages;$vlStartSel;$vlEndSel;$vlCol;$vlLine;$vlPos)

//  //copy the insp comments in the area
//If (Not(vbTopOfPage))  //if at top of page no need to add lines
//WR INSERT TEXT ($mainarea;<>sCR)
//G_ApplySheet ($mainarea;1)
//WR INSERT TEXT ($mainarea;<>sCR)
//End if 

//G_ApplySheet ($mainarea;1)

//$numpages:=WR Count ($mainarea;wr nb pages)
//WR GET SELECTION ($mainarea;$vlStartSel;$vlEndSel)  //$vlStartSel := gets where we are at start - at the end of the text inserted before.

//  //copy the insp comments in the area
//WR SET TEXT PROPERTY ($mainarea;wr bold;1)
//WR SET TEXT PROPERTY ($mainarea;wr underline;1)
//WR GET CURSOR POSITION ($mainarea;$numnewpages;$vlCol;$vlLine;$vlPos)  //$vlLine : first line where the label will be inserted

//WR INSERT TEXT ($mainarea;$Title_txt+<>sCR)

//WR EXECUTE COMMAND ($mainarea;wr cmd plain)
//WR INSERT STYLED TEXT ($mainarea;[Inspections]OrientationText)

//C_TEXT($PlainText_txt;$lastchar_txt)
//$PlainText_txt:=WR Get text ($mainarea;0;(2*WR Count ($mainarea;wr nb characters)))
//C_LONGINT($total_L)
//$total_L:=Length($PlainText_txt)
//  //get the last char
//$lastchar_txt:=Substring($PlainText_txt;$total_L;1)
//If ($lastchar_txt=Char(Carriage return))
//WR BACKSPACE ($mainarea)
//End if 

//G_Insp_ApplyLineSpacing ($mainarea)
//C_LONGINT($chars_L)
//$chars_L:=2*WR Count ($mainarea;wr nb characters)
//WR SET SELECTION ($mainarea;$chars_L;$chars_L)

//$numnewpages:=WR Count ($mainarea;wr nb pages)
//If ($numnewpages>$numpages)
//  //ut_Send2Clipboard ("Fixing paragraphs.."+<>sCR)
//G_InspParagProt ($mainarea;$numpages;1;$vlStartSel;0;$Title_txt)  //for Orientation start is always at line 1
//End if 
//Else 
//G_AddElmtTxt2Area ($mainarea;$Title_txt;[Inspections]OrientationText)

//End if 

//vbTopOfPage:=False  //we have added something to the page