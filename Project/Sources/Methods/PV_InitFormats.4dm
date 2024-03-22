//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/24/07, 13:07:10
	// ----------------------------------------------------
	// Method: PV_InitFormats
	// Description
	// Load MHD default formats for
	// 
	// Parameters
	// $1 : $Area
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
End if 
//C_LONGINT($1;$Area)
//$Area:=$1
//ARRAY LONGINT(pv_formatlist;0)
//ARRAY TEXT(pv_formatstrings;0)
//C_TEXT($bdeptf_txt;$Item8f_txt;$Aashtof_txt;$moneyF_txt)
//C_LONGINT(pv_BdeptF_L;pv_Item8F_L;pv_AASHTOF_L;pv_MoneyF_L)
//$bdeptf_txt:="#-##-#####-##-###"
//$Item8f_txt:="######-###-###-###"
//$Aashtof_txt:="##0.0"
//$moneyF_txt:="$###,###,###,##0.00"
//PV GET FORMAT LIST ($Area;pv_formatlist;pv_formatstrings)
//If (Find in array(pv_formatstrings;$bdeptf_txt)<=0)
//pv_BdeptF_L:=PV Add format ($Area;$bdeptf_txt)
//Else 
//pv_BdeptF_L:=pv_formatlist{Find in array(pv_formatstrings;$bdeptf_txt)}
//End if 
//If (Find in array(pv_formatstrings;$Item8f_txt)<=0)
//pv_Item8F_L:=PV Add format ($Area;$Item8f_txt)
//Else 
//pv_Item8F_L:=pv_formatlist{Find in array(pv_formatstrings;$Item8f_txt)}
//End if 
//If (Find in array(pv_formatstrings;$Aashtof_txt)<=0)
//pv_AASHTOF_L:=PV Add format ($Area;$Aashtof_txt)
//Else 
//pv_AASHTOF_L:=pv_formatlist{Find in array(pv_formatstrings;$Aashtof_txt)}
//End if 
//If (Find in array(pv_formatstrings;$moneyF_txt)<=0)
//pv_MoneyF_L:=PV Add format ($Area;$moneyF_txt)
//Else 
//pv_MoneyF_L:=pv_formatlist{Find in array(pv_formatstrings;$moneyF_txt)}
//End if 