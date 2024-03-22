//%attributes = {"invisible":true}
//Temp_Item22_Owner
//Translate Item 22 to Owner code based on new Item 8 coding
//Jan-2001

C_TEXT:C284($item8Owner)  // Command Replaced was o_C_STRING length was 3
C_TEXT:C284($Item22)  // Command Replaced was o_C_STRING length was 2

$item22:=$1

Case of 
	: ($item22="01")
		$item8Owner:="MHD"
	: (($item22="02") | ($item22="03") | ($item22="04"))
		$item8Owner:="MUN"
	: ($item22="11")
		$item8Owner:="STA"
	: ($item22="26")
		$item8Owner:="PRI"
	: ($item22="27")
		$item8Owner:="RRY"
	: ($item22="31")
		$item8Owner:="MTA"
	: (($item22="60") & ($item22="62") | ($item22="63") | ($item22="64"))
		$item8Owner:="FED"
	: (($item22="66") & ($item22="68") | ($item22="69") | ($item22="70"))
		$item8Owner:="FED"
	: ($item22="71")
		$item8Owner:="FED"
	Else 
		$item8Owner:=""
End case 

$0:=$item8Owner
