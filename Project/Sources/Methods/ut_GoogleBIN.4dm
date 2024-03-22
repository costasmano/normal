//%attributes = {"invisible":true}
// Method: ut_GoogleBIN
// Description
// Launch a browser with google maps to the latlongs of the current BIN record.
// URL parameters : 
//  ` &t=h : Show satelite view
// Parameters
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/14/09, 19:08:19
	// ----------------------------------------------------
	// ----------------------------------------------------
	
	Mods_2009_CM_5404
	// Modified by: costasmanousakis-(Designer)-(2/25/10 15:31:43)
	Mods_2010_02
	//  `Added code to show facility on/under
	// Modified by: costasmanousakis-(Designer)-(4/7/10 10:07:14)
	Mods_2010_04
	//  `Fix some errors of displaying the fac on /under
	// Modified by: costasmanousakis-(Designer)-(11/12/10 09:05:43)
	Mods_2010_11
	//  `Changed code and url string to use PROCESS HTML Var command;
	//  `Added change to replace parens with brackets in Item 6 and 7
	// Modified by: costasmanousakis-(Designer)-(5/5/11 11:44:14)
	Mods_2011_05
	//  `Made adjustments on how to open the URL depending on the application version,
	//  `for > 8 (v11 and after ) use OPEN WEB URL (url), for 2004 OPEN WEB URL (url;*)
	//  `Also made all 4DVAR variable to process vars. Local vars did not work in v11 compiled.
	// Modified by: Costas Manousakis-(Designer)-(11/8/13 14:48:47)
	Mods_2013_11
	//  `Replace the word "TO" in item 6 and 7 with a "-" : causes google to think we asking for dierctioons
	// Modified by: Costas Manousakis-(Designer)-(12/12/13 14:38:31)
	Mods_2013_12
	//  `replace  apostrophe (quote) and back apostrophe with space
	// Modified by: Costas Manousakis-(Designer)-(3/4/14 16:50:42)
	Mods_2014_03
	//  `for admins added try Bing.
	// Modified by: Costas Manousakis-(Designer)-(5/26/15 12:57:00)
	Mods_2015_05
	//  `Adjusted the prompt for BING or Gorissen
	//  `also use system parameters for the different searches.
	// Modified by: Costas Manousakis-(Designer)-(3/9/21 11:57:51)
	Mods_2021_03
	//  `Removed restriction of options when holding the Shift key; 
	//  `Added use of parameter MAP_BINSiteOptions to show mapping options
	//  `also modified Help Tip "SIAGoogleBIN"
	// Modified by: Costas Manousakis-(Designer)-(4/21/21 13:05:32)
	Mods_2021_04
	//  `force Json parse to return Is object
	//  `force ob get to return correct type
End if 
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
	$Item7_txt:=[Bridge MHD NBIS:1]Item7:65
	$item6_txt:=[Bridge MHD NBIS:1]Item6A:63
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
	goo_brgLatValue:=[Bridge MHD NBIS:1]Item16A:68+([Bridge MHD NBIS:1]Item16B:69/60)+([Bridge MHD NBIS:1]Item16C:109/3600)
	goo_brgLongValue:=-([Bridge MHD NBIS:1]Item17A:70+([Bridge MHD NBIS:1]Item17B:71/60)+([Bridge MHD NBIS:1]Item17C:136/3600))
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
