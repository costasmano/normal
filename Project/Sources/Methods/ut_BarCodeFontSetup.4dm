//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/05/07, 11:26:31
	// ----------------------------------------------------
	// Method: ut_BarCodeFontSetup
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($K)
ARRAY TEXT:C222($fontList_atxt; 0)
FONT LIST:C460($fontList_atxt)
$K:=Find in array:C230($fontList_atxt; "CODE 39")
C_BOOLEAN:C305($FontInDX_B; $FontinFonts_B)
C_TEXT:C284($LocalFontinDX_txt)
If ($K>0)
Else 
	Case of 
		: (Application type:C494=4D Remote mode:K5:5)
			$LocalFontinDX_txt:=<>My4DXFolder_txt+"CODE39.TTF"
			$FontInDX_B:=(Test path name:C476($LocalFontinDX_txt)=Is a document:K24:1)
			$FontinFonts_B:=(Test path name:C476(System folder:C487(Fonts:K41:2)+"CODE39.TTF")=Is a document:K24:1)
			Case of 
				: (Not:C34($FontInDX_B))
				: ($FontinFonts_B)
				Else 
					COPY DOCUMENT:C541($LocalFontinDX_txt; (System folder:C487(Fonts:K41:2)+"CODE39.TTF"))
			End case 
			
	End case 
	
End if 