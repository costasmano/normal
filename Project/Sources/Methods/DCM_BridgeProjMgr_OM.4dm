//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/28/10, 16:08:50
	// ----------------------------------------------------
	// Method: Method: DCM_BridgeProjMgr_OM
	// Description
	//  ` Method for the Bridge Manager pulldown in cboBridgePrjMgr
	// 
	// Parameters
	// $1 : $FormEvent (optional)
	// ----------------------------------------------------
	
	Mods_2010_10
End if 
C_LONGINT:C283($FormEvent)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent:=$1
Else 
	$FormEvent:=Form event code:C388
End if 

If ($FormEvent=On Load:K2:1)
	ARRAY TEXT:C222(cboBridgePrjMgr; 0)
	ARRAY LONGINT:C221($tempIDarray_aL; 0)
	//ut_GetGroupMembers ("DistrictMaintMgrs";->cboBridgePrjMgr)
	C_TEXT:C284($DistrSearch_txt; $Tempchk_txt)
	$DistrSearch_txt:="@"
	If ([DCM_Contracts:136]ContractNo:1#"")
		READ ONLY:C145([PRJ_ConstructionProject:116])
		QUERY:C277([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5=[DCM_Contracts:136]ContractNo:1)
		If ([PRJ_ConstructionProject:116]CP_AELocation_s:23="District @")
			$DistrSearch_txt:=Substring:C12(Replace string:C233([PRJ_ConstructionProject:116]CP_AELocation_s:23; "District "; ""); 1; 1)
			If (Num:C11($DistrSearch_txt)>0)
			Else 
				$DistrSearch_txt:="@"
			End if 
		End if 
		
	End if 
	
	PRJ_FillPersonnelDropDowns(->$tempIDarray_aL; ->cboBridgePrjMgr; ("DistrMainManagers"+$DistrSearch_txt))
	ARRAY LONGINT:C221($tempIDarray_aL; 0)  //we don't need this one
	INSERT IN ARRAY:C227(cboBridgePrjMgr; 1; 1)
	cboBridgePrjMgr{1}:=""
	SORT ARRAY:C229(cboBridgePrjMgr)
End if 