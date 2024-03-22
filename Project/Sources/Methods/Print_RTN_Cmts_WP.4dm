//%attributes = {"invisible":true}
//Method: Print_RTN_Cmts_WP
//Description
// Print routine inspection comments with Write Pro
// Parameters
// $0 : $numpages
// $1 : $params_o .printFlag (boolean)  .viewComments (boolean)
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/28/21, 16:52:35
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_LONGINT:C283(Print_RTN_Cmts_WP; $0)
	C_OBJECT:C1216(Print_RTN_Cmts_WP; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(2022-04-22 15:40:35)
	Mods_2022_04
	//  `use method INSP_CountInspImages  
End if 
//

C_LONGINT:C283($0)  //return number of pages printed.

C_BOOLEAN:C305($bGeneral; $bOtherCmts)
C_LONGINT:C283($vAllElmts)
C_BOOLEAN:C305(vbTopOfPage)  //Indicate Top of page
C_BOOLEAN:C305(PrintFlag; $bViewAllCmtsFlag)
C_LONGINT:C283(viInspPreviewErr)  // **replaced _ o _C_INTEGER()
C_LONGINT:C283(INSP_PrevElmtParntID)
INSP_PrevElmtParntID:=0

$0:=0  //initialize to zero
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
$bOtherCmts:=(([Inspections:27]CollisionSuper:98#"") | ([Inspections:27]LoadDeflSuper:99#"") | ([Inspections:27]LoadVibSuper:100#""))
$bOtherCmts:=$bOtherCmts | ([Inspections:27]CollisionSub:101#"")
$bOtherCmts:=$bOtherCmts | ([Inspections:27]UnderminingTxt:102#"")
$bOtherCmts:=$bOtherCmts | ([Inspections:27]ScourTxt:103#"")

If ((($bOrientation=False:C215) & ($bGeneral=False:C215) & ($vAllElmts=0) & ($numphotos=0) & (Not:C34($bOtherCmts)))=False:C215)
	
	G_Insp_FontAlert
	
	//start printing
	C_LONGINT:C283($i; $numpages; $numnewpages; $viNElmts)
	C_TEXT:C284($vElmTitle)  // **Replaced old C_STRING length 132
	
	//create main write pro area
	C_OBJECT:C1216($WPArea_)
	$WPArea_:=INSP_InitializeWPArea
	//````    `````    `````    `````    `````    `````    `````    `````  
	SET CURSOR:C469(4)
	If (PrintFlag | $bViewAllCmtsFlag)
		SHORT_MESSAGE("Assembling Remarks...")
	End if 
	
	If ($bOrientation)
		G_Insp_AddOrientation_WP($WPArea_)
	End if 
	
	If ($bGeneral)
		G_Insp_AddGenCmts_WP($WPArea_)
	End if 
	
	//       if element comments
	//order is item58,app,over,59,sup drops,sub, substr props, 61, traff
	COPY NAMED SELECTION:C331([ElementsSafety:29]; "BlobElmts")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="N58")
	//ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>)
	$viNElmts:=Records in selection:C76([ElementsSafety:29])
	If ($viNElmts>0)
		Insp_SortElmtSfty
		
		G_AddHeader("N58")
		FIRST RECORD:C50([ElementsSafety:29])
		For ($i; 1; $viNElmts)
			//RELATE ONE([ElementsSafety]ElementNo)
			$vElmTitle:=G_GetElmtLabel(True:C214)
			G_AddElmtTxt2Area_WP($WPArea_; $vElmTitle; [ElementsSafety:29]ElmComments:23)
			NEXT RECORD:C51([ElementsSafety:29])
		End for 
	End if 
	USE NAMED SELECTION:C332("BlobElmts")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="APP")
	//ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>)
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
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="OVR")
	//ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>)
	$viNElmts:=Records in selection:C76([ElementsSafety:29])
	If ($viNElmts>0)
		Insp_SortElmtSfty
		G_AddHeader("OVR")
		FIRST RECORD:C50([ElementsSafety:29])
		For ($i; 1; $viNElmts)
			//RELATE ONE([ElementsSafety]ElementNo)
			$vElmTitle:=G_GetElmtLabel(True:C214)
			G_AddElmtTxt2Area_WP($WPArea_; $vElmTitle; [ElementsSafety:29]ElmComments:23)
			NEXT RECORD:C51([ElementsSafety:29])
		End for 
	End if 
	USE NAMED SELECTION:C332("BlobElmts")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="N59")
	//ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>)
	$viNElmts:=Records in selection:C76([ElementsSafety:29])
	Case of 
		: ($viNElmts>0)
			G_AddHeader("N59")
		: ([Inspections:27]CollisionSuper:98#"")
			G_AddHeader("N59")
		: ([Inspections:27]LoadDeflSuper:99#"")
			G_AddHeader("N59")
		: ([Inspections:27]LoadVibSuper:100#"")
			G_AddHeader("N59")
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
	If ([Inspections:27]CollisionSuper:98#"")
		INSP_AddTextToArea_WP($WPArea_; "SuperStructure Collision Notes"; [Inspections:27]CollisionSuper:98)
	End if 
	If ([Inspections:27]LoadDeflSuper:99#"")
		INSP_AddTextToArea_WP($WPArea_; "SuperStructure Load Deflection Notes"; [Inspections:27]LoadDeflSuper:99)
	End if 
	If ([Inspections:27]LoadVibSuper:100#"")
		INSP_AddTextToArea_WP($WPArea_; "SuperStructure Load Vibration Notes"; [Inspections:27]LoadVibSuper:100)
	End if 
	USE NAMED SELECTION:C332("BlobElmts")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="N60")
	//ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>)
	$viNElmts:=Records in selection:C76([ElementsSafety:29])
	Case of 
		: ($viNElmts>0)
			G_AddHeader("N60")
		: ([Inspections:27]CollisionSub:101#"")
			G_AddHeader("N60")
		: ([Inspections:27]UnderminingTxt:102#"")
			G_AddHeader("N60")
		: ([Inspections:27]ScourTxt:103#"")
			G_AddHeader("N60")
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
	If ([Inspections:27]CollisionSub:101#"")
		INSP_AddTextToArea_WP($WPArea_; "SubStructure Collision Notes"; [Inspections:27]CollisionSub:101)
	End if 
	If ([Inspections:27]UnderminingTxt:102#"")
		INSP_AddTextToArea_WP($WPArea_; "SubStructure Undermining Notes"; [Inspections:27]UnderminingTxt:102)
	End if 
	If ([Inspections:27]ScourTxt:103#"")
		INSP_AddTextToArea_WP($WPArea_; "SubStructure Scour Notes"; [Inspections:27]ScourTxt:103)
	End if 
	USE NAMED SELECTION:C332("BlobElmts")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="N61")
	//ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>)
	$viNElmts:=Records in selection:C76([ElementsSafety:29])
	If ($viNElmts>0)
		Insp_SortElmtSfty
		G_AddHeader("N61")
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
	//ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>)
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
		QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="N62")
		$viNElmts:=Records in selection:C76([ElementsSafety:29])
		If ($viNElmts>0)
			Insp_SortElmtSfty
			G_AddHeader("N62")
			
			FIRST RECORD:C50([ElementsSafety:29])
			For ($i; 1; $viNElmts)
				//RELATE ONE([ElementsSafety]ElementNo)
				$vElmTitle:=G_GetElmtLabel(True:C214)
				G_AddElmtTxt2Area_WP($WPArea_; $vElmTitle; [ElementsSafety:29]ElmComments:23)
				NEXT RECORD:C51([ElementsSafety:29])
			End for 
		End if 
		
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
	
	$numpages:=WP Get page count:C1412($WPArea_)
	sBDEPT1:=sBDEPT
	
	If (PrintFlag | $bViewAllCmtsFlag)
		CLOSE WINDOW:C154
	End if 
	
	If ((PrintFlag) & (viInspPreviewErr=0) & ($bViewAllCmtsFlag=False:C215))
		Insp_PrintRemarks_WP($WPArea_)
		
	End if 
	
	If ($bViewAllCmtsFlag)
		INSP_ViewAllComments_WP($WPArea_)
	End if 
	
	$0:=$numpages
	
End if 

INSP_ElmtDescUtil("CLEAR")

USE NAMED SELECTION:C332("ElmtsInUse")
CLEAR NAMED SELECTION:C333("ElmtsInUse")
//End Print_RTN_Cmts_WP