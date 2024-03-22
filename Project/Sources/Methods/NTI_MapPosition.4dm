//%attributes = {"invisible":true}
//Method: NTI_MapPosition
//Description
// Map the current TIN tunnel record
// uses parameter MAP_GoogleNTI and MAP_NTISiteOptions
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Nov 6, 2023, 14:09:00
	Mods_2023_11
	// ----------------------------------------------------
	
End if 
//
C_TEXT:C284($url; $urlout)
C_LONGINT:C283(goo_zzvalue; goo_zoomValue)
goo_zzvalue:=16
goo_zoomValue:=1

If ((Shift down:C543))
	C_TEXT:C284($BINMapOptions)
	$BINMapOptions:=ut_GetSysParameter("MAP_NTISiteOptions")
	C_OBJECT:C1216($BinOptions_o)
	$BinOptions_o:=JSON Parse:C1218($BINMapOptions; Is object:K8:27)
	ARRAY OBJECT:C1221($sites_ao; 0)
	OB GET ARRAY:C1229($BinOptions_o; "Sites"; $sites_ao)
	C_LONGINT:C283($loop_L)
	C_TEXT:C284($menu_txt)
	$menu_txt:="<I Select a map option..."
	For ($loop_L; 1; Size of array:C274($sites_ao))
		$menu_txt:=$menu_txt+";"+OB Get:C1224($sites_ao{$loop_L}; "name"; Is text:K8:3)
	End for 
	C_LONGINT:C283($Choice_L)
	$Choice_L:=Pop up menu:C542($menu_txt)
	If ($Choice_L>1)
		$url:=ut_GetSysParameter(OB Get:C1224($sites_ao{$Choice_L-1}; "urlparam"; Is text:K8:3))
	End if 
	
Else 
	
	$url:="http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=<!--#4DVAR goo_brgLatValue-->"
	$url:=$url+",<!--#4DVAR goo_brgLongValue-->+(<!--#4DVAR goo_sBDEPT-->)&ie=UTF8&z=<!--#4DVAR goo_zzvalue-->"
	$url:=$url+"&iwloc=addr@zoom=<!--#4DVAR goo_zoomValue-->&t=h"
	$url:=ut_GetSysParameter("MAP_GoogleNTI"; $url)
	
End if 

C_TEXT:C284($Item7_txt; $item6_txt; $ItemPrefix_txt)
$Item7_txt:=[NTI_TunnelInfo:181]NTI_i2_s:7

C_REAL:C285(goo_brgLatValue; goo_brgLongValue)
goo_brgLatValue:=[NTI_TunnelInfo:181]NTI_i13_r:18
goo_brgLongValue:=[NTI_TunnelInfo:181]NTI_i14_r:19
If ((goo_brgLatValue#0) & (goo_brgLongValue#0))
	goo_brgLatValue:=Round:C94(goo_brgLatValue; 8)
	goo_brgLongValue:=Round:C94(goo_brgLongValue; 8)
	C_TEXT:C284(goo_sBDEPT)
	goo_sBDEPT:=[NTI_TunnelInfo:181]NTI_i1_s:6
	
	PROCESS 4D TAGS:C816($url; $urlout)
	C_LONGINT:C283($Version4D_L)
	$Version4D_L:=Num:C11(Substring:C12(Application version:C493; 1; 2))
	If ($Version4D_L>8)
		OPEN URL:C673($urlout)
	Else 
		OPEN URL:C673($urlout; *)
	End if 
	goo_sBDEPT:=""
	
Else 
	ALERT:C41("Zero Lat. Long. values for this Tunnel Structure!")
End if 

//End NTI_MapPosition   