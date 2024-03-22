//%attributes = {"invisible":true}
//Method: Print_Tunnel_Cmts_wp
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/02/13, 14:13:37
	// ----------------------------------------------------
	//Created : 
	Mods_2013_05
	// Modified by: Costas Manousakis-(Designer)-(9/26/13 15:38:51)
	Mods_2013_09
	//  `added checking for and printing comments in tunnel collision fields
	// Modified by: Costas Manousakis-(Designer)-(9/28/16 16:32:36)
	Mods_2016_09
	//  `added temp call to Insp_PrintRemarks when user is design access
	// Modified by: Costas Manousakis-(Designer)-(10/7/16 16:52:58)
	Mods_2016_10
	//  `call to Insp_PrintRemarks when  ◊pref_New4DWR is true
	// Modified by: Costas Manousakis-(Designer)-(10/25/16 14:47:31)
	Mods_2016_10
	//  `allow designer to pick option of printing method
	Mods_2021_01  //Add code that will create PDFs of all [Inspections]InspApproved=2
	Mods_2021_Delete
End if 
//  //
//C_LONGINT($0)  //return number of pages printed.
//C_BOOLEAN($1;$2)
//C_BOOLEAN($bGeneral;$bOtherCmts)
//C_LONGINT($vAllElmts)
//C_BOOLEAN(vbTopOfPage)  //Indicate Top of page
//C_BOOLEAN(PrintFlag;$bViewAllCmtsFlag)
//C_LONGINT(viInspPreviewErr)  //Command Replaced was o_C_INTEGER
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
//$bOtherCmts:=([Inspections]CollisionSuper#"")
//$bOtherCmts:=$bOtherCmts | ([TunnelInspection]StructuralCollisionComments_txt#"")
//$bOtherCmts:=$bOtherCmts | ([TunnelInspection]RoadwayCollisionComments_txt#"")

//If ((($bOrientation=False) & ($bGeneral=False) & ($vAllElmts=0) & ($numphotos=0) & (Not($bOtherCmts)))=False)

//G_Insp_FontAlert 

//  //start printing
//C_BLOB(vCmtsArea_)
//C_LONGINT($i;$numpages;$numnewpages;$viNElmts)
//C_LONGINT($mainarea)
//C_TEXT($vElmTitle)  // Command Replaced was o_C_STRING length was 132

//  //create main offscreen area
//$mainarea:=WR New offscreen area 
//  //WR UPDATE MODE ($mainarea;0)  `turn off updating
//Set Doc Margins ($mainarea)
//  //````    `````    `````    `````    `````    `````    `````    `````  
//SET CURSOR(4)
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
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="STR")
//$viNElmts:=Records in selection([ElementsSafety])
//Case of 
//: ($viNElmts>0)
//G_AddHeader ("STR")
//: ([TunnelInspection]StructuralCollisionComments_txt#"")
//G_AddHeader ("STR")
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
//If ([TunnelInspection]StructuralCollisionComments_txt#"")
//G_addItemtoWr ($mainarea;"Structural Collision Damage Notes";[TunnelInspection]StructuralCollisionComments_txt)
//vbTopOfPage:=False  //we have added something to the page
//End if 


//USE NAMED SELECTION("BlobElmts")
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="ROA")
//$viNElmts:=Records in selection([ElementsSafety])
//Case of 
//: ($viNElmts>0)
//G_AddHeader ("ROA")
//: ([TunnelInspection]RoadwayCollisionComments_txt#"")
//G_AddHeader ("ROA")
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
//If ([TunnelInspection]RoadwayCollisionComments_txt#"")
//G_addItemtoWr ($mainarea;"Roadway Collision Damage Notes";[TunnelInspection]RoadwayCollisionComments_txt)
//vbTopOfPage:=False  //we have added something to the page
//End if 


//USE NAMED SELECTION("BlobElmts")
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="CEI")
//$viNElmts:=Records in selection([ElementsSafety])
//Case of 
//: ($viNElmts>0)
//G_AddHeader ("CEI")
//: ([Inspections]CollisionSuper#"")
//G_AddHeader ("CEI")
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
//G_addItemtoWr ($mainarea;"Overhead Collision Damage Notes";[Inspections]CollisionSuper)
//vbTopOfPage:=False  //we have added something to the page
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

//USE NAMED SELECTION("BlobElmts")
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="SUP")
//$viNElmts:=Records in selection([ElementsSafety])
//If ($viNElmts>0)
//Insp_SortElmtSfty 
//G_AddHeader ("SUP")
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
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="CRO")
//$viNElmts:=Records in selection([ElementsSafety])
//If ($viNElmts>0)

//Insp_SortElmtSfty 
//G_AddHeader ("CRO")

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
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="EGR")
//$viNElmts:=Records in selection([ElementsSafety])
//If ($viNElmts>0)
//Insp_SortElmtSfty 
//G_AddHeader ("EGR")
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
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="UTI")
//  //ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>)
//$viNElmts:=Records in selection([ElementsSafety])
//If ($viNElmts>0)
//Insp_SortElmtSfty 
//G_AddHeader ("UTI")

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
//QUERY SELECTION([ElementsSafety];[ElementDict]Category="WET")
//$viNElmts:=Records in selection([ElementsSafety])
//If ($viNElmts>0)
//Insp_SortElmtSfty 
//G_AddHeader ("WET")

//FIRST RECORD([ElementsSafety])
//For ($i;1;$viNElmts)
//  //RELATE ONE([ElementsSafety]ElementNo)
//$vElmTitle:=G_GetElmtLabel (True)
//G_AddElmtTxt2Area ($mainarea;$vElmTitle)
//vbTopOfPage:=False  //we have added something to the page
//NEXT RECORD([ElementsSafety])
//End for 
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
//End while 
//  //maybe we do maybe we dont't know why we do not need to delete the last line feed
//WR BACKSPACE ($mainarea)
//$numpages:=WR Count ($mainarea;wr nb pages)
//sBDEPT1:=sBDEPT
//WR UPDATE MODE ($mainarea;1)  //updating back on 

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
//  //End Print_Tunnel_Cmts