//%attributes = {"invisible":true}
If (False:C215)
	//G_SetInspFont 
	Mods_2004_CM11
	Mods_2005_CM01
	Mods_2009_03  //CJM  r001   `03/06/09, 14:09:12`Upgrade from open form window to open window
	Mods_2011_06  // CJ Miller`06/13/11, 16:50:21      ` Type all local variables for v11
	// Modified by: costasmanousakis-(Designer)-(11/2/11 16:07:06)
	Mods_2011_11
	//  `Made sure that the font is Arial if not Geneva or Times New Roman.
	// Modified by: Costas Manousakis-(Designer)-(2/10/12 19:16:54)
	Mods_2012_02
	//  `Made sure the vInspFontName and vInspFontSize are initialized
	// Modified by: Costas Manousakis-(Designer)-(3/25/12 20:40:06)
	Mods_2012_03
	//  `use db parameters for the default fonts
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:55)
	Mods_2021_WP
	//  `
End if 

C_TEXT:C284(vInspFontName; $DefaultFont_S)  // Command Replaced was o_C_STRING length was 132
C_LONGINT:C283(vInspFontSize; $DefaultSize)  //Command Replaced was o_C_INTEGER
ARRAY TEXT:C222(aFonts; 0)  //Command Replaced was o_ARRAY string length was 80
FONT LIST:C460(aFonts)
Case of 
	: ([Inspections:27]Insp Type:6="DV@")
		$DefaultFont_S:=ut_GetSysParameter("BMSDIVEINSPFONT"; "Arial")
		$DefaultSize:=Num:C11(ut_GetSysParameter("BMSDIVEINSPFONTSIZE"; "11"))  //12
	Else 
		$DefaultFont_S:=ut_GetSysParameter("BMSDEFINSPFONT"; "Arial")
		$DefaultSize:=Num:C11(ut_GetSysParameter("BMSDEFINSPFONTSIZE"; "11"))  //12
End case 
vInspFontName:=$DefaultFont_S
vInspFontSize:=$DefaultSize

//3/30/2004 SJH
C_BOOLEAN:C305($bGeneral)
C_OBJECT:C1216($WpArea_o; $Range_o)
C_BLOB:C604($WPBlob_x)

$bGeneral:=(BLOB size:C605([Inspections:27]InspComments:171)>0)

If ($bGeneral)
	$WPBlob_x:=INSP_GetWPDocFromBlob([Inspections:27]InspComments:171)
	$WpArea_o:=WP New:C1317($WPBlob_x)
	$Range_o:=WP Text range:C1341($WpArea_o; wk start text:K81:165; wk end text:K81:164)
	WP GET ATTRIBUTES:C1345($Range_o; wk font family:K81:65; vInspFontName)
	Case of 
		: (vInspFontName="Geneva")
			vInspFontSize:=10
		: (vInspFontName="Times New Roman")
			vInspFontSize:=12
		Else 
			vInspFontName:=$DefaultFont_S
			vInspFontSize:=$DefaultSize
	End case 
	
Else 
	CUT NAMED SELECTION:C334([ElementsSafety:29]; "TEMP_SETINSPFNT_ELMTS")
	CUT NAMED SELECTION:C334([Standard Photos:36]; "TEMP_SETINSPFNT_PHOTOS")
	G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4)
	
	// select only safety elements that have non-blank comments.
	QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Comment Flag:6=True:C214)
	C_LONGINT:C283($vAllElmts)
	$vAllElmts:=Records in selection:C76([ElementsSafety:29])
	If ($vAllElmts>0)
		
		$WPBlob_x:=INSP_GetWPDocFromBlob([ElementsSafety:29]ElmComments:23)
		$WpArea_o:=WP New:C1317($WPBlob_x)
		$Range_o:=WP Text range:C1341($WpArea_o; wk start text:K81:165; wk end text:K81:164)
		WP GET ATTRIBUTES:C1345($Range_o; wk font family:K81:65; vInspFontName)
		Case of 
			: (vInspFontName="Geneva")
				vInspFontSize:=10
			: (vInspFontName="Times New Roman")
				vInspFontSize:=12
			Else 
				vInspFontName:=$DefaultFont_S
				vInspFontSize:=$DefaultSize
		End case 
		
	End if 
	USE NAMED SELECTION:C332("TEMP_SETINSPFNT_ELMTS")
	USE NAMED SELECTION:C332("TEMP_SETINSPFNT_PHOTOS")
	
End if 

ARRAY TEXT:C222(aFonts; 0)  //clean out the font array//Command Replaced was o_ARRAY string length was 80