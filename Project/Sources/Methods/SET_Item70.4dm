//%attributes = {"invisible":true}
//procedure: SET_Item70
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(3/29/16 11:37:51)
	Mods_2016_03_bug
	//  `fix bug where the rating is done as a RF not a weight - use item 63
	// Modified by: Costas Manousakis-(Designer)-(2/28/17 15:34:20)
	Mods_2017_02
	//  `Added case for 63 = D, E, or F - also  64 coded as RF
	// Modified by: Costas Manousakis-(Designer)-(3/1/17 15:45:56)
	Mods_2017_03
	//  `use ◊SIA_LoadRtg_63_RF_txt to decide if  item 64 is rating factor or MT
	C_TEXT:C284(SET_Item70; $0)  // was length of 1
	C_REAL:C285(SET_Item70; $1)
	C_TEXT:C284(SET_Item70; $2)  // was length of 1
End if 
C_REAL:C285($wt; $legal; $Item64; $1)
C_TEXT:C284($0; $value; $Item63; $2)  // Command Replaced was o_C_STRING length was 1
If (Count parameters:C259>0)
	$Item64:=$1
Else 
	$Item64:=[Bridge MHD NBIS:1]Item64:137
End if 
If (Count parameters:C259>1)
	$Item63:=$2
Else 
	$Item63:=[Bridge MHD NBIS:1]Item 63:199
End if 
Case of 
	: (Position:C15($Item63; <>SIA_LoadRtg_63_RF_txt)>0)
		$wt:=$Item64*100
	Else 
		$legal:=32.4  //metric tons (36 tons x 0.9)
		$wt:=$Item64*100/$legal
End case 
$value:="0"
Case of 
	: ($wt>=100)
		$value:="5"
	: ($wt>=90.1)
		$value:="4"
	: ($wt>=80.1)
		$value:="3"
	: ($wt>=70.1)
		$value:="2"
	: ($wt>=60.1)
		$value:="1"
End case 
$0:=$value
