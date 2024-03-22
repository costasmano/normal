//%attributes = {"invisible":true}
//Method: Print_Tunnel_Cmts_WP
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/28/21, 18:44:27
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_LONGINT:C283(Print_Tunnel_Cmts_WP; $0)
	C_OBJECT:C1216(Print_Tunnel_Cmts_WP; $1)
	
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
C_LONGINT:C283(viInspPreviewErr)  //Command Replaced was o_C_INTEGER
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
$bOtherCmts:=([Inspections:27]CollisionSuper:98#"")
$bOtherCmts:=$bOtherCmts | ([TunnelInspection:152]StructuralCollisionComments_txt:28#"")
$bOtherCmts:=$bOtherCmts | ([TunnelInspection:152]RoadwayCollisionComments_txt:30#"")

If ((($bOrientation=False:C215) & ($bGeneral=False:C215) & ($vAllElmts=0) & ($numphotos=0) & (Not:C34($bOtherCmts)))=False:C215)
	
	G_Insp_FontAlert
	
	//start printing
	C_LONGINT:C283($i; $numpages; $numnewpages; $viNElmts)
	C_TEXT:C284($vElmTitle)  // Command Replaced was o_C_STRING length was 132
	
	//create main write pro area
	C_OBJECT:C1216($WPArea_)
	$WPArea_:=INSP_InitializeWPArea
	//````    `````    `````    `````    `````    `````    `````    `````  
	
	If ($bOrientation)
		G_Insp_AddOrientation_WP($WPArea_)
	End if 
	
	If ($bGeneral)
		G_Insp_AddGenCmts_WP($WPArea_)
	End if 
	
	//       if element comments
	//order is item58,app,over,59,sup drops,sub, substr props, 61, traff
	COPY NAMED SELECTION:C331([ElementsSafety:29]; "BlobElmts")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="STR")
	$viNElmts:=Records in selection:C76([ElementsSafety:29])
	Case of 
		: ($viNElmts>0)
			G_AddHeader("STR")
		: ([TunnelInspection:152]StructuralCollisionComments_txt:28#"")
			G_AddHeader("STR")
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
	If ([TunnelInspection:152]StructuralCollisionComments_txt:28#"")
		INSP_AddTextToArea_WP($WPArea_; "Structural Collision Damage Notes"; [TunnelInspection:152]StructuralCollisionComments_txt:28)
		
	End if 
	
	
	USE NAMED SELECTION:C332("BlobElmts")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="ROA")
	$viNElmts:=Records in selection:C76([ElementsSafety:29])
	Case of 
		: ($viNElmts>0)
			G_AddHeader("ROA")
		: ([TunnelInspection:152]RoadwayCollisionComments_txt:30#"")
			G_AddHeader("ROA")
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
	If ([TunnelInspection:152]RoadwayCollisionComments_txt:30#"")
		INSP_AddTextToArea_WP($WPArea_; "Roadway Collision Damage Notes"; [TunnelInspection:152]RoadwayCollisionComments_txt:30)
		
	End if 
	
	
	USE NAMED SELECTION:C332("BlobElmts")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="CEI")
	$viNElmts:=Records in selection:C76([ElementsSafety:29])
	Case of 
		: ($viNElmts>0)
			G_AddHeader("CEI")
		: ([Inspections:27]CollisionSuper:98#"")
			G_AddHeader("CEI")
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
		INSP_AddTextToArea_WP($WPArea_; "Overhead Collision Damage Notes"; [Inspections:27]CollisionSuper:98)
		
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
	
	USE NAMED SELECTION:C332("BlobElmts")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="SUP")
	$viNElmts:=Records in selection:C76([ElementsSafety:29])
	If ($viNElmts>0)
		Insp_SortElmtSfty
		G_AddHeader("SUP")
		FIRST RECORD:C50([ElementsSafety:29])
		For ($i; 1; $viNElmts)
			//RELATE ONE([ElementsSafety]ElementNo)
			$vElmTitle:=G_GetElmtLabel(True:C214)
			G_AddElmtTxt2Area_WP($WPArea_; $vElmTitle; [ElementsSafety:29]ElmComments:23)
			
			NEXT RECORD:C51([ElementsSafety:29])
		End for 
	End if 
	
	USE NAMED SELECTION:C332("BlobElmts")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="CRO")
	$viNElmts:=Records in selection:C76([ElementsSafety:29])
	If ($viNElmts>0)
		
		Insp_SortElmtSfty
		G_AddHeader("CRO")
		
		FIRST RECORD:C50([ElementsSafety:29])
		For ($i; 1; $viNElmts)
			//RELATE ONE([ElementsSafety]ElementNo)
			$vElmTitle:=G_GetElmtLabel(True:C214)
			G_AddElmtTxt2Area_WP($WPArea_; $vElmTitle; [ElementsSafety:29]ElmComments:23)
			
			NEXT RECORD:C51([ElementsSafety:29])
		End for 
	End if 
	
	USE NAMED SELECTION:C332("BlobElmts")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="EGR")
	$viNElmts:=Records in selection:C76([ElementsSafety:29])
	If ($viNElmts>0)
		Insp_SortElmtSfty
		G_AddHeader("EGR")
		FIRST RECORD:C50([ElementsSafety:29])
		For ($i; 1; $viNElmts)
			//RELATE ONE([ElementsSafety]ElementNo)
			$vElmTitle:=G_GetElmtLabel(True:C214)
			G_AddElmtTxt2Area_WP($WPArea_; $vElmTitle; [ElementsSafety:29]ElmComments:23)
			
			NEXT RECORD:C51([ElementsSafety:29])
		End for 
	End if 
	
	USE NAMED SELECTION:C332("BlobElmts")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="UTI")
	//ORDER BY FORMULA([ElementsSafety];[ElementDict]Category;>;(GetElmtNumber );>)
	$viNElmts:=Records in selection:C76([ElementsSafety:29])
	If ($viNElmts>0)
		Insp_SortElmtSfty
		G_AddHeader("UTI")
		
		FIRST RECORD:C50([ElementsSafety:29])
		For ($i; 1; $viNElmts)
			//RELATE ONE([ElementsSafety]ElementNo)
			$vElmTitle:=G_GetElmtLabel(True:C214)
			G_AddElmtTxt2Area_WP($WPArea_; $vElmTitle; [ElementsSafety:29]ElmComments:23)
			
			NEXT RECORD:C51([ElementsSafety:29])
		End for 
	End if 
	
	USE NAMED SELECTION:C332("BlobElmts")
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementDict:30]Category:3="WET")
	$viNElmts:=Records in selection:C76([ElementsSafety:29])
	If ($viNElmts>0)
		Insp_SortElmtSfty
		G_AddHeader("WET")
		
		FIRST RECORD:C50([ElementsSafety:29])
		For ($i; 1; $viNElmts)
			//RELATE ONE([ElementsSafety]ElementNo)
			$vElmTitle:=G_GetElmtLabel(True:C214)
			G_AddElmtTxt2Area_WP($WPArea_; $vElmTitle; [ElementsSafety:29]ElmComments:23)
			
			NEXT RECORD:C51([ElementsSafety:29])
		End for 
	End if 
	
	CLEAR NAMED SELECTION:C333("BlobElmts")
	
	If ($numphotos>0)
		// get photo titles in array
		G_CreateImageLog_WP($WPArea_)
		
	End if 
	
	$numpages:=WP Get page count:C1412($WPArea_)
	sBDEPT1:=sBDEPT
	
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
//End Print_Tunnel_Cmts_WP