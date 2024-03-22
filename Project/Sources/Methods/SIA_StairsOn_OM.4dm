//%attributes = {"invisible":true}
//Method: SIA_StairsOn_OM
//Description
// object method for stairs On /adjacent check box
// Parameters
// $1 : $Form evebt (Optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-10-13T00:00:00, 13:52:47
	// ----------------------------------------------------
	//Created : 
	Mods_2021_10
	
	C_LONGINT:C283(SIA_StairsOn_OM; $1)
End if 
//

C_LONGINT:C283($formEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$formEvent_L:=$1
Else 
	$formEvent_L:=Form event code:C388
End if 

C_POINTER:C301($Chkbox_ptr; $OwnerDropDwn_ptr; $Owner_ptr)
$Chkbox_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "DE StairsOnAdjacent")
$Owner_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "BridgeStairCount")
Case of 
	: ($formEvent_L=On Load:K2:1)
		$Owner_ptr->:=0
		//Hide the dropdown when there are no stairs
		OBJECT SET VISIBLE:C603(*; "DE StairOwner"; False:C215)
		
		//check if there is a stair record
		QUERY:C277([BridgeStairs:192]; [BridgeStairs:192]BIN:2=[Bridge MHD NBIS:1]BIN:3)
		If (Records in selection:C76([BridgeStairs:192])>0)
			$Owner_ptr->:=Records in selection:C76([BridgeStairs:192])
		End if 
		
	: ($formEvent_L=On Clicked:K2:4)
		C_LONGINT:C283($FormW_L; $FormH_L)
		FORM GET PROPERTIES:C674([BridgeStairs:192]; "StairsList"; $FormW_L; $FormH_L)
		Center_Window_2($FormW_L; $FormH_L; Plain window:K34:13; "Stairs On/Adjacent to "+Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 1; 1)+\
			"-"+Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 2; 2)+\
			"-"+Substring:C12([Bridge MHD NBIS:1]BDEPT:1; 4; 3)+\
			" ("+[Bridge MHD NBIS:1]BIN:3+")")
		DIALOG:C40([BridgeStairs:192]; "StairsList")
		CLOSE WINDOW:C154
		
		C_BOOLEAN:C305($One_b; $many_b)
		GET AUTOMATIC RELATIONS:C899($One_b; $many_b)
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
		QUERY:C277([BridgeStairs:192]; [BridgeStairs:192]BIN:2=[Bridge MHD NBIS:1]BIN:3)
		
		SIA_StairsOn_OM(On Load:K2:1)
		
		SET AUTOMATIC RELATIONS:C310($One_b; $many_b)
		
End case 

//End SIA_StairsOn_OM