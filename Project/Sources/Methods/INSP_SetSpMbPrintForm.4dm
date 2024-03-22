//%attributes = {"invisible":true}
//Method: INSP_SetSpMbPrintForm
//Description
//  `Set the required special member form and elements per page
// Parameters
// $1  : $InspType_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/14/14, 11:38:39
	// ----------------------------------------------------
	//Created : 
	Mods_2014_04
	
	Mods_2015_01
	//  `added tunnel damage TDA
	// Modified by: Costas Manousakis-(Designer)-(2/13/15 15:22:56)
	Mods_2015_02
	//  `added tunnel other TOT
	// Modified by: Costas Manousakis-(Designer)-(4/5/17 16:50:55)
	Mods_2017_04
	//  `For MBTA FCR /CMI /OTH inspections check on the bridge type and assign print forms accordingly
End if 
//

C_TEXT:C284($InspType_txt)
$InspType_txt:=[Inspections:27]Insp Type:6

If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$InspType_txt:=$1
End if 

C_POINTER:C301($firstPgFmName_ptr; $firstPgNumMb_ptr; $SecondPgFmName_ptr; $SecondPgNumMb_ptr)
C_TEXT:C284($vsInspFormName; $vsInspFormName2)
C_LONGINT:C283($viElmtsPerPage; $viElmtsPerPage2)
C_TEXT:C284($bridgeType_txt)

//change inspection type for spec memb form when printing spec members from routine type inspections.
Case of 
	: ($InspType_txt="RT@") | ($InspType_txt="CUL")  //Highway
		$InspType_txt:="CMI"
	: ($InspType_txt="PED")  //Pedestrian
		$InspType_txt:="CMI"
	: ($InspType_txt="RRR") | ($InspType_txt="RRC") | ($InspType_txt="RRA")  //Rail
		$InspType_txt:="RRS"
	: ($InspType_txt="TOV") | ($InspType_txt="TAL")  //Tunnel
		$InspType_txt:="TSP"
End case 


Case of 
	: (($InspType_txt="CMI") | ($InspType_txt="FCR"))
		$viElmtsPerPage:=5
		Case of 
			: ([Inspections:27]Insp Date:78<=<>InspFormRevDate_4)
				$vsInspFormName:="FC Pr (Pg 1)"
			Else 
				$vsInspFormName:="FCPrPg1_v2"
				Case of 
					: ([Bridge MHD NBIS:1]InspResp:173="MBTA")
						$bridgeType_txt:=mbta_ReturnBridgeType
						
						$vsInspFormName:="HighwayFCRInsp1"
						Case of 
							: ($bridgeType_txt="Commuter@")
								$viElmtsPerPage:=5
								$vsInspFormName:="RailFCRInsp"
							: ($bridgeType_txt="Transit@")
								$viElmtsPerPage:=5
								$vsInspFormName:="TransitFCRInsp"
								
							: ($bridgeType_txt="Highway@")
								$viElmtsPerPage:=5
								$vsInspFormName:="HighwayFCRInsp1"
								
							Else 
								$viElmtsPerPage:=5
								$vsInspFormName:="FCPrPg1_v2"
						End case 
						
				End case 
		End case 
		
	: ($InspType_txt="OTH")
		$viElmtsPerPage:=5
		Case of 
			: ([Inspections:27]Insp Date:78<=<>InspFormRevDate_4)
				$vsInspFormName:="FC Pr (Pg 1)"
			Else 
				$vsInspFormName:="FCPrPg1_v2"
				Case of 
					: ([Bridge MHD NBIS:1]InspResp:173="MBTA")
						$bridgeType_txt:=mbta_ReturnBridgeType
						
						$vsInspFormName:="HighwayFCRInsp1"
						Case of 
							: ($bridgeType_txt="Commuter@")
								$viElmtsPerPage:=5
								$vsInspFormName:="RailFCRInsp"
							: ($bridgeType_txt="Transit@")
								$viElmtsPerPage:=5
								$vsInspFormName:="TransitFCRInsp"
								
							: ($bridgeType_txt="Highway@")
								$viElmtsPerPage:=5
								$vsInspFormName:="HighwayFCRInsp1"
							Else 
								$viElmtsPerPage:=5
								$vsInspFormName:="FCPrPg1_v2"
						End case 
						
				End case 
				
		End case 
	: ($InspType_txt="DAM")
		$viElmtsPerPage:=3
		Case of 
			: ([Inspections:27]Insp Date:78<=<>InspFormRevDate_4)
				$vsInspFormName:="Damage Pg1"
			Else 
				$vsInspFormName:="DamagePg1_v2"
		End case 
	: (($InspType_txt="RRS") | ($InspType_txt="RRF"))
		$bridgeType_txt:=mbta_ReturnBridgeType
		Case of 
			: ($bridgeType_txt="Commuter@")
				$viElmtsPerPage:=5
				$vsInspFormName:="RailFCRInsp"
			: ($bridgeType_txt="Transit@")
				$viElmtsPerPage:=5
				$vsInspFormName:="TransitFCRInsp"
				
			: ($bridgeType_txt="Highway@")
				$viElmtsPerPage:=5
				$vsInspFormName:="HighwayFCRInsp1"
				
			Else 
				$viElmtsPerPage:=5
				$vsInspFormName:="FCPrPg1_v2"
		End case 
		
	: ($InspType_txt="RRO")
		$viElmtsPerPage:=5
		$vsInspFormName:="FCPrPg1_v2"
	: ($InspType_txt="RRD")
		$viElmtsPerPage:=3
		$vsInspFormName:="DamagePg1_v2"
		
	: ($InspType_txt="TSP")
		$viElmtsPerPage:=6
		$vsInspFormName:="TunnelSpecialMember"
	: ($InspType_txt="TOT")
		$viElmtsPerPage:=6
		$vsInspFormName:="TunnelSpecialMember"
	: ($InspType_txt="TDA")
		$viElmtsPerPage:=5
		$vsInspFormName:="TunnelDamagePg1"
		
End case 

$viElmtsPerPage2:=$viElmtsPerPage
$vsInspFormName2:=$vsInspFormName
If (f_Insp_Revision1([Inspections:27]Insp Date:78))
	Case of 
		: (($InspType_txt="FCR") | ($InspType_txt="CMI"))
			$viElmtsPerPage2:=22
			$vsInspFormName2:="SpecialExtra"
			Case of 
				: ([Bridge MHD NBIS:1]InspResp:173="MBTA")
					$viElmtsPerPage2:=22
					$vsInspFormName2:="HighwayFCRInsppg2"
					$bridgeType_txt:=mbta_ReturnBridgeType
					Case of 
						: ($bridgeType_txt="Commuter@")
							$viElmtsPerPage2:=22
							$vsInspFormName2:="RailFCRInsppg2"
						: ($bridgeType_txt="Transit@")
							$viElmtsPerPage2:=22
							$vsInspFormName2:="TransitFCRInsppg2"
						: ($bridgeType_txt="Highway@")
							$viElmtsPerPage2:=22
							$vsInspFormName2:="HighwayFCRInsp2"
						Else 
							$viElmtsPerPage2:=22
							$vsInspFormName2:="SpecialExtra"
					End case 
					
			End case 
			
		: ($InspType_txt="TSP")
			$viElmtsPerPage2:=18  //for new form
			$vsInspFormName2:="TunnelSpecialExtra"
		: ($InspType_txt="TOT")
			$viElmtsPerPage2:=18  //for new form
			$vsInspFormName2:="TunnelSpecialExtra"
		: ($InspType_txt="TDA")
			$viElmtsPerPage2:=18  //for new form
			$vsInspFormName2:="TunnelSpecialExtra"
			
		: (($InspType_txt="RRS") | ($InspType_txt="RRF"))
			$bridgeType_txt:=mbta_ReturnBridgeType
			Case of 
				: ($bridgeType_txt="Commuter@")
					$viElmtsPerPage2:=22
					$vsInspFormName2:="RailFCRInsppg2"
				: ($bridgeType_txt="Transit@")
					$viElmtsPerPage2:=22
					$vsInspFormName2:="TransitFCRInsppg2"
				: ($bridgeType_txt="Highway@")
					$viElmtsPerPage2:=22
					$vsInspFormName2:="HighwayFCRInsp2"
				Else 
					$viElmtsPerPage2:=22
					$vsInspFormName2:="SpecialExtra"
			End case 
			
		Else 
			$viElmtsPerPage2:=22  //for new form
			$vsInspFormName2:="SpecialExtra"
	End case 
End if 

If (Count parameters:C259>1)
	C_POINTER:C301($2)
	$2->:=$vsInspFormName
End if 
If (Count parameters:C259>2)
	C_POINTER:C301($3)
	$3->:=$viElmtsPerPage
End if 
If (Count parameters:C259>3)
	C_POINTER:C301($4)
	$4->:=$vsInspFormName2
End if 
If (Count parameters:C259>4)
	C_POINTER:C301($5)
	$5->:=$viElmtsPerPage2
End if 

//End INSP_SetSpMbPrintForm