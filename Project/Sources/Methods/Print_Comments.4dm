//%attributes = {"invisible":true}
If (False:C215)
	//project method: Print_Comments
	//by: Albert Leung
	//created: 1/1/2003
	//purpose: Print inspection report pages with comments from
	//the inspection report and the elements included. At the end add
	// an index of any photos and sketches attached to this inspection.
	//This code is much the same as the PM Print_Dive_Cmt_a_new
	//except it doesn't care how long the comment text is.
	//Uses 4D Write.
	
	Mods_2005_CM01
	// Modified by: Costas Manousakis-(Designer)-(12/28/12 10:33:48)
	Mods_2012_12
	//  `Use new method Insp_SortElmtSfty
	// Modified by: Costas Manousakis-(Designer)-(10/22/19 16:23:20)
	Mods_2019_10_bug
	//  `when adding the element comments, delete the last char if it is a carr.ret CallReference #655
	Mods_2021_Delete
	
End if 

//C_BOOLEAN($bGeneral)
//C_LONGINT($vAllElmts)

//COPY NAMED SELECTION([ElementsSafety];"ElmtsInUse")

//G_Insp_RelateInsp (->[ElementsSafety]InspID)

//  // select only safety elements that have non-blank comments.
//If (False)
//QUERY SELECTION BY FORMULA([ElementsSafety];BLOB size([ElementsSafety]ElmComments)>0)
//Else 
//QUERY SELECTION([ElementsSafety];[ElementsSafety]Comment Flag=True)
//End if 
//  //ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>)
//Insp_SortElmtSfty 

//$vAllElmts:=Records in selection([ElementsSafety])

//C_LONGINT($numphotos)
//$numphotos:=Records in selection([Standard Photos])

//$bGeneral:=(BLOB size([Inspections]InspComments)>0)

//If ((($bGeneral=False) & ($vAllElmts=0))=False)
//  //start printing
//C_BLOB($temp_blob;$index_blob;vCmtsArea_)
//C_LONGINT($i;$numpages;$numnewpages)
//C_LONGINT($mainarea;$temparea;$indexarea)
//C_TEXT($Linefeeds)  // **Replaced old C_STRING length 3
//C_TEXT($vElmTitle)  // **Replaced old C_STRING length 132

//  //create main offscreen area
//$mainarea:=WR New offscreen area 
//Set Doc Margins ($mainarea)
//SET CURSOR(4)

//If ($bGeneral)
//  //copy the insp comments in the area
//WR SET TEXT PROPERTY ($mainarea;wr bold;1)
//  //WR SET TEXT PROPERTY ($mainarea;wr underline ;wr continuous underline )
//WR SET TEXT PROPERTY ($mainarea;4;1)
//WR INSERT TEXT ($mainarea;"GENERAL REMARKS"+<>sCR)
//WR EXECUTE COMMAND ($mainarea;wr cmd plain)
//WR INSERT STYLED TEXT ($mainarea;[Inspections]InspComments)
//  //keep track of page count
//$numpages:=WR Count ($mainarea;wr nb pages)
//End if 

//  //if element comments
//If ($vAllelmts>0)
//FIRST RECORD([ElementsSafety])
//For ($i;1;$vAllelmts)
//RELATE ONE([ElementsSafety]ElementNo)
//  //create a temp offscreen area
//$temparea:=WR New offscreen area 
//  //copy the main area in the temp area
//$temp_blob:=WR Area to blob ($mainarea;1)
//WR BLOB TO AREA ($temparea;$temp_blob)
//  //copy the secondary entry in the temp area
//WR SET TEXT PROPERTY ($temparea;wr font size;12)
//WR SET TEXT PROPERTY ($temparea;wr bold;1)
//  //WR SET TEXT PROPERTY ($temparea;wr underline ;wr continuous underline )
//WR SET TEXT PROPERTY ($temparea;4;1)
//$Linefeeds:=<>sCR+<>sCR  //two linefeeds between elements

//If (Substring([ElementDict]Category;1;1)="N")
//$vElmTitle:="Item "+Substring([ElementDict]Category;2)
//Else 
//  //Find the right [Element Cat]Description
//RELATE ONE([ElementDict]Category)
//$vElmTitle:=[Element Cat]Description
//End if 
//  //Add Description of parent item if any      
//If ([ElementDict]Parent>0)
//PUSH RECORD([ElementDict])
//QUERY([ElementDict];[ElementDict]ElementNo=[ElementDict]Parent)
//$vElmTitle:=$vElmTitle+" - "+[ElementDict]Description
//POP RECORD([ElementDict])
//End if 
//$vElmTitle:=$vElmTitle+" -"+[ElementsSafety]Description

//WR INSERT TEXT ($temparea;($Linefeeds+$vElmTitle))
//WR EXECUTE COMMAND ($temparea;wr cmd plain)
//WR INSERT TEXT ($temparea;<>sCR)
//WR INSERT STYLED TEXT ($temparea;[ElementsSafety]ElmComments)
//C_BOOLEAN($Bugg655)
//$Bugg655:=True
//If ($Bugg655)
//C_TEXT($PlainText_txt;$lastchar_txt)
//$PlainText_txt:=WR Get text ($temparea;0;(2*WR Count ($temparea;wr nb characters)))
//C_LONGINT($total_L)
//$total_L:=Length($PlainText_txt)
//  //get the last char
//$lastchar_txt:=Substring($PlainText_txt;$total_L;1)
//If ($lastchar_txt=Char(Carriage return))
//WR BACKSPACE ($temparea)
//End if 
//End if 

//$numnewpages:=WR Count ($temparea;wr nb pages)
//  //delete the temp ofscreen area
//WR DELETE OFFSCREEN AREA ($temparea)

//If ($numnewpages>$numpages)
//  //if the pages increase,
//$Linefeeds:=""
//$numnewpages:=$numpages
//While ($numnewpages=$numpages)
//WR INSERT TEXT ($mainarea;<>sCR)
//$numnewpages:=WR Count ($mainarea;wr nb pages)
//End while 
//End if 

//  //   then add the element comments to the main area
//WR SET TEXT PROPERTY ($mainarea;wr bold;1)
//  //WR SET TEXT PROPERTY ($mainarea;wr underline ;wr continuous underline )
//WR SET TEXT PROPERTY ($mainarea;4;1)
//WR INSERT TEXT ($mainarea;($LineFeeds+$vElmTitle))
//WR EXECUTE COMMAND ($mainarea;wr cmd plain)
//WR INSERT TEXT ($mainarea;<>sCR)
//WR INSERT STYLED TEXT ($mainarea;[ElementsSafety]ElmComments)
//$Bugg655:=True
//If ($Bugg655)
//C_TEXT($PlainText_txt;$lastchar_txt)
//$PlainText_txt:=WR Get text ($temparea;0;(2*WR Count ($temparea;wr nb characters)))
//C_LONGINT($total_L)
//$total_L:=Length($PlainText_txt)
//  //get the last char
//$lastchar_txt:=Substring($PlainText_txt;$total_L;1)
//If ($lastchar_txt=Char(Carriage return))
//WR BACKSPACE ($temparea)
//End if 
//End if 
//  //count the pages again.
//$numpages:=WR Count ($mainarea;wr nb pages)

//NEXT RECORD([ElementsSafety])
//End for 

//End if 

//If ($numphotos>0)
//  // get photo titles in array
//G_CreateImageLog ($mainarea)

//End if 

//  // make sure we go to the bottom of page.?
//$numpages:=WR Count ($mainarea;wr nb pages)
//$numnewpages:=$numpages
//While ($numnewpages=$numpages)
//WR INSERT TEXT ($mainarea;<>sCR)
//$numnewpages:=WR Count ($mainarea;wr nb pages)
//End while 
//  //maybe we do maybe we dont't know why we do not need to delete the last line feed
//WR BACKSPACE ($mainarea)
//$numpages:=WR Count ($mainarea;wr nb pages)
//sBDEPT1:=sBDEPT

//If (PrintFlag)
//  //This is really a generic form for comments.    
//FORM SET OUTPUT([Inspections];"Dive Pr Pg 2 wrt")
//  //WR SAVE DOCUMENT ($mainarea;"";"")
//If (False)
//vCmtsArea_:=WR Area to blob ($mainarea;1)
//PRINT RECORD([Inspections];*)  //no print dialog boxes
//Else 
//  //print the form once for each page...      
//C_LONGINT($vlStart;$vlbegin;$vlEnd;$vlChars)
//  //WR SET SELECTION ($mainarea;0;0)
//$vlChars:=WR Count ($mainarea;wr nb characters)
//$vlStart:=0
//WR SET SELECTION ($mainarea;0;0)
//For ($i;1;$numpages)
//If ($i=$numpages)
//  //last page
//$vlbegin:=$vlChars+1  //add 1 because it gets subtracted later
//Else 
//WR SET CURSOR POSITION ($mainarea;($i+1);1;1;1)  //next page col 1 line 1 hpos 1
//WR GET SELECTION ($mainarea;$vlbegin;$vlend)
//End if 
//WR SET SELECTION ($mainarea;$vlStart;($vlbegin-1))
//vCmtsArea_:=WR Get styled text ($mainarea)
//PRINT RECORD([Inspections];*)  //no print dialog boxes
//  //PRINT FORM([Inspections];"Dive Pr Pg 2 wrt")
//  //PAGE BREAK(>)
//WR SET SELECTION ($mainarea;0;0)
//$vlStart:=$vlbegin
//End for 

//End if 
//FORM SET OUTPUT([Inspections];"InspectionReview")

//Else 
//vPageNo:=$numpages
//End if 
//  //delete the main offscreen area
//WR DELETE OFFSCREEN AREA ($mainarea)
//SET CURSOR

//End if 

//USE NAMED SELECTION("ElmtsInUse")
//CLEAR NAMED SELECTION("ElmtsInUse")