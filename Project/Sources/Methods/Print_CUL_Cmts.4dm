//%attributes = {"invisible":true}
//Project Method : Print_CUL_Cmts
//  `Print culvert inspection report pages with comments from
//  `the inspection report and the elements included. At the end add
//  ` an index of any photos and sketches attached to this inspection.
//
//4D WRITE Version...
If (False:C215)
	
	Mods_2004_CM11  //2 times
	Mods_2004_CM12
	Mods_2005_CM01
	// Modified by: costasmanousakis-(Designer)-(11/10/2006 20:54:13)
	Mods_2007_CM04
	// Modified by: costasmanousakis-(Designer)-(2/6/2007 12:00:55)
	Mods_2007_CM06
	// Modified by: costasmanousakis-(Designer)-(12/20/07 12:34:54)
	Mods_2007_CM_5401
	//  `Use the ◊ELMTDICT_@ arrays instead of relate many
	// Modified by: costasmanousakis-(Designer)-(3/10/09 10:35:06)
	Mods_2009_03
	//Use method INSP_ElmtDescUtil to load arrays used in labels of parent elements
	Mods_2011_06  // CJ Miller`06/13/11, 16:50:42      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(12/27/12 11:37:09)
	Mods_2012_12
	//  ` Clear picture var CommentsPrevw_P when done printing; also clear before printing just a blank page
	// Modified by: Costas Manousakis-(Designer)-(12/28/12 10:37:35)
	Mods_2012_12
	//  `Use new method Insp_SortElmtSfty ;  do the sorting  only if there are records in the selection
	//  `Clean up all code enclosed in "IF (False)"
	// Modified by: Costas Manousakis-(Designer)-(3/18/15 11:24:05)
	Mods_2015_03_bug
	//  `fixed bug where  Comments for elements under General for Rail inspections were not printed.
	// Modified by: Costas Manousakis-(Designer)-(9/28/16 16:32:36)
	Mods_2016_09
	//  `added temp call to Insp_PrintRemarks when user is design access
	// Modified by: Costas Manousakis-(Designer)-(10/7/16 16:52:58)
	Mods_2016_10
	//  `call to Insp_PrintRemarks when  ◊pref_New4DWR is true
	// Modified by: Costas Manousakis-(Designer)-(10/25/16 14:47:31)
	Mods_2016_10
	//  `allow designer to pick option of printing method
	// Modified by: Costas Manousakis-(Designer)-(9/25/18 13:24:02)
	Mods_2018_09_bug
	//  `remove scaling of preview pic for windows. scaling is done in the print form to fit width of 
	Mods_2021_01  //Add code that will create PDFs of all [Inspections]InspApproved=2
	Mods_2021_Delete
End if 
//C_LONGINT($0)  //return number of pages printed.
//C_BOOLEAN($1;$2)
//C_BOOLEAN($bGeneral;$bOtherCmts)
//C_LONGINT($vAllElmts)
//C_BOOLEAN(vbTopOfPage)  //Indicate Top of page
//C_BOOLEAN(PrintFlag;$bViewAllCmtsFlag)
//C_LONGINT(viInspPreviewErr)  //Command Replaced was o_C_INTEGER
//C_LONGINT(INSP_PrevElmtParntID)
//INSP_PrevElmtParntID:=0

//$bViewAllCmtsFlag:=False
//Case of 
//: (Count parameters=1)
//PrintFlag:=$1
//: (Count parameters=2)
//PrintFlag:=$1
//$bViewAllCmtsFlag:=$2
//End case 

//$0:=1  //Initialize to one - There is always one page for culverts.

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
//$bOtherCmts:=(([Inspections]CollisionSuper#"") | ([Inspections]LoadVibSuper#""))
//$bOtherCmts:=$bOtherCmts | ([Inspections]UnderminingTxt#"")

//If ((($bOrientation=False) & ($bGeneral=False) & ($vAllElmts=0) & ($numphotos=0) & (Not($bOtherCmts)))=False)

//G_Insp_FontAlert 

//  //start printing
//C_BLOB(vCmtsAreaCul_;vCmtsArea_)
//C_LONGINT($i;$numpages;$numnewpages;$viNElmts)
//C_LONGINT($mainarea)
//C_TEXT($vElmTitle)  // Command Replaced was o_C_STRING length was 132

//  //create main offscreen area
//$mainarea:=WR New offscreen area 
//WR UPDATE MODE ($mainarea;0)  //turn off updating
//  //Set Doc Margins ($mainarea;4.1)  `paper ht for culvert cmts page
//Set Doc Margins ($mainarea)  //paper ht for culvert cmts page
//  //following settings to make 1st page different than others.
//WR SET DOC PROPERTY ($mainarea;wr different on first page;1)
//WR SET DOC PROPERTY ($mainarea;wr view first page header;0)
//WR SET DOC PROPERTY ($mainarea;wr view first page footer;0)
//WR SET DOC PROPERTY ($mainarea;wr first page top margin;0)
//WR SET DOC PROPERTY ($mainarea;wr first page bottom margin;(9.15-4.1))
//WR SET DOC PROPERTY ($mainarea;wr header 1st page top margin;0)
//WR SET DOC PROPERTY ($mainarea;wr header 1st page bottom mg;0)
//WR SET DOC PROPERTY ($mainarea;wr footer 1st page top margin;0)
//WR SET DOC PROPERTY ($mainarea;wr footer 1st page bottom mg;0)
//SET CURSOR(4)
//vbTopOfPage:=True  //say we start from top of page

//If ($bOrientation)
//G_Insp_AddOrientation ($mainarea)
//End if 

//If ($bGeneral)
//G_Insp_AddGenCmts ($mainarea)
//End if 

//  //       if element comments
//  //order is item62,  underm, coll, load vib, 61, app,traff
//  //DBD 01/10/03 Added Section for N62
//COPY NAMED SELECTION([ElementsSafety];"BlobElmts")
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="N62")

//$viNElmts:=Records in selection([ElementsSafety])
//Case of 
//: ($viNElmts>0)
//G_AddHeader ("N62")
//: ([Inspections]UnderminingTxt#"")
//G_AddHeader ("N62")
//: ([Inspections]CollisionSuper#"")
//G_AddHeader ("N62")
//: ([Inspections]LoadVibSuper#"")
//G_AddHeader ("N62")
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
//If ([Inspections]UnderminingTxt#"")
//G_addItemtoWr ($mainarea;"Undermining Notes";[Inspections]UnderminingTxt)
//vbTopOfPage:=False  //we have added something to the page   
//End if 
//If ([Inspections]CollisionSuper#"")
//G_addItemtoWr ($mainarea;"Collision Notes";[Inspections]CollisionSuper)
//vbTopOfPage:=False  //we have added something to the page   
//End if 
//If ([Inspections]LoadVibSuper#"")
//G_addItemtoWr ($mainarea;"Load Vibration Notes";[Inspections]LoadVibSuper)
//vbTopOfPage:=False  //we have added something to the page   
//End if 
//USE NAMED SELECTION("BlobElmts")
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="N61")
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
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="APP")
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
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="TRA")
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
//$numnewpages:=WR Count ($mainarea;wr nb pages)
//G_ApplySheet ($mainarea;1)
//End while 
//  //maybe we do maybe we dont't know why we do not need to delete the last line feed
//WR BACKSPACE ($mainarea)
//$numpages:=WR Count ($mainarea;wr nb pages)
//sBDEPT1:=sBDEPT
//WR UPDATE MODE ($mainarea;1)  //updating back on 
//If ((PrintFlag) & ($bViewAllCmtsFlag=False))

//C_BOOLEAN($NewMethod_b)
//$NewMethod_b:=(User in group(Current user;"Design Access Group") | <>pref_New4DWR)
//If (Not(INSP_CreatePDFsofApproved_B))
//If (User in group(Current user;"Design Access Group"))
//CONFIRM(" Design Access Group use new comments print method ?";"New";"BuildPreview")
//$NewMethod_b:=(OK=1)
//End if 
//End if 
//If ($NewMethod_b)
//Insp_PrintRemarks ($mainarea;"Culvert Pr Pg 2 wr")
//Else 
//  //MODS_XXXX_CM
//C_PICTURE(CommentsPrevw_P)
//For ($i;1;$numpages)
//C_LONGINT($printht)
//CommentsPrevw_P:=WR Build preview ($mainarea;$i)
//PAGE BREAK(>)
//If ($i=1)
//  //If (<>PL_LPlatfrm=Windows)
//  //CommentsPrevw_P:=CommentsPrevw_P*0.75
//  //End if 
//  //$printht:=Print form([Inspections];"CulvertCmtsPrint")
//$printht:=Print form([Inspections];"Culvert Pr Pg 2")

//Else 
//$printht:=Print form([Inspections];"CmtsPrint")
//End if 
//If (viInspPreviewErr#0)  //exit if preview error
//$i:=$numpages+1
//End if 

//End for 
//CommentsPrevw_P:=CommentsPrevw_P*0

//End if 

//End if   //If Printflag

//  //added 4/1/04
//If ($bViewAllCmtsFlag)
//INSP_ViewAllComments ($mainarea)
//End if 

//$0:=$numpages
//  //delete the main offscreen area
//WR DELETE OFFSCREEN AREA ($mainarea)
//  //reduce the blob size to zero
//SET BLOB SIZE(vCmtsAreaCul_;0)
//SET BLOB SIZE(vCmtsArea_;0)
//SET CURSOR

//Else 
//If (PrintFlag)
//sBDEPT1:=sBDEPT
//C_PICTURE(CommentsPrevw_P)
//CommentsPrevw_P:=CommentsPrevw_P*0
//Print form([Inspections];"Culvert Pr Pg 2")  //MODS_XXXX_CM

//End if 
//End if   //if any comments printed
//INSP_ElmtDescUtil ("CLEAR")

//USE NAMED SELECTION("ElmtsInUse")
//CLEAR NAMED SELECTION("ElmtsInUse")