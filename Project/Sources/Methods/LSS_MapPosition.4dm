//%attributes = {"invisible":true}
//Method: LSS_MapPosition
//Description
// map in google the current inventory item
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/08/15, 12:28:50
	// ----------------------------------------------------
	//Created : 
	Mods_2015_05
	// Modified by: manousakisc-(Designer)-(9/7/2023 15:35:50)
	Mods_2023_09
	//  `Use new MAP parameters to display mapping options and open maps.
End if 
//

C_TEXT:C284($url; $urlout)
C_LONGINT:C283(goo_zzvalue; goo_zoomValue)
goo_zzvalue:=16
goo_zoomValue:=1
//If ((Shift down) & User in group(<>CurrentUser_Name;"Application Admin"))
//CONFIRM("Try Bing????")

//If (Ok=1)
//$url:="http://www.bing.com/maps/default.aspx?cp=<!--#4DVAR goo_brg"+"Lat"+"Value-->~<!--#4DVAR goo_brgLongValue-->&lvl=16"+"&style=h"  //+ "&rtp=pos.<!--#4DVAR goo_brgLatValue-->_<!--#4DVAR goo_brgLongValue-->"
//$url:=$url+"&sp=point.<!--#4DVAR goo_brgLatValue-->_<!--#4DVAR goo_brgLongValue-->_<!--#4DVAR goo_sBDEPT-->"
//Else 
//$url:="http://www.gorissen.info/Pierre/maps/googleMapLocation.php?lat=<!--#4DVAR goo_brg"+"Lat"+"Value-->&lon"+"=<!--#4DVAR goo_brgLongValue-->&setLatLon=Set"
//End if 
//Else 
//$url:="http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=<!--#4DVAR goo_brgLat"+"Val"+"ue-->"
//$url:=$url+",<!--#4DVAR goo_brgLongValue-->+(<!--#4DVAR goo_sBDEPT-->)&ie=UTF8&z=<!--#4DVAR g"+"oo_zzvalu"+"e-->"
//$url:=$url+"&iwloc=addr@zoom=<!--#4DVAR goo_zoomValue-->&t=h"
//End if 

If ((Shift down:C543))
	C_TEXT:C284($BINMapOptions)
	$BINMapOptions:=ut_GetSysParameter("MAP_LSSSiteOptions")
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
	
	$url:="http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=<!--#4DVAR goo_brgLat"+"Val"+"ue-->"
	$url:=$url+",<!--#4DVAR goo_brgLongValue-->+(<!--#4DVAR goo_sBDEPT-->)&ie=UTF8&z=<!--#4DVAR g"+"oo_zzvalu"+"e-->"
	$url:=$url+"&iwloc=addr@zoom=<!--#4DVAR goo_zoomValue-->&t=h"
	$url:=ut_GetSysParameter("MAP_GoogleLSS"; $url)
	
End if 

C_TEXT:C284($Item7_txt; $item6_txt; $ItemPrefix_txt)
$Item7_txt:=[LSS_Inventory:165]LSS_StructureNumber_s:6

C_REAL:C285(goo_brgLatValue; goo_brgLongValue)
goo_brgLatValue:=[LSS_Inventory:165]LSS_Latitude_r:19
goo_brgLongValue:=[LSS_Inventory:165]LSS_Longitude_r:18
If ((goo_brgLatValue#0) & (goo_brgLongValue#0))
	goo_brgLatValue:=Round:C94(goo_brgLatValue; 8)
	goo_brgLongValue:=Round:C94(goo_brgLongValue; 8)
	C_TEXT:C284(goo_sBDEPT)
	goo_sBDEPT:=[LSS_Inventory:165]LSS_StructureNumber_s:6
	
	//C_BLOB($in;$out)
	//TEXT TO BLOB($url;$in;UTF8 text without length )
	PROCESS 4D TAGS:C816($url; $urlout)
	//$urlout:=BLOB to text($out;UTF8 text without length )
	//SET TEXT TO CLIPBOARD($url+Char(13)+goo_sBDEPT+Char(13)+"Lat:"+String(goo_brgLatValue)+Char(13)+"Long:"+String(goo_brgLongValue)+Char(13)+$urlout)
	C_LONGINT:C283($Version4D_L)
	$Version4D_L:=Num:C11(Substring:C12(Application version:C493; 1; 2))
	If ($Version4D_L>8)
		OPEN URL:C673($urlout)
	Else 
		OPEN URL:C673($urlout; *)
	End if 
	goo_sBDEPT:=""
	
Else 
	//OPEN WEB URL("http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q="+$Item7_txt+","+[Bridge MHD NBIS]Town Name+", MA {"+[Bridge MHD NBIS]BDEPT+", "+[Bridge MHD NBIS]BIN+", over "+$item6_txt+"}")
	ALERT:C41("Zero Lat. Long. values for this Ancillary Structure Record!")
End if 
//End LSS_MapPosition