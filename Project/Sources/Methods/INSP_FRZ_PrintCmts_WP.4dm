//%attributes = {"invisible":true}
//Method: INSP_FRZ_PrintCmts_WP
//Description
// Print Freeze thaw comments using Write Pro
// Parameters
// $0 : $Numpages_L
// $1 : $PrintFlag_b
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/10/21, 19:00:07
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_LONGINT:C283(INSP_FRZ_PrintCmts_WP; $0)
	C_BOOLEAN:C305(INSP_FRZ_PrintCmts_WP; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(2022-04-22 15:40:35)
	Mods_2022_04
	//  `use method INSP_CountInspImages  
End if 
//

C_BOOLEAN:C305(PrintFlag)
C_LONGINT:C283($0; $numpages)
If (Count parameters:C259>0)
	C_BOOLEAN:C305($1)
	PrintFlag:=$1
Else 
	PrintFlag:=True:C214
End if 

C_OBJECT:C1216($WPArea_)
$WPArea_:=INSP_InitializeWPArea

C_LONGINT:C283($i; $numpages; $numnewpages)
C_LONGINT:C283($mainarea; $temparea; $count)
C_TEXT:C284($vElmTitle)  // Command Replaced was o_C_STRING length was 132
C_LONGINT:C283($numphotos; $printht)
C_OBJECT:C1216($imagecounts_o)
$imagecounts_o:=INSP_CountInspImages
$numphotos:=$imagecounts_o.total
$numpages:=0
//**********`Modified by: Costas Manousakis-(Designer)-(2022-04-22)

If ([Inspections:27]Insp Date:78<<>InspFormRevDate_7)
Else 
	
	If (Not:C34(FRZ_OrientationOnPg1_b))
		INSP_AddTextToArea_WP($WPArea_; "Orientation"; [Inspections:27]UnderminingTxt:102)
	End if 
	
End if 

C_LONGINT:C283($loop)
For ($loop; 1; Size of array:C274(FRZ_CommentsFit_b); 2)
	If (FRZ_CommentsFit_b{$Loop} | FRZ_CommentsFit_b{$Loop+1})
		C_TEXT:C284($ElmtDesc_txt; $Comments_txt; $Sectionname_txt)
		GOTO SELECTED RECORD:C245([ElementsSafety:29]; ($loop+1)/2)
		Case of 
			: ([ElementsSafety:29]ElementNo:1=41)
				$ElmtDesc_txt:="Deck (Underside) / Arch Ring"
			: ([ElementsSafety:29]ElementNo:1=42)
				$ElmtDesc_txt:="Beams and Diaphragms"
			: ([ElementsSafety:29]ElementNo:1=43)
				$ElmtDesc_txt:="Concrete Piers / Pier Caps / Columns / Abutments"
			: ([ElementsSafety:29]ElementNo:1=44)
				$ElmtDesc_txt:="Others (i.e. Parapets, Haunches, Spandrel Walls, etc.)"
			Else 
				$ElmtDesc_txt:=""
		End case 
		
		$ElmtDesc_txt:=$ElmtDesc_txt+<>sCR
		If (FRZ_CommentsFit_b{$Loop})
			BLOB TO VARIABLE:C533([ElementsSafety:29]ElmComments:23; $Comments_txt)
			$Sectionname_txt:=$ElmtDesc_txt+"Problem Areas :"
			INSP_AddTextToArea_WP($WPArea_; $Sectionname_txt; $Comments_txt)
			$ElmtDesc_txt:=""  //don't need the description any more
		End if 
		If (FRZ_CommentsFit_b{$Loop+1})
			//WR SET TEXT PROPERTY ($mainarea;wr bold;1)
			//WR SET TEXT PROPERTY ($mainarea;wr underline;1)
			
			If ([Inspections:27]Insp Date:78<<>InspFormRevDate_7)
				$Sectionname_txt:=$ElmtDesc_txt+"Action Taken :"
			Else 
				$Sectionname_txt:=$ElmtDesc_txt+"Description :"
			End if 
			
			INSP_AddTextToArea_WP($WPArea_; $Sectionname_txt; [ElementsSafety:29]Comments:5)
		End if 
		
	End if 
	
End for 


If ($numphotos>0)
	G_CreateImageLog_WP($WPArea_)
End if 

C_OBJECT:C1216($range)
$range:=WP Text range:C1341($WPArea_; wk start text:K81:165; wk end text:K81:164)

If ($range.start#$range.end)
	//There was something added - not a blank page...
	If (PrintFlag)
		Insp_PrintRemarks_WP($WPArea_)
	End if 
	$numpages:=WP Get page count:C1412($WPArea_)
End if 

$0:=$numpages
//End INSP_FRZ_PrintCmts_WP