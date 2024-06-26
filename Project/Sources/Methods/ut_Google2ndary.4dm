//%attributes = {"invisible":true}
//Method: ut_Google2ndary
//Description
//  `google a secondary record copied from ut_GoogleBIN
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/29/14, 12:07:12
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05
	// Modified by: Costas Manousakis-(Designer)-(2022-03-30 19:36:48)
	Mods_2022_03
	//  `use same code as ut_googleBIN
End if 
//

C_TEXT:C284($url; $urlout)
C_LONGINT:C283(goo_zzvalue; goo_zoomValue)
goo_zzvalue:=16
goo_zoomValue:=1
$url:=""
If ((Shift down:C543))
	C_TEXT:C284($BINMapOptions)
	$BINMapOptions:=ut_GetSysParameter("MAP_BINSiteOptions")
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
	$url:=ut_GetSysParameter("MAP_GoogleBIN"; $url)
	
End if 

If ($url#"")
	
	C_TEXT:C284($Item7_txt; $item6_txt; $ItemPrefix_txt)
	$Item7_txt:=[NBIS Secondary:3]Item7:7
	$item6_txt:=[NBIS Secondary:3]Item6A:5
	$ItemPrefix_txt:=Substring:C12($Item7_txt; 1; 5)
	If (($ItemPrefix_txt="OTHER") | ($ItemPrefix_txt="WATER") | ($ItemPrefix_txt="HWY  "))
		$Item7_txt:=Substring:C12($Item7_txt; 6)
	End if 
	$ItemPrefix_txt:=Substring:C12($item6_txt; 1; 5)
	If (($ItemPrefix_txt="OTHER") | ($ItemPrefix_txt="WATER") | ($ItemPrefix_txt="HWY  "))
		$item6_txt:=Substring:C12($item6_txt; 6)
	End if 
	
	$Item7_txt:=Replace string:C233($Item7_txt; "("; "[")
	$Item7_txt:=Replace string:C233($Item7_txt; ")"; "]")
	$item6_txt:=Replace string:C233($item6_txt; "("; "[")
	$item6_txt:=Replace string:C233($item6_txt; ")"; "]")
	$item6_txt:=Replace string:C233($item6_txt; " TO "; " - ")
	$Item7_txt:=Replace string:C233($Item7_txt; " TO "; " - ")
	
	C_REAL:C285(goo_brgLatValue; goo_brgLongValue)
	goo_brgLatValue:=[NBIS Secondary:3]Item16A:12+([NBIS Secondary:3]Item16B:13/60)+([NBIS Secondary:3]Item16C:35/3600)
	goo_brgLongValue:=-([NBIS Secondary:3]Item17A:14+([NBIS Secondary:3]Item17B:15/60)+([NBIS Secondary:3]Item17C:36/3600))
	
	If ((goo_brgLatValue#0) & (goo_brgLongValue#0))
		goo_brgLatValue:=Round:C94(goo_brgLatValue; 8)
		goo_brgLongValue:=Round:C94(goo_brgLongValue; 8)
		C_TEXT:C284(goo_sBDEPT; $TLineBdept)
		goo_sBDEPT:=[Bridge MHD NBIS:1]BDEPT:1
		$TLineBdept:=QR_TLineBrNo_2
		If ($TLineBdept#"")
			goo_sBDEPT:=goo_sBDEPT+"="+$TLineBdept
		End if 
		goo_sBDEPT:=Replace string:C233(goo_sBDEPT; "="; "-")
		
		goo_sBDEPT:=goo_sBDEPT+" ["+[Bridge MHD NBIS:1]BIN:3+"]"+" : "+(Replace string:C233(f_TrimStr($Item7_txt; True:C214; True:C214); "  "; " "))+" / "+(Replace string:C233(f_TrimStr($item6_txt; True:C214; True:C214); "  "; " "))
		goo_sBDEPT:=Replace string:C233(goo_sBDEPT; "&"; "AND")
		goo_sBDEPT:=Replace string:C233(goo_sBDEPT; "'"; " ")
		goo_sBDEPT:=Replace string:C233(goo_sBDEPT; "`"; " ")
		
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
		ALERT:C41("Zero Lat. Long. values for this Bridge Record!")
	End if 
End if 
//End ut_Google2ndary