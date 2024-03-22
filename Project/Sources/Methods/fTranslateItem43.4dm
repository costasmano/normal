//%attributes = {"invisible":true}
If (False:C215)
	// Method: fTranslateItem43
	// Description
	// 
	// fTranslateItem43(Item43)
	// Parameters
	// ----------------------------------------------------
	
End if 

C_LONGINT:C283($1; $vIndex)
C_TEXT:C284($0; $vResult)  // Command Replaced was o_C_STRING length was 3

$vIndex:=$1

Case of 
	: ($vIndex=1)
		//"Cast-In-Place Reinforced Concrete"    
		$vResult:="101"
		
	: ($vIndex=2)
		//"Concrete Arch"
		$vResult:="111"
		
	: ($vIndex=3)
		//"PS Concrete Butted Box Beam"
		$vResult:="505"
		
	: ($vIndex=4)
		//"PS Concrete Butted Deck Beam"
		$vResult:="501"
		
	: ($vIndex=5)
		//"PS Concrete NE Bulb Tee"
		$vResult:="504"
		
	: ($vIndex=6)
		//"PS Concrete Spread Box Beam"
		$vResult:="506"
		
	: ($vIndex=7)
		//"PS Concrete Spread Deck Beam"
		$vResult:="506"
		
	: ($vIndex=8)
		//"See Superstructure Comments"
		$vResult:="000"
		
	: ($vIndex=9)
		//"Steel Bascule"
		$vResult:="316"
		
	: ($vIndex=10)
		//"Steel Box Girder"
		$vResult:="306"
		
	: ($vIndex=11)
		//"Steel Curved Girder"
		$vResult:="302"
		
	: ($vIndex=12)
		//"Steel Deck Truss"
		$vResult:="309"
		
	: ($vIndex=13)
		//"Steel Plate Girder/Stringer"
		$vResult:="302"
		
	: ($vIndex=14)
		//"Steel Rolled Beam"
		$vResult:="302"
		
	: ($vIndex=15)
		//"Steel Thru Girder"
		$vResult:="302"
		
	: ($vIndex=16)
		//"Steel Thru Truss"
		$vResult:="310"
		
	: ($vIndex=17)
		//"Timber"
		$vResult:="702"
		
	: ($vIndex=18)
		//"Timber Truss"
		$vResult:="710"
		
	: ($vIndex=19)
		//"Not Applicable"
		$vResult:="000"
End case 



$0:=$vResult