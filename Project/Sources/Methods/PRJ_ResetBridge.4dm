//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_ResetBridge
// User name (OS): cjmiller
// Date and time: 03/15/07, 16:19:39
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_PRJSELECTION
	// Modified by: costasmanousakis-(Designer)-(8/28/2007 15:44:19)
	Mods_2007_CM12_5301
	Mods_2007_CJM_v54  //r003 `11/27/07, 12:34:16`Make town not enterable
End if 
READ WRITE:C146([PRJ_ProjectDetailsIncludedBINS:122])
QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
If (Records in selection:C76([PRJ_ProjectDetailsIncludedBINS:122])>0)
	Repeat 
		DELETE SELECTION:C66([PRJ_ProjectDetailsIncludedBINS:122])
		If (Records in set:C195("LockedSet")>0)
			USE SET:C118("LockedSet")
		End if 
	Until (Records in set:C195("LockedSet")=0)
End if 
ARRAY TEXT:C222(BinDescP2_atxt; 0)
PRJ_DEBridgeNo_s:=<>PRJ_SelectedData_txt
[PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8:=Get_Town_Name(Substring:C12(<>PRJ_SelectedData_txt; 1; 6))  //Mods_2007_CM12_5301
OBJECT SET ENTERABLE:C238([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; False:C215)
OBJECT SET RGB COLORS:C628([PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR([PRJ_ProjectDetails]PRJ_CityOrTown_s; <>PRJ_Color_Not_editable)
[PRJ_ProjectDetails:115]PRJ_NonBridge_s:7:=""
If (Records in selection:C76([Bridge MHD NBIS:1])=1)
	PRJ_OneBridgeFound
Else 
	PRJ_DEBin_s:=<>PRJ_SelectedBIN_txt  //Mods_2007_CM12_5301
	[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34:=<>PRJ_SelectedBIN_txt  //Mods_2007_CM12_5301
	PRJ_CreateIncludedBINRecord(<>PRJ_SelectedBIN_txt; [Bridge MHD NBIS:1]BDEPT:1)  //Mods_2007_CM12_5301
	OBJECT SET ENTERABLE:C238(PRJ_DEBin_s; False:C215)
	OBJECT SET RGB COLORS:C628(PRJ_DEBin_s; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(PRJ_DEBin_s; <>PRJ_Color_Not_editable)
End if 
PRJ_AdditionalBridges
[PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5:=PRJ_DEBridgeNo_s  //Mods_PRJSELECTION
PRJ_LoadPage2Bins
//End PRJ_ResetBridge