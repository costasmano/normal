//Method: Object Method: [Contract_Project_Maintenance].PreservationInput.3D Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/09/13, 18:20:12
	// ----------------------------------------------------
	//Created : 
	Mods_2013_03
	// Modified by: Costas Manousakis-(Designer)-(9/23/13 16:06:04)
	Mods_2013_09
	//  `
End if 
//

If (([Contract_Project_Maintenance:100]BridgeNo:4="") | ([Contract_Project_Maintenance:100]BridgeNo:4="Various"))
	vBridgeNo:="Various"
	[Contract_Project_Maintenance:100]BridgeNo:4:=vBridgeNo
	[Contract_Project_Maintenance:100]Location:6:=vBridgeNo  //New
	[Contract_Project_Maintenance:100]Town:7:=vBridgeNo  //New
	[Contract_Project_Maintenance:100]BIN:5:="OOO"
	OBJECT SET RGB COLORS:C628([Contract_Project_Maintenance:100]District:8; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([Contract_Project_Maintenance]District; <>Color_Editable)
	OBJECT SET RGB COLORS:C628([Contract_Project_Maintenance:100]Location:6; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([Contract_Project_Maintenance]Location; <>Color_Editable)
	OBJECT SET RGB COLORS:C628([Contract_Project_Maintenance:100]Town:7; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR([Contract_Project_Maintenance]Town; <>Color_Editable)
	OBJECT SET ENTERABLE:C238([Contract_Project_Maintenance:100]District:8; True:C214)
	OBJECT SET ENTERABLE:C238([Contract_Project_Maintenance:100]Location:6; True:C214)
	OBJECT SET ENTERABLE:C238([Contract_Project_Maintenance:100]Town:7; True:C214)
Else 
	ALERT:C41("There is a non-Blank Bridge number entered :"+[Contract_Project_Maintenance:100]BridgeNo:4+"! Must delete this record first!")
End if 

//End Object Method: [Contract_Project_Maintenance];"PreservationInput".3D Button