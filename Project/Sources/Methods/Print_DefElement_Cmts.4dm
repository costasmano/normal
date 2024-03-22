//%attributes = {"invisible":true}
If (False:C215)
	//Project Method : Print_DefElement_Cmts
	//
	//Copied from Print_RTN_Cmts
	//
	//4D WRITE Version...
	
	Mods_2004_CM03
	Mods_2004_CM12
	Mods_2005_CM16
	
	// Modified by: costasmanousakis-(Designer)-(1/11/2007 12:41:12)
	Mods_2007_CM04
	// Modified by: costasmanousakis-(Designer)-(12/20/07 12:34:54)
	Mods_2007_CM_5401
	//  `Use the ◊ELMTDICT_@ arrays instead of relate many
	Mods_2011_06  // CJ Miller`06/14/11, 10:42:00      ` Type all local variables for v11
	Mods_2021_Delete
End if 
//C_LONGINT($0;$numpages;$picW;$picH;$ht)
//C_BOOLEAN($bGeneral;$bOtherCmts)
//C_LONGINT($vAllElmts)
//C_BOOLEAN(vbTopOfPage)  //Indicate Top of page
//C_LONGINT(viInspPreviewErr)  //Command Replaced was o_C_INTEGER
//C_LONGINT(INSP_PrevElmtParntID)
//INSP_PrevElmtParntID:=0

//$numpages:=0  //initialize to zero
//SET QUERY DESTINATION(Into variable;$vAllElmts)
//QUERY SELECTION([ElementsSafety];[ElementsSafety]Comment Flag=True)
//SET QUERY DESTINATION(Into current selection)
//COPY NAMED SELECTION([ElementsSafety];"ElmtsInUse")

//If ($vAllElmts>0)
//PAGE BREAK(>)
//  //start printing
//C_LONGINT($i;$numpages;$numnewpages;$viNElmts)
//C_LONGINT($mainarea)
//C_TEXT($vElmTitle)  // Command Replaced was o_C_STRING length was 132

//  //```````````create main offscreen area
//$mainarea:=WR New offscreen area 
//  //WR UPDATE MODE ($mainarea;0)  `turn off updating
//Set Doc Margins ($mainarea)
//  //````    `````    `````    `````    `````    `````    `````    `````  
//SET CURSOR(4)
//vbTopOfPage:=True  //say we start from top of page

//C_LONGINT($CurrInspID)
//$CurrInspID:=0
//For ($i;1;$vAllElmts)
//GOTO SELECTED RECORD([ElementsSafety];$i)
//If ([ElementsSafety]Comment Flag)
//If ([ElementsSafety]InspID#$CurrInspID)
//QUERY([Inspections];[Inspections]InspID=[ElementsSafety]InspID)
//RELATE ONE([Inspections]Insp Type)
//$vElmTitle:=[Inspection Type]Description
//If ([Inspections]InspRtnSpcMemFlag)
//$vElmTitle:=$vElmTitle+" & Special Member"
//End if 
//$vElmTitle:=$vElmTitle+" - "+String([Inspections]Insp Date;Internal date short)+<>sCR+<>sCR
//$vElmTitle:=Uppercase($vElmTitle)
//$CurrInspID:=[ElementsSafety]InspID
//Else 
//$vElmTitle:=""
//End if 
//  //RELATE ONE([ElementsSafety]ElementNo)
//$vElmTitle:=$vElmTitle+G_GetElmtLabel (True)
//G_AddElmtTxt2Area ($mainarea;$vElmTitle)
//vbTopOfPage:=False  //we have added something to the page
//End if 
//End for 

//$numpages:=WR Count ($mainarea;wr nb pages)
//WR UPDATE MODE ($mainarea;1)  //updating back on 

//  //print the form once for each page...      
//For ($i;1;$numpages)
//  // Modified by: costasmanousakis-(Designer)-(6/23/2005 17:51:44)
//WR SET AREA PROPERTY ($mainarea;wr fixed print size;0;"")
//C_PICTURE(WrtPreview)
//WrtPreview:=WR Build preview ($mainarea;$i)
//PICTURE PROPERTIES(WrtPreview;$picW;$picH)
//$ht:=Print form([ElementsSafety];"Rpt DefElem Comments2")
//WrtPreview:=WrtPreview*0  //zero the pict var
//If ($i#$numpages)
//PAGE BREAK(>)
//End if 

//If (viInspPreviewErr#0)
//  //exit if preview error
//$i:=$numpages+1
//End if 
//End for 

//  //delete the main offscreen area
//WR DELETE OFFSCREEN AREA ($mainarea)
//SET CURSOR

//End if 

//$0:=$numpages
//CLEAR NAMED SELECTION("ElmtsInUse")