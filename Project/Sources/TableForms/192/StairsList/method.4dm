//Form Method: [BridgeStairs].StairsList
//Description
// Form to handle Stairs input for a bridge 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-10-14T00:00:00, 15:46:55
	// ----------------------------------------------------
	//Created : 
	Mods_2021_10
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		//enable /disable the + - buttons
		
		C_BOOLEAN:C305($enterable_b; $teamLeader_b)
		C_LONGINT:C283($PID_L; $Job_L)
		$PID_L:=<>CURRENTUSER_PID
		Begin SQL
			select [Personnel].[Job Code]
			from [Personnel]
			where [Personnel].[Person ID] = :$PID_L
			into :$Job_L ;
		End SQL
		$teamLeader_b:=($Job_L=2)
		
		$enterable_b:=BMSUtil_BelongToBridge & $teamLeader_b
		$enterable_b:=$enterable_b | (BMSUtil_BelongToBridge & (Not:C34([Bridge MHD NBIS:1]FHWARecord:174) & (GRP_UserInGroup("BRI_TeamLeader")=1)))
		$enterable_b:=$enterable_b | User in group:C338(<>CURRENTUSER_NAME; "Key Access")
		
		OBJECT SET ENABLED:C1123(*; "AddStair"; $enterable_b)
		OBJECT SET ENABLED:C1123(*; "DelStair"; $enterable_b)
		OBJECT SET ENABLED:C1123(*; "SaveStairs"; $enterable_b)
		
		C_POINTER:C301($enterableflag_ptr)  //pointer to the check box on the form that holds whether stairs are enterable
		$enterableflag_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "StairsEnterable")
		$enterableflag_ptr->:=Choose:C955($enterable_b; 1; 0)
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 

//End [BridgeStairs].StairsList