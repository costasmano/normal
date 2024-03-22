//%attributes = {"invisible":true}
//Method: ut_setWindowsize
//Description
//The purpose of this method is to resize window between input and output forms
//on open detail 
//ut_SetWindowSize ("Create";Current method name)
//It should be called on open detail and close detail
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 09/26/19, 13:08:02
	// ----------------------------------------------------
	//The purpose of this method is to resize window between input and output forms
	//on open detail 
	//ut_SetWindowSize ("Create";Current method name)
	//It should be called on open detail and close detail
	//On close detail
	//ut_SetWindowSize("Reset";Current method name)
	//If callled on double click 
	//before dialog Compiler_Utilities
	If (False:C215)  //SO FAR WHERE USED
		//LB_ContractMaintenance 
		//LB_CSLT_Inspection 
		//LB_CSLT_Rating 
		//[Bridge MHD NBIS];"NewMBTANBIS_StackInfo"
		//[Bridge MHD NBIS];"NewNBIS_StackInfo"
		//[PERS_Groups];"Input"
		//[PERS_Groups];"PG_Output_LB"
		//[Personnel];"Inspectors Out_LB"
		//[ScourPOA];"Output_LB"
	End if 
	//ut_SetWindowSize ("Create";Current method name)
	//after dialog
	//ut_SetWindowSize("Reset";Current method name)
	//Created : 
	Mods_2019_09  //Create method to handle resize of windows between out and input forms
	//Modified by: Chuck Miller (9/26/19 14:51:05)
	Mods_2020_06  // Add type to make sure object is defined
	//Add code to keep window at current position if possible
End if 
//
C_TEXT:C284($1; $2)

Case of 
		
	: ($1="Create")
		If (Type:C295(WindowSize_o)=Is undefined:K8:13)
			C_OBJECT:C1216(WindowSize_o)
		End if 
		//CLEAR VARIABLE(WindowSize_o)
		
		C_LONGINT:C283($WPosLeft_L; $WPosTop_L; $WPosRight_L; $WPosBottom_L)
		GET WINDOW RECT:C443($WPosLeft_L; $WPosTop_L; $WPosRight_L; $WPosBottom_L)
		
		C_OBJECT:C1216($Dimensions_o)
		
		OB SET:C1220($Dimensions_o; "Left"; $WPosLeft_L)
		OB SET:C1220($Dimensions_o; "Top"; $WPosTop_L)
		OB SET:C1220($Dimensions_o; "Right"; $WPosRight_L)
		OB SET:C1220($Dimensions_o; "Bottom"; $WPosBottom_L)
		OB SET:C1220(WindowSize_o; $2; $Dimensions_o)
		
	: ($1="RESET")
		C_LONGINT:C283($WPosLeft_L; $WPosTop_L; $WPosRight_L; $WPosBottom_L; $Width_L; $ScreenWidth_L)
		C_LONGINT:C283($WNPosLeft_L; $WNPosTop_L; $WNPosRight_L; $WNPosBottom_L)
		GET WINDOW RECT:C443($WNPosLeft_L; $WNPosTop_L; $WNPosRight_L; $WNPosBottom_L)
		
		C_OBJECT:C1216($Dimensions_o)
		$Dimensions_o:=OB Get:C1224(WindowSize_o; $2; Is object:K8:27)
		$WPosLeft_L:=OB Get:C1224($Dimensions_o; "Left"; Is longint:K8:6)
		$WPosTop_L:=OB Get:C1224($Dimensions_o; "Top"; Is longint:K8:6)
		$WPosRight_L:=OB Get:C1224($Dimensions_o; "Right"; Is longint:K8:6)
		$WPosBottom_L:=OB Get:C1224($Dimensions_o; "Bottom"; Is longint:K8:6)
		$Width_L:=$WPosRight_L-$WPosLeft_L
		$ScreenWidth_L:=Screen width:C187
		If (($WNPosLeft_L+$Width_L)>$ScreenWidth_L)
			$WNPosLeft_L:=$ScreenWidth_L-$Width_L-20
		End if 
		
		SET WINDOW RECT:C444($WNPosLeft_L; $WPosTop_L; $WNPosLeft_L+$Width_L; $WPosBottom_L)
		
	: ($1="Original")  //This option will move form back to its original position
		C_LONGINT:C283($WPosLeft_L; $WPosTop_L; $WPosRight_L; $WPosBottom_L)
		
		C_OBJECT:C1216($Dimensions_o)
		$Dimensions_o:=OB Get:C1224(WindowSize_o; $2; Is object:K8:27)
		$WPosLeft_L:=OB Get:C1224($Dimensions_o; "Left"; Is longint:K8:6)
		$WPosTop_L:=OB Get:C1224($Dimensions_o; "Top"; Is longint:K8:6)
		$WPosRight_L:=OB Get:C1224($Dimensions_o; "Right"; Is longint:K8:6)
		$WPosBottom_L:=OB Get:C1224($Dimensions_o; "Bottom"; Is longint:K8:6)
		
		SET WINDOW RECT:C444($WPosLeft_L; $WPosTop_L; $WPosRight_L; $WPosBottom_L)
		
End case 
//End ut_setWindowsize