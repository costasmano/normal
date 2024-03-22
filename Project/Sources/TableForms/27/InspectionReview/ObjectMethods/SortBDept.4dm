If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(5/18/2006 15:28:06)
	Mods_2006_CM04
	
End if 
C_BOOLEAN:C305($dobyfield_b)
$dobyfield_b:=False:C215
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_POINTER:C301(MultiLevelTbl)
		MultiLevelTbl:=->[Inspections:27]
		If ((Self:C308->=0) | (Self:C308->=1))
			Self:C308->:=1
		End if 
		If ($dobyfield_b)
			C_BOOLEAN:C305($vbShift)
			$vbShift:=Shift down:C543
			MULTILEVEL(->[Bridge MHD NBIS:1]BDEPT:1; Self:C308; $vbShift)
			SET CURSOR:C469(0)
		Else 
			INSP_SortbyBDEPT(Self:C308->)
		End if 
		REDRAW WINDOW:C456
		
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		If ((Self:C308->=0) | (Self:C308->=1))
			Self:C308->:=1
		End if 
		If ($dobyfield_b)
			C_BOOLEAN:C305($vbShift)
			$vbShift:=Shift down:C543
			MULTILEVEL(->[Bridge MHD NBIS:1]BDEPT:1; Self:C308; $vbShift)
			SET CURSOR:C469(0)
			SortTmLdr:=0  //this is not part of the multilevel sort yet.
			REDRAW WINDOW:C456
			vbSortedHeader:=True:C214
		Else 
			INSP_SortbyBDEPT(Self:C308->)
		End if 
		
	: ((Form event code:C388=On Header:K2:17) & Not:C34(vbSortedHeader))
		If (SortBdept>0)
			If ($dobyfield_b)
				Case of 
					: (SortBdept=1)
						ORDER BY:C49([Inspections:27]; [Bridge MHD NBIS:1]BDEPT:1; >)
					: (SortBdept=2)
						ORDER BY:C49([Inspections:27]; [Bridge MHD NBIS:1]BDEPT:1; <)
				End case 
				
			Else 
				INSP_SortbyBDEPT(SortBdept)
			End if 
			REDRAW WINDOW:C456
		End if 
		
End case 