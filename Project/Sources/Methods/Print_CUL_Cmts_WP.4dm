//%attributes = {"invisible":true}
//Method: Print_CUL_Cmts_WP
//Description
// print culvert comments with Write Pro
// Parameters
// $0: $Numpages
// $1 : $params_o .printFlag (boolean)  .viewComments (boolean)
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/24/21, 21:09:23
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_LONGINT:C283(Print_CUL_Cmts_WP; $0)
	C_OBJECT:C1216(Print_CUL_Cmts_WP; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(2022-04-22 15:40:35)
	Mods_2022_04
	//  `use method INSP_CountInspImages  
End if 
//

C_LONGINT:C283($0; $numpages)  //return number of pages printed.
C_BOOLEAN:C305($bGeneral; $bOtherCmts)
C_LONGINT:C283($vAllElmts)
C_BOOLEAN:C305(vbTopOfPage)  //Indicate Top of page
C_BOOLEAN:C305(PrintFlag; $bViewAllCmtsFlag)
C_LONGINT:C283(viInspPreviewErr)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(INSP_PrevElmtParntID)
INSP_PrevElmtParntID:=0

$bViewAllCmtsFlag:=False:C215
If (Count parameters:C259>0)
	C_OBJECT:C1216($1)
	
	Case of 
		: ($1.printFlag=Null:C1517)
		: (Value type:C1509($1.printFlag)#Is boolean:K8:9)
		Else 
			PrintFlag:=$1.printFlag
	End case 
	Case of 
		: ($1.viewComments=Null:C1517)
		: (Value type:C1509($1.viewComments)#Is boolean:K8:9)
		Else 
			$bViewAllCmtsFlag:=$1.viewComments
	End case 
	
End if 

$numpages:=1
$0:=$numpages  //Initialize to one - There is always one page for culverts.

COPY NAMED SELECTION:C331([ElementsSafety:29]; "ElmtsInUse")

G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4)
INSP_ElmtDescUtil("LOAD")

// select only safety elements that have non-blank comments.
QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Comment Flag:6=True:C214)
$vAllElmts:=Records in selection:C76([ElementsSafety:29])

C_LONGINT:C283($numphotos)
C_OBJECT:C1216($imagecounts_o)
$imagecounts_o:=INSP_CountInspImages
$numphotos:=$imagecounts_o.total

C_BOOLEAN:C305($bOrientation)
$bOrientation:=((BLOB size:C605([Inspections:27]OrientationText:204)>0) & (f_Insp_Revision1([Inspections:27]Insp Date:78)))

$bGeneral:=(BLOB size:C605([Inspections:27]InspComments:171)>0)

//check about collision, etc. comments
$bOtherCmts:=(([Inspections:27]CollisionSuper:98#"") | ([Inspections:27]LoadVibSuper:100#""))
$bOtherCmts:=$bOtherCmts | ([Inspections:27]UnderminingTxt:102#"")


If ((($bOrientation=False:C215) & ($bGeneral=False:C215) & ($vAllElmts=0) & ($numphotos=0) & (Not:C34($bOtherCmts)))=False:C215)
	
	G_Insp_FontAlert
	
	//start printing
	C_LONGINT:C283($i; $numpages; $numnewpages; $viNElmts)
	C_TEXT:C284($vElmTitle)  // Command Replaced was o_C_STRING length was 132
	
	//create main write pro area
	C_OBJECT:C1216($WPArea_)
	$WPArea_:=INSP_InitializeWPArea(New object:C1471("templateType"; "culvert"))
	
	If ($bOrientation)
		G_Insp_AddOrientation_WP($WPArea_)
	End if 
	
	If ($bGeneral)
		G_Insp_AddGenCmts_WP($WPArea_)
	End if 
	
	//       if element comments
	//order is item62,  underm, coll, load vib, 61, app,traff
	//DBD 01/10/03 Added Section for N62
	COPY NAMED SELECTION:C331([ElementsSafety:29]; "BlobElmts")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="N62")
	
	$viNElmts:=Records in selection:C76([ElementsSafety:29])
	Case of 
		: ($viNElmts>0)
			G_AddHeader("N62")
		: ([Inspections:27]UnderminingTxt:102#"")
			G_AddHeader("N62")
		: ([Inspections:27]CollisionSuper:98#"")
			G_AddHeader("N62")
		: ([Inspections:27]LoadVibSuper:100#"")
			G_AddHeader("N62")
	End case 
	If ($viNElmts>0)
		
		Insp_SortElmtSfty
		
		FIRST RECORD:C50([ElementsSafety:29])
		For ($i; 1; $viNElmts)
			//RELATE ONE([ElementsSafety]ElementNo)
			$vElmTitle:=G_GetElmtLabel(True:C214)
			G_AddElmtTxt2Area_WP($WPArea_; $vElmTitle; [ElementsSafety:29]ElmComments:23)
			NEXT RECORD:C51([ElementsSafety:29])
		End for 
	End if 
	If ([Inspections:27]UnderminingTxt:102#"")
		INSP_AddTextToArea_WP($WPArea_; "Undermining Notes"; [Inspections:27]UnderminingTxt:102)
	End if 
	If ([Inspections:27]CollisionSuper:98#"")
		INSP_AddTextToArea_WP($WPArea_; "Collision Notes"; [Inspections:27]CollisionSuper:98)
	End if 
	If ([Inspections:27]LoadVibSuper:100#"")
		INSP_AddTextToArea_WP($WPArea_; "Load Vibration Notes"; [Inspections:27]LoadVibSuper:100)
	End if 
	
	USE NAMED SELECTION:C332("BlobElmts")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="N61")
	$viNElmts:=Records in selection:C76([ElementsSafety:29])
	If ($viNElmts>0)
		
		Insp_SortElmtSfty
		
		G_AddHeader("N61")
		FIRST RECORD:C50([ElementsSafety:29])
		For ($i; 1; $viNElmts)
			//RELATE ONE([ElementsSafety]ElementNo)
			$vElmTitle:=G_GetElmtLabel(True:C214)
			G_AddElmtTxt2Area_WP($WPArea_; $vElmTitle; [ElementsSafety:29]ElmComments:23)
			vbTopOfPage:=False:C215  //we have added something to the page   
			NEXT RECORD:C51([ElementsSafety:29])
		End for 
	End if 
	USE NAMED SELECTION:C332("BlobElmts")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="APP")
	$viNElmts:=Records in selection:C76([ElementsSafety:29])
	If ($viNElmts>0)
		
		Insp_SortElmtSfty
		
		G_AddHeader("APP")
		FIRST RECORD:C50([ElementsSafety:29])
		For ($i; 1; $viNElmts)
			//RELATE ONE([ElementsSafety]ElementNo)
			$vElmTitle:=G_GetElmtLabel(True:C214)
			G_AddElmtTxt2Area_WP($WPArea_; $vElmTitle; [ElementsSafety:29]ElmComments:23)
			NEXT RECORD:C51([ElementsSafety:29])
		End for 
	End if 
	USE NAMED SELECTION:C332("BlobElmts")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="TRA")
	$viNElmts:=Records in selection:C76([ElementsSafety:29])
	If ($viNElmts>0)
		
		Insp_SortElmtSfty
		
		G_AddHeader("TRA")
		FIRST RECORD:C50([ElementsSafety:29])
		For ($i; 1; $viNElmts)
			//RELATE ONE([ElementsSafety]ElementNo)
			$vElmTitle:=G_GetElmtLabel(True:C214)
			G_AddElmtTxt2Area_WP($WPArea_; $vElmTitle; [ElementsSafety:29]ElmComments:23)
			NEXT RECORD:C51([ElementsSafety:29])
		End for 
	End if 
	
	If ([Inspections:27]Insp Type:6="RR@")
		
		USE NAMED SELECTION:C332("BlobElmts")
		QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="GEN")
		$viNElmts:=Records in selection:C76([ElementsSafety:29])
		If ($viNElmts>0)
			Insp_SortElmtSfty
			G_AddHeader("GEN")
			
			FIRST RECORD:C50([ElementsSafety:29])
			For ($i; 1; $viNElmts)
				//RELATE ONE([ElementsSafety]ElementNo)
				$vElmTitle:=G_GetElmtLabel(True:C214)
				G_AddElmtTxt2Area_WP($WPArea_; $vElmTitle; [ElementsSafety:29]ElmComments:23)
				NEXT RECORD:C51([ElementsSafety:29])
			End for 
		End if 
		
	End if 
	
	CLEAR NAMED SELECTION:C333("BlobElmts")
	
	If ($numphotos>0)
		// get photo titles in array
		G_CreateImageLog_WP($WPArea_)
	End if 
	
	//WP_SetFontandSize ($WPArea_)
	$numpages:=WP Get page count:C1412($WPArea_)
	
	sBDEPT1:=sBDEPT
	If ((PrintFlag) & ($bViewAllCmtsFlag=False:C215))
		Insp_PrintRemarks_WP($WPArea_; "CulvertPrPg2wp")
	End if   //If Printflag
	
	If ($bViewAllCmtsFlag)
		INSP_ViewAllComments_WP($WPArea_)
	End if 
	
	$0:=$numpages
	
Else 
	If (PrintFlag)
		sBDEPT1:=sBDEPT
		C_PICTURE:C286(CommentsPrevw_P)
		CommentsPrevw_P:=CommentsPrevw_P*0
		Print form:C5([Inspections:27]; "Culvert Pr Pg 2")  //print a page 2 without comments
		
	End if 
End if   //if any comments printed
INSP_ElmtDescUtil("CLEAR")

USE NAMED SELECTION:C332("ElmtsInUse")
CLEAR NAMED SELECTION:C333("ElmtsInUse")
//End Print_CUL_Cmts_WP