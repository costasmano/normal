//%attributes = {"invisible":true}
//Project Method : Print_Dive_Cmt_a_new
//
//Print inspection report pages with comments from
//the inspection report and the elements included. At the end add
// an index of any photos and sketches attached to this inspection.
//
If (False:C215)
	//4D WRITE Version...
	
	Mods_2004_CM11
	Mods_2004_CM12
	Mods_2005_CM01
	// Modified by: costasmanousakis-(Designer)-(11/10/2006 19:44:46)
	Mods_2007_CM04
	// Modified by: costasmanousakis-(Designer)-(12/20/07 12:34:14)
	Mods_2007_CM_5401
	//  `Use the ◊ELMTDICT_@ arrays instead of relations
	// Modified by: costasmanousakis-(Designer)-(3/10/09 10:35:06)
	Mods_2009_03
	//Use method INSP_ElmtDescUtil to load arrays used in labels of parent elements
	Mods_2011_06  // CJ Miller`06/13/11, 16:45:35      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(12/27/12 11:37:09)
	Mods_2012_12
	//  ` Clear picture var CommentsPrevw_P when done printing
	// Modified by: Costas Manousakis-(Designer)-(1/3/13 11:11:46)
	Mods_2013_01
	//  `Use new method Insp_SortElmtSfty
	// Modified by: Costas Manousakis-(Designer)-(5/6/13 14:17:58)
	Mods_2013_05
	//  `added check  for Tunnel Special  and Overhead, Rail  Special, Other inspection types when checking if comments were printed on page 1.
	Mods_2013_05  //r003 `  Modify length that can fit in remarks based upon inspection type
	//Modified by: Charles Miller (5/7/13 16:41:56)
	// Modified by: Costas Manousakis-(Designer)-(1/6/15 17:14:04)
	Mods_2015_01
	//  `added TDA : tunnel damage
	// Modified by: Costas Manousakis-(Designer)-(2/13/15 11:54:05)
	Mods_2015_02
	//  `added  TOT: tunnel  other
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
	//  `when adding Element comments delete the last char if it is a carr.ret
	//  `and  apply stylesheet 1 when adding linefeeds at the end  -  CallReference #655
	Mods_2021_01  //Add code that will create PDFs of all [Inspections]InspApproved=2
	Mods_2021_Delete
End if 

//C_LONGINT($0)  // **replaced _ o _C_INTEGER()
//C_BOOLEAN($1;$2;INSP_CreatePDFsofApproved_B)
//C_BOOLEAN($bGeneral)
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
//Insp_SortElmtSfty 

//$vAllElmts:=Records in selection([ElementsSafety])

//C_LONGINT($numphotos)
//$numphotos:=Records in selection([Standard Photos])

//C_BOOLEAN($bOrientation)
//$bOrientation:=((BLOB size([Inspections]OrientationText)>0) & (f_Insp_Revision1 ([Inspections]Insp Date)))

//$bGeneral:=(BLOB size([Inspections]InspComments)>0)
//If (($bGeneral) & ([Inspections]Insp Type="DAM"))
//If (Not(f_Insp_Revision1 ([Inspections]Insp Date)))  //only check this for inspections before DATE_1
//$temparea:=WR New offscreen area 
//WR INSERT STYLED TEXT ($temparea;[Inspections]InspComments)
//WR EXECUTE COMMAND ($temparea;wr cmd select all)
//$count:=WR Count ($temparea;wr nb characters)
//WR DELETE OFFSCREEN AREA ($temparea)
//$bGeneral:=($count>=350)
//End if 
//End if 

//If (($bOrientation) | ($bGeneral) | ($vAllElmts>0) | ($numphotos>0))

//  //G_Insp_FontAlert 

//  //start printing
//C_BLOB(vCmtsArea_)
//C_LONGINT($i;$numpages;$numnewpages)
//C_LONGINT($mainarea;$temparea;$count)
//C_TEXT($vElmTitle)  // **Replaced old C_STRING length 132

//  //create main offscreen area
//$mainarea:=WR New offscreen area 
//WR UPDATE MODE ($mainarea;0)  //turn off updating
//Set Doc Margins ($mainarea)

//SET CURSOR(4)
//vbTopOfPage:=True  //say we start from top of page

//If ($bOrientation)
//G_Insp_AddOrientation ($mainarea)
//End if 

//If ($bGeneral)
//G_Insp_AddGenCmts ($mainarea)
//End if 
//C_LONGINT($ReturnLengthLimit_L)
//$ReturnLengthLimit_L:=INSP_ReturnCMLength 

//  //       if element comments
//If ($vAllelmts>0)
//C_TEXT($vsElmtCatPrev)  // **Replaced old C_STRING length 3
//FIRST RECORD([ElementsSafety])
//$vsElmtCatPrev:=""
//C_LONGINT($ElmIndx_L)
//For ($i;1;$vAllelmts)
//$ElmIndx_L:=Find in array(<>ELMTDICT_ELNum_ai;[ElementsSafety]ElementNo)
//  //RELATE ONE([ElementsSafety]ElementNo)
//$temparea:=WR New offscreen area 
//WR INSERT STYLED TEXT ($temparea;[ElementsSafety]ElmComments)
//C_BOOLEAN($bug655)
//$bug655:=True
//If ($bug655)
//  // remove the last char only if it is a carriage return.
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

//WR EXECUTE COMMAND ($temparea;wr cmd select all)
//$count:=WR Count ($temparea;wr nb characters)
//WR DELETE OFFSCREEN AREA ($temparea)
//  //If the letter count is greater than XX then it was
//  //printed on the 1st page
//If (($count>=$ReturnLengthLimit_L) | (([Inspections]Insp Type#"TOV") & ([Inspections]Insp Type#"DVS") & ([Inspections]Insp Type#"DAM") & ([Inspections]Insp Type#"FCR") & ([Inspections]Insp Type#"CMI") & ([Inspections]Insp Type#"RRS") & ([Inspections]Insp Type#"TSP") & ([Inspections]Insp Type#"TOT") & ([Inspections]Insp Type#"TDA") & ([Inspections]Insp Type#"OTH") & ([Inspections]Insp Type#"RRO")))
//If (<>ELMTDICT_Cat_as{$ElmIndx_L}#$vsElmtCatPrev)  //Add a header when we change element categories
//G_AddHeader (<>ELMTDICT_Cat_as{$ElmIndx_L})
//$vsElmtCatPrev:=<>ELMTDICT_Cat_as{$ElmIndx_L}
//End if 
//$vElmTitle:=G_GetElmtLabel (True)
//G_AddElmtTxt2Area ($mainarea;$vElmTitle)
//vbTopOfPage:=False  //we have added something to the page
//End if 
//NEXT RECORD([ElementsSafety])
//End for 

//End if 

//If ($numphotos>0)
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
//$bug655:=True
//If ($bug655)
//G_ApplySheet ($mainarea;1)
//End if 

//$numnewpages:=WR Count ($mainarea;wr nb pages)
//End while 
//  //maybe we do maybe we dont't know why we do not need to delete the last line feed
//WR BACKSPACE ($mainarea)
//$numpages:=WR Count ($mainarea;wr nb pages)
//WR UPDATE MODE ($mainarea;1)  //turn on updating

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

//End if   //if Printflag and not(previewerror)

//  //added 4/1/04
//If ($bViewAllCmtsFlag) & (Not(INSP_CreatePDFsofApproved_B))
//INSP_ViewAllComments ($mainarea)  //MODS_XXXX_CM
//End if 

//$0:=$numpages
//End if   //if count of chars > 0
//  //delete the main offscreen area
//WR DELETE OFFSCREEN AREA ($mainarea)
//SET CURSOR

//End if 
//INSP_ElmtDescUtil ("CLEAR")

//USE NAMED SELECTION("ElmtsInUse")
//CLEAR NAMED SELECTION("ElmtsInUse")