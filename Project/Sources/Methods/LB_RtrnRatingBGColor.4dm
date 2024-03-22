//%attributes = {"invisible":true}
//Method: LB_RtrnRatingBGColor
//Description
//This method will return background colors for consultant rating list box based on [Conslt Rating]PriorityColorFlag
// Parameters
// $0 : Color_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 06/30/20, 16:59:06
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
	
	C_LONGINT:C283(LB_RtrnRatingBGColor; $0)
	
	// Modified by: Costas Manousakis-(Designer)-(2021-10-14T00:00:00 11:08:41)
	Mods_2021_10
	//  `Return white background as default
End if 
//
C_LONGINT:C283($0)

$0:=16777215  // white background

If ((User in group:C338(Current user:C182; "Bridge Insp Engineer")) | (Current user:C182="Designer"))
	
	Case of 
		: ([Conslt Rating:63]PriorityColorFlag:3="GREEN")
			//OBJECT SET COLOR(*;"@BackGroundRect@";-((11*16+3)+(256*(11*16+3))))
			$0:=7600761
		: ([Conslt Rating:63]PriorityColorFlag:3="YELLOW")
			//OBJECT SET COLOR(*;"@BackGroundRect@";-(Yellow+(256*Yellow)))
			$0:=15925002
		: ([Conslt Rating:63]PriorityColorFlag:3="RED")
			//OBJECT SET COLOR(*;"@BackGroundRect@";-((8*16+3)+(256*(8*16+3))))
			$0:=16718608
		: ([Conslt Rating:63]PriorityColorFlag:3="ORANGE")
			$0:=16749312
			//OBJECT SET COLOR(*;"@BackGroundRect@";-((2*16+9)+(256*(2*16+9))))
		Else 
			$0:=16777215
			//OBJECT SET COLOR(*;"@BackGroundRect@";-(White+(256*White)))
	End case 
End if 
//End LB_RtrnRatingBGColor