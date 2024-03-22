//%attributes = {"invisible":true}
//Method: RatRep_LoadVehFormVariables
//Description
// load the vehicle variables of the input form
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/06/19, 13:14:22
	// ----------------------------------------------------
	//Created : 
	Mods_2019_11
End if 
//

READ ONLY:C145([RatingVehicleTypes:190])
ARRAY TEXT:C222($VehCodes_atxt; 0)
ARRAY LONGINT:C221($VehIds_aL; 0)
ARRAY BOOLEAN:C223($inv_ab; 0)
ARRAY BOOLEAN:C223($oper_ab; 0)

ALL RECORDS:C47([RatingVehicleTypes:190])
SELECTION TO ARRAY:C260([RatingVehicleTypes:190]VehicleName_s:2; $VehCodes_atxt; [RatingVehicleTypes:190]VehicleID:1; $VehIds_aL; \
[RatingVehicleTypes:190]InvRating:5; $inv_ab; [RatingVehicleTypes:190]OperRating:6; $oper_ab)

C_LONGINT:C283($VehIndex_L)
C_POINTER:C301($Rtg_ptr)

//set all variables to zero first
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($VehCodes_atxt))
	$Rtg_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $VehCodes_atxt{$loop_L}+"Inv")
	If (Not:C34(Is nil pointer:C315($Rtg_ptr)))
		$Rtg_ptr->:=0
		If (Not:C34($inv_ab{$loop_L}))
			OBJECT SET ENTERABLE:C238(*; $VehCodes_atxt{$loop_L}+"Inv"; False:C215)
			OBJECT SET RGB COLORS:C628(*; $VehCodes_atxt{$loop_L}+"Inv"; Col_paletteToRGB(Abs:C99(<>COLOR_NOT_EDITABLE)%256); Col_paletteToRGB(Abs:C99(<>COLOR_NOT_EDITABLE)\256))  // **Replaced o OBJECT SET COLOR(*; $VehCodes_atxt{$loop_L}+"Inv"; <>COLOR_NOT_EDITABLE)
			$Rtg_ptr->:=-1
		End if 
		$Rtg_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $VehCodes_atxt{$loop_L}+"Oper")
		$Rtg_ptr->:=0
		
		If (Not:C34($oper_ab{$loop_L}))
			OBJECT SET ENTERABLE:C238(*; $VehCodes_atxt{$loop_L}+"Oper"; False:C215)
			OBJECT SET RGB COLORS:C628(*; $VehCodes_atxt{$loop_L}+"Oper"; Col_paletteToRGB(Abs:C99(<>COLOR_NOT_EDITABLE)%256); Col_paletteToRGB(Abs:C99(<>COLOR_NOT_EDITABLE)\256))  // **Replaced o OBJECT SET COLOR(*; $VehCodes_atxt{$loop_L}+"Oper"; <>COLOR_NOT_EDITABLE)
			$Rtg_ptr->:=-1
		End if 
		
	End if 
	
End for 

QUERY:C277([RatingReportVehicles:191]; [RatingReportVehicles:191]RatingID:2=[RatingReports:65]RatingID:21)
If (Records in selection:C76([RatingReportVehicles:191])>0)
	//set the values of the form variables
	FIRST RECORD:C50([RatingReportVehicles:191])
	While (Not:C34(End selection:C36([RatingReportVehicles:191])))
		$VehIndex_L:=Find in array:C230($VehIds_aL; [RatingReportVehicles:191]VehicleID:7)
		If ($VehIndex_L>0)
			$Rtg_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $VehCodes_atxt{$VehIndex_L}+"Inv")
			$Rtg_ptr->:=[RatingReportVehicles:191]InvRating:3
			$Rtg_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $VehCodes_atxt{$VehIndex_L}+"Oper")
			$Rtg_ptr->:=[RatingReportVehicles:191]OperRating:4
			
		Else 
			ALERT:C41("Unknown Vehicle ID "+String:C10([RatingReportVehicles:191]VehicleID:7)+\
				" for Rating Vehicle record ID "+String:C10([RatingReportVehicles:191]RatingVehicleID:1))
		End if 
		NEXT RECORD:C51([RatingReportVehicles:191])
	End while 
	
End if 

//End RatRep_LoadFormVariables