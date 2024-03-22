//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_LoadBridgeData
// User name (OS): cjmiller
// Date and time: 03/24/06, 11:04:40
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	// Modified by: costasmanousakis-(Designer)-(6/19/2007 14:33:02)
	Mods_2007_CM12_5301
	Mods_2007_CJM_v54  //r003 `11/27/07, 15:36:12`Add NBI Non NBI variable to sumary page
	Mods_2009_10  //r001 CJ Miller`10/01/09, 16:53:05   `Add Item 2 to page 0 (District)
End if 

If ([PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34="")
	PRJ_DEBin_s:=[PRJ_ProjectDetails:115]PRJ_NonBridgeNotes_txt:40
Else 
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34)
	PRJ_RoadwayOver_txt:=[Bridge MHD NBIS:1]Item7:65+" / "+[Bridge MHD NBIS:1]Item6A:63
	PRJ_ADT_l:=[Bridge MHD NBIS:1]Item29:88
	PRJ_DEBin_s:=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34
	QUERY:C277([Posting Code:7]; [Posting Code:7]Code:1=[Bridge MHD NBIS:1]Item41:141)
	PRJ_Posting_s:=[Posting Code:7]Description:2
	PRJ_OnSystemBridge_s:=QR_Item26OnOff+" System"
	PRJ_Item37_s:=Substring:C12(Get_Description(-><>aItem37des; -><>aItem37; ->[Bridge MHD NBIS:1]Item37:129); 1; 80)
	PRJ_AASHTO_r:=[Bridge MHD NBIS:1]AASHTO:5
	PRJ_StructurallyDeficient_s:="Not SD"
	PRJ_Item2_s:=[Bridge MHD NBIS:1]Item2:60
	If ([Bridge MHD NBIS:1]StructDef:103)
		PRJ_StructurallyDeficient_s:="SD"
	End if 
	PRJ_FWHASelect_s:="OFF List"
	If ([Bridge MHD NBIS:1]FHWA Select:4)
		PRJ_FWHASelect_s:="ON List"
	End if 
	PRJ_NBINonNBI_s:="NBI"
	If (Not:C34([Bridge MHD NBIS:1]FHWARecord:174))
		PRJ_NBINonNBI_s:="NON-NBI"
	End if 
	PRJ_Owner_s:=[Bridge MHD NBIS:1]Item8 Owner:208
	PRJ_InspectionDate_s:=""
	QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
	ARRAY TEXT:C222($InclBins_as; 0)  //Command Replaced was o_ARRAY string length was 3
	SELECTION TO ARRAY:C260([PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2; $InclBins_as)
	If (PRJ_DEBin_s#"")
		INSERT IN ARRAY:C227($InclBins_as; 0; 1)
		$InclBins_as{1}:=PRJ_DEBin_s
	End if 
	If (Size of array:C274($InclBins_as)>0)
		QUERY WITH ARRAY:C644([Inspections:27]BIN:1; $InclBins_as)
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="RT@"; *)
		QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Insp Type:6="CUL")
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InitialInsp:9=True:C214)
		If (Records in selection:C76([Inspections:27])>=1)
			ORDER BY:C49([Inspections:27]; [Inspections:27]Insp Date:78; <)
			FIRST RECORD:C50([Inspections:27])
			If ([Inspections:27]Insp Date:78>[PRJ_ProjectFile:117]PF_Advertised_d:14)
				PRJ_InspectionDate_s:=String:C10([Inspections:27]Insp Date:78; Internal date short:K1:7)
			Else 
			End if 
			
		End if 
	End if 
End if 
//End PRJ_LoadBridgeData