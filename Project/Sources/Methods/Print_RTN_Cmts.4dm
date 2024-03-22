//%attributes = {"invisible":true}
//Project Method : Print_RTN_Cmts
//
//Print Routine inspection report pages with comments from
//the inspection report and the elements included. At the end add
// an index of any photos and sketches attached to this inspection.
If (False:C215)
	//
	//4D WRITE Version...
	
	Mods_2004_CM11  //2 times
	Mods_2004_CM12
	Mods_2005_CM01
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(11/10/2006 20:26:31)
	Mods_2007_CM04
	// Modified by: costasmanousakis-(Designer)-(12/20/07 12:34:54)
	Mods_2007_CM_5401
	//  `Use the ◊ELMTDICT_@ arrays instead of relate many
	// Modified by: costasmanousakis-(Designer)-(3/10/09 10:35:06)
	Mods_2009_03
	//Use method INSP_ElmtDescUtil to load arrays used in labels of parent elements
	Mods_2011_06  // CJ Miller`06/13/11, 16:45:56      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(2/13/12 16:01:44)
	Mods_2012_02
	//  `Fixed missing Item 62 and GENERAL for RRR type inspections
	// Modified by: Costas Manousakis-(Designer)-(12/27/12 11:37:09)
	Mods_2012_12
	//  ` Clear picture var CommentsPrevw_P when done printing
	// Modified by: Costas Manousakis-(Designer)-(12/28/12 10:37:35)
	Mods_2012_12
	//  `Use new method Insp_SortElmtSfty ;  do the sorting  only if there are records in the selection
	//  `Clean up all code enclosed in "IF (False)"
	// Modified by: Costas Manousakis-(Designer)-(9/28/16 14:02:47)
	Mods_2016_09
	//  `Added test case for designer to print comments using a 4D Wr area instead of a  preview picture
	// Modified by: Costas Manousakis-(Designer)-(9/28/16 16:32:36)
	Mods_2016_09
	//  `added temp call to Insp_PrintRemarks when user is design access
	// Modified by: Costas Manousakis-(Designer)-(10/7/16 16:52:58)
	Mods_2016_10
	//  `call to Insp_PrintRemarks when  ◊pref_New4DWR is true
	// Modified by: Costas Manousakis-(Designer)-(10/25/16 14:47:31)
	Mods_2016_10
	//  `allow designer to pick option of printing method
	// Modified by: Costas Manousakis-(Designer)-(10/22/19 16:23:20)
	Mods_2019_10_bug
	//  `apply stylesheet 1 when adding linefeeds at the end  -  CallReference #655
	// Modified by: Costas Manousakis-(Designer)-(10/28/19 16:23:20)
	Mods_2019_10_bug
	//  `add message when assembling comments
	Mods_2021_01  //Add code that will create PDFs of all [Inspections]InspApproved=2
	Mods_2021_Delete
End if 

//C_LONGINT($0)  //return number of pages printed.
//C_BOOLEAN($1;$2)
//C_BOOLEAN($bGeneral;$bOtherCmts)
//C_LONGINT($vAllElmts)
//C_BOOLEAN(vbTopOfPage)  //Indicate Top of page
//C_BOOLEAN(PrintFlag;$bViewAllCmtsFlag)
//C_LONGINT(viInspPreviewErr)  // **replaced _ o _C_INTEGER()
//C_LONGINT(INSP_PrevElmtParntID)
//INSP_PrevElmtParntID:=0

//$0:=0  //initialize to zero
//$bViewAllCmtsFlag:=False
//Case of 
//: (Count parameters=1)
//PrintFlag:=$1
//: (Count parameters=2)
//PrintFlag:=$1
//$bViewAllCmtsFlag:=$2
//End case 

//COPY NAMED SELECTION([ElementsSafety];"ElmtsInUse")

//G_Insp_RelateInsp (->[ElementsSafety]InspID)
//INSP_ElmtDescUtil ("LOAD")

//  // select only safety elements that have non-blank comments.
//QUERY SELECTION([ElementsSafety];[ElementsSafety]Comment Flag=True)
//$vAllElmts:=Records in selection([ElementsSafety])

//C_LONGINT($numphotos)
//$numphotos:=Records in selection([Standard Photos])

//C_BOOLEAN($bOrientation)
//$bOrientation:=((BLOB size([Inspections]OrientationText)>0) & (f_Insp_Revision1 ([Inspections]Insp Date)))

//$bGeneral:=(BLOB size([Inspections]InspComments)>0)

//  //check about collision, etc. comments
//$bOtherCmts:=(([Inspections]CollisionSuper#"") | ([Inspections]LoadDeflSuper#"") | ([Inspections]LoadVibSuper#""))
//$bOtherCmts:=$bOtherCmts | ([Inspections]CollisionSub#"")
//$bOtherCmts:=$bOtherCmts | ([Inspections]UnderminingTxt#"")
//$bOtherCmts:=$bOtherCmts | ([Inspections]ScourTxt#"")

//If ((($bOrientation=False) & ($bGeneral=False) & ($vAllElmts=0) & ($numphotos=0) & (Not($bOtherCmts)))=False)

//G_Insp_FontAlert 

//  //start printing
//C_BLOB(vCmtsArea_)
//C_LONGINT($i;$numpages;$numnewpages;$viNElmts)
//C_LONGINT($mainarea)
//C_TEXT($vElmTitle)  // **Replaced old C_STRING length 132

//  //create main offscreen area
//$mainarea:=WR New offscreen area 
//  //WR UPDATE MODE ($mainarea;0)  `turn off updating
//Set Doc Margins ($mainarea)
//  //````    `````    `````    `````    `````    `````    `````    `````  
//SET CURSOR(4)
//If (PrintFlag | $bViewAllCmtsFlag)
//SHORT_MESSAGE ("Assembling Remarks...")
//End if 
//vbTopOfPage:=True  //say we start from top of page

//If ($bOrientation)
//G_Insp_AddOrientation ($mainarea)
//End if 

//If ($bGeneral)
//G_Insp_AddGenCmts ($mainarea)
//End if 

//  //       if element comments
//  //order is item58,app,over,59,sup drops,sub, substr props, 61, traff
//COPY NAMED SELECTION([ElementsSafety];"BlobElmts")
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="N58")
//  //ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>)
//$viNElmts:=Records in selection([ElementsSafety])
//If ($viNElmts>0)
//Insp_SortElmtSfty 

//G_AddHeader ("N58")
//FIRST RECORD([ElementsSafety])
//For ($i;1;$viNElmts)
//  //RELATE ONE([ElementsSafety]ElementNo)
//$vElmTitle:=G_GetElmtLabel (True)
//G_AddElmtTxt2Area ($mainarea;$vElmTitle)
//vbTopOfPage:=False  //we have added something to the page
//NEXT RECORD([ElementsSafety])
//End for 
//End if 
//USE NAMED SELECTION("BlobElmts")
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="APP")
//  //ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>)
//$viNElmts:=Records in selection([ElementsSafety])
//If ($viNElmts>0)
//Insp_SortElmtSfty 
//G_AddHeader ("APP")
//FIRST RECORD([ElementsSafety])
//For ($i;1;$viNElmts)
//  //RELATE ONE([ElementsSafety]ElementNo)
//$vElmTitle:=G_GetElmtLabel (True)
//G_AddElmtTxt2Area ($mainarea;$vElmTitle)
//vbTopOfPage:=False  //we have added something to the page
//NEXT RECORD([ElementsSafety])
//End for 
//End if 
//USE NAMED SELECTION("BlobElmts")
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="OVR")
//  //ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>)
//$viNElmts:=Records in selection([ElementsSafety])
//If ($viNElmts>0)
//Insp_SortElmtSfty 
//G_AddHeader ("OVR")
//FIRST RECORD([ElementsSafety])
//For ($i;1;$viNElmts)
//  //RELATE ONE([ElementsSafety]ElementNo)
//$vElmTitle:=G_GetElmtLabel (True)
//G_AddElmtTxt2Area ($mainarea;$vElmTitle)
//vbTopOfPage:=False  //we have added something to the page
//NEXT RECORD([ElementsSafety])
//End for 
//End if 
//USE NAMED SELECTION("BlobElmts")
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="N59")
//  //ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>)
//$viNElmts:=Records in selection([ElementsSafety])
//Case of 
//: ($viNElmts>0)
//G_AddHeader ("N59")
//: ([Inspections]CollisionSuper#"")
//G_AddHeader ("N59")
//: ([Inspections]LoadDeflSuper#"")
//G_AddHeader ("N59")
//: ([Inspections]LoadVibSuper#"")
//G_AddHeader ("N59")
//End case 

//If ($viNElmts>0)
//Insp_SortElmtSfty 
//FIRST RECORD([ElementsSafety])
//For ($i;1;$viNElmts)
//  //RELATE ONE([ElementsSafety]ElementNo)
//$vElmTitle:=G_GetElmtLabel (True)
//G_AddElmtTxt2Area ($mainarea;$vElmTitle)
//vbTopOfPage:=False  //we have added something to the page
//NEXT RECORD([ElementsSafety])
//End for 
//End if 
//If ([Inspections]CollisionSuper#"")
//G_addItemtoWr ($mainarea;"SuperStructure Collision Notes";[Inspections]CollisionSuper)
//vbTopOfPage:=False  //we have added something to the page
//End if 
//If ([Inspections]LoadDeflSuper#"")
//G_addItemtoWr ($mainarea;"SuperStructure Load Deflection Notes";[Inspections]LoadDeflSuper)
//vbTopOfPage:=False  //we have added something to the page
//End if 
//If ([Inspections]LoadVibSuper#"")
//G_addItemtoWr ($mainarea;"SuperStructure Load Vibration Notes";[Inspections]LoadVibSuper)
//vbTopOfPage:=False  //we have added something to the page
//End if 
//USE NAMED SELECTION("BlobElmts")
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="N60")
//  //ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>)
//$viNElmts:=Records in selection([ElementsSafety])
//Case of 
//: ($viNElmts>0)
//G_AddHeader ("N60")
//: ([Inspections]CollisionSub#"")
//G_AddHeader ("N60")
//: ([Inspections]UnderminingTxt#"")
//G_AddHeader ("N60")
//: ([Inspections]ScourTxt#"")
//G_AddHeader ("N60")
//End case 

//If ($viNElmts>0)

//Insp_SortElmtSfty 

//FIRST RECORD([ElementsSafety])
//For ($i;1;$viNElmts)
//  //RELATE ONE([ElementsSafety]ElementNo)
//$vElmTitle:=G_GetElmtLabel (True)
//G_AddElmtTxt2Area ($mainarea;$vElmTitle)
//vbTopOfPage:=False  //we have added something to the page
//NEXT RECORD([ElementsSafety])
//End for 
//End if 
//If ([Inspections]CollisionSub#"")
//G_addItemtoWr ($mainarea;"SubStructure Collision Notes";[Inspections]CollisionSub)
//vbTopOfPage:=False  //we have added something to the page
//End if 
//If ([Inspections]UnderminingTxt#"")
//G_addItemtoWr ($mainarea;"SubStructure Undermining Notes";[Inspections]UnderminingTxt)
//vbTopOfPage:=False  //we have added something to the page
//End if 
//If ([Inspections]ScourTxt#"")
//G_addItemtoWr ($mainarea;"SubStructure Scour Notes";[Inspections]ScourTxt)
//vbTopOfPage:=False  //we have added something to the page
//End if 
//USE NAMED SELECTION("BlobElmts")
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="N61")
//  //ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>)
//$viNElmts:=Records in selection([ElementsSafety])
//If ($viNElmts>0)
//Insp_SortElmtSfty 
//G_AddHeader ("N61")
//FIRST RECORD([ElementsSafety])
//For ($i;1;$viNElmts)
//  //RELATE ONE([ElementsSafety]ElementNo)
//$vElmTitle:=G_GetElmtLabel (True)
//G_AddElmtTxt2Area ($mainarea;$vElmTitle)
//vbTopOfPage:=False  //we have added something to the page
//NEXT RECORD([ElementsSafety])
//End for 
//End if 
//USE NAMED SELECTION("BlobElmts")
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="TRA")
//  //ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>)
//$viNElmts:=Records in selection([ElementsSafety])
//If ($viNElmts>0)
//Insp_SortElmtSfty 
//G_AddHeader ("TRA")

//FIRST RECORD([ElementsSafety])
//For ($i;1;$viNElmts)
//  //RELATE ONE([ElementsSafety]ElementNo)
//$vElmTitle:=G_GetElmtLabel (True)
//G_AddElmtTxt2Area ($mainarea;$vElmTitle)
//vbTopOfPage:=False  //we have added something to the page
//NEXT RECORD([ElementsSafety])
//End for 
//End if 

//If ([Inspections]Insp Type="RR@")
//USE NAMED SELECTION("BlobElmts")
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="N62")
//$viNElmts:=Records in selection([ElementsSafety])
//If ($viNElmts>0)
//Insp_SortElmtSfty 
//G_AddHeader ("N62")

//FIRST RECORD([ElementsSafety])
//For ($i;1;$viNElmts)
//  //RELATE ONE([ElementsSafety]ElementNo)
//$vElmTitle:=G_GetElmtLabel (True)
//G_AddElmtTxt2Area ($mainarea;$vElmTitle)
//vbTopOfPage:=False  //we have added something to the page
//NEXT RECORD([ElementsSafety])
//End for 
//End if 

//USE NAMED SELECTION("BlobElmts")
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="GEN")
//$viNElmts:=Records in selection([ElementsSafety])
//If ($viNElmts>0)
//Insp_SortElmtSfty 
//G_AddHeader ("GEN")

//FIRST RECORD([ElementsSafety])
//For ($i;1;$viNElmts)
//  //RELATE ONE([ElementsSafety]ElementNo)
//$vElmTitle:=G_GetElmtLabel (True)
//G_AddElmtTxt2Area ($mainarea;$vElmTitle)
//vbTopOfPage:=False  //we have added something to the page
//NEXT RECORD([ElementsSafety])
//End for 
//End if 

//End if 
//CLEAR NAMED SELECTION("BlobElmts")

//If ($numphotos>0)
//  // get photo titles in array
//G_CreateImageLog ($mainarea)
//vbTopOfPage:=False  //we have added something to the page

//End if 

//  // make sure we go to the bottom of page.?
//$numpages:=WR Count ($mainarea;wr nb pages)
//$numnewpages:=$numpages
//While ($numnewpages=$numpages)
//WR INSERT TEXT ($mainarea;<>sCR)
//G_ApplySheet ($mainarea;1)  // need this in case last paragraph has bullets.
//$numnewpages:=WR Count ($mainarea;wr nb pages)
//End while 
//  //maybe we do maybe we dont't know why we do not need to delete the last line feed
//WR BACKSPACE ($mainarea)
//$numpages:=WR Count ($mainarea;wr nb pages)
//sBDEPT1:=sBDEPT
//WR UPDATE MODE ($mainarea;1)  //updating back on 

//If (PrintFlag | $bViewAllCmtsFlag)
//CLOSE WINDOW
//End if 

//If ((PrintFlag) & (viInspPreviewErr=0) & ($bViewAllCmtsFlag=False))
//C_BOOLEAN($NewMethod_b)
//$NewMethod_b:=(User in group(Current user;"Design Access Group") | <>pref_New4DWR)
//If (Not(INSP_CreatePDFsofApproved_B))
//If (User in group(Current user;"Design Access Group"))
//CONFIRM(" Design Access Group use new comments print method ?";"New";"BuildPreview")
//$NewMethod_b:=(OK=1)
//End if 
//End if 
//If ($NewMethod_b)
//Insp_PrintRemarks ($mainarea)
//Else 
//  //MODS_XXXX_CM
//C_PICTURE(CommentsPrevw_P)
//For ($i;1;$numpages)

//CommentsPrevw_P:=WR Build preview ($mainarea;$i)
//PAGE BREAK(>)
//C_LONGINT($printht)
//$printht:=Print form([Inspections];"CmtsPrint")
//If (viInspPreviewErr#0)
//  //exit if preview error
//$i:=$numpages+1
//End if 

//End for 
//CommentsPrevw_P:=CommentsPrevw_P*0

//End if 

//Else 

//End if 

//$0:=$numpages

//  //added 4/1/04
//If ($bViewAllCmtsFlag)
//INSP_ViewAllComments ($mainarea)  //MODS_XXXX_CM
//End if 

//  //delete the main offscreen area
//WR DELETE OFFSCREEN AREA ($mainarea)
//  //reduce the blob size to zero
//SET BLOB SIZE(vCmtsArea_;0)
//SET CURSOR

//End if 

//INSP_ElmtDescUtil ("CLEAR")

//USE NAMED SELECTION("ElmtsInUse")
//CLEAR NAMED SELECTION("ElmtsInUse")