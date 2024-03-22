//%attributes = {"invisible":true}
// Method: INSP_FRZ_PrintCmts
// Description
// Parameters
// $0 : $NumPages_L
// $1 : $PrintFlag_b
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/22/09, 19:15:23
	// ----------------------------------------------------
	
	Mods_2009_CM_5404  // --- "FREEZETHAW"
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(12/27/12 11:37:09)
	Mods_2012_12
	//  ` Clear picture var CommentsPrevw_P when done printing
	// Modified by: Costas Manousakis-(Designer)-(2/18/14 14:32:47)
	Mods_2014_02
	//  `Freeze thaw New Version
	// Modified by: Costas Manousakis-(Designer)-(6/17/14 16:20:47)
	Mods_2014_06_bug
	//  `Added code to print the Orientation text if it does not fit on page 1
	// Modified by: Costas Manousakis-(Designer)-(9/28/16 16:32:36)
	Mods_2016_09
	//  `added temp call to Insp_PrintRemarks when user is design access
	// Modified by: Costas Manousakis-(Designer)-(10/7/16 16:52:58)
	Mods_2016_10
	//  `call to Insp_PrintRemarks when  ◊pref_New4DWR is true
	// Modified by: Costas Manousakis-(Designer)-(10/25/16 14:47:31)
	Mods_2016_10
	//  `allow designer to pick option of printing
	Mods_2021_01  //Add code that will create PDFs of all [Inspections]InspApproved=2
	Mods_2021_Delete
End if 
//C_BOOLEAN(PrintFlag)
//C_LONGINT($0;$numpages)
//If (Count parameters>0)
//C_BOOLEAN($1)
//PrintFlag:=$1
//Else 
//PrintFlag:=True
//End if 

//C_BLOB(vCmtsArea_)
//C_LONGINT($i;$numpages;$numnewpages)
//C_LONGINT($mainarea;$temparea;$count)
//C_TEXT($vElmTitle)  // Command Replaced was o_C_STRING length was 132
//C_LONGINT($numphotos;$printht)
//$numphotos:=Records in selection([Standard Photos])
//$numpages:=0
//  //create main offscreen area
//$mainarea:=WR New offscreen area 
//WR UPDATE MODE ($mainarea;0)  //turn off updating
//Set Doc Margins ($mainarea)

//SET CURSOR(4)
//vbTopOfPage:=True  //say we start from top of page
//If ([Inspections]Insp Date<<>InspFormRevDate_7)
//Else 

//If (Not(FRZ_OrientationOnPg1_b))
//WR SET TEXT PROPERTY ($mainarea;wr bold;1)
//WR SET TEXT PROPERTY ($mainarea;wr underline;1)
//WR INSERT TEXT ($mainarea;("Orientation"+<>sCR))
//WR EXECUTE COMMAND ($mainarea;wr cmd plain)
//WR INSERT TEXT ($mainarea;[Inspections]UnderminingTxt+<>sCR)
//WR EXECUTE COMMAND ($mainarea;wr cmd plain)
//WR INSERT TEXT ($mainarea;(<>sCR))
//End if 

//End if 

//C_LONGINT($loop)
//For ($loop;1;Size of array(FRZ_CommentsFit_b);2)
//If (FRZ_CommentsFit_b{$Loop} | FRZ_CommentsFit_b{$Loop+1})
//C_TEXT($ElmtDesc_txt)
//GOTO SELECTED RECORD([ElementsSafety];($loop+1)/2)
//Case of 
//: ([ElementsSafety]ElementNo=41)
//$ElmtDesc_txt:="Deck (Underside) / Arch Ring"
//: ([ElementsSafety]ElementNo=42)
//$ElmtDesc_txt:="Beams and Diaphragms"
//: ([ElementsSafety]ElementNo=43)
//$ElmtDesc_txt:="Concrete Piers / Pier Caps / Columns / Abutments"
//: ([ElementsSafety]ElementNo=44)
//$ElmtDesc_txt:="Others (i.e. Parapets, Haunches, Spandrel Walls, etc.)"
//Else 
//$ElmtDesc_txt:=""
//End case 

//WR SET TEXT PROPERTY ($mainarea;wr bold;1)
//WR SET TEXT PROPERTY ($mainarea;wr underline;1)
//WR INSERT TEXT ($mainarea;($ElmtDesc_txt+<>sCR))
//WR EXECUTE COMMAND ($mainarea;wr cmd plain)
//If (FRZ_CommentsFit_b{$Loop})
//BLOB TO VARIABLE([ElementsSafety]ElmComments;$ElmtDesc_txt)
//WR SET TEXT PROPERTY ($mainarea;wr bold;1)
//WR SET TEXT PROPERTY ($mainarea;wr underline;1)
//WR INSERT TEXT ($mainarea;("Problem Areas :"+<>sCR))
//WR EXECUTE COMMAND ($mainarea;wr cmd plain)
//WR INSERT TEXT ($mainarea;($ElmtDesc_txt+<>sCR))
//End if 
//If (FRZ_CommentsFit_b{$Loop+1})
//WR SET TEXT PROPERTY ($mainarea;wr bold;1)
//WR SET TEXT PROPERTY ($mainarea;wr underline;1)

//If ([Inspections]Insp Date<<>InspFormRevDate_7)
//WR INSERT TEXT ($mainarea;("Action Taken :"+<>sCR))
//Else 
//WR INSERT TEXT ($mainarea;("Description :"+<>sCR))
//End if 

//WR EXECUTE COMMAND ($mainarea;wr cmd plain)
//WR INSERT TEXT ($mainarea;([ElementsSafety]Comments+<>sCR))
//End if 
//WR INSERT TEXT ($mainarea;(<>sCR))

//End if 

//End for 

//WR SET SELECTION ($mainarea;(WR Count ($mainarea;wr nb characters)-2);WR Count ($mainarea;wr nb characters))
//WR DELETE SELECTION ($mainarea)

//If ($numphotos>0)
//WR INSERT TEXT ($mainarea;(<>sCR))
//WR INSERT TEXT ($mainarea;(<>sCR))
//  // get photo titles in array
//G_CreateImageLog ($mainarea)
//vbTopOfPage:=False  //we have added something to the page
//End if 

//$count:=WR Count ($mainarea;wr nb characters)
//If ($count>0)
//  //There was something added - not a blank page...
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
//WR UPDATE MODE ($mainarea;1)  //turn on updating

//If ((PrintFlag) & (viInspPreviewErr=0))
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
//$printht:=Print form([Inspections];"CmtsPrint")
//If (viInspPreviewErr#0)
//  //exit if preview error
//$i:=$numpages+1
//End if 

//End for 
//CommentsPrevw_P:=CommentsPrevw_P*0

//End if 

//End if   //if Printflag and not(previewerror)

//$0:=$numpages
//End if   //if count of chars > 0
//  //delete the main offscreen area
//WR DELETE OFFSCREEN AREA ($mainarea)
//SET CURSOR

//$0:=$numpages