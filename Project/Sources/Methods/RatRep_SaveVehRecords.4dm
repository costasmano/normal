//%attributes = {"invisible":true}
//Method: RatRep_SaveVehRecords
//Description
// Save the records for the vehicles
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/06/19, 14:19:16
	// ----------------------------------------------------
	//Created : 
	Mods_2019_11
End if 
//

READ ONLY:C145([RatingVehicleTypes:190])
ARRAY TEXT:C222($VehCodes_atxt; 0)
ARRAY LONGINT:C221($VehIds_aL; 0)
C_LONGINT:C283($VehIndex_L)
C_POINTER:C301($Rtg_ptr)

ALL RECORDS:C47([RatingVehicleTypes:190])
SELECTION TO ARRAY:C260([RatingVehicleTypes:190]VehicleName_s:2; $VehCodes_atxt; [RatingVehicleTypes:190]VehicleID:1; $VehIds_aL)

C_LONGINT:C283($vehicle_L)
C_REAL:C285($invRtg_r; $OprRtg_r)
For ($vehicle_L; 1; Size of array:C274($VehCodes_atxt))
	$Rtg_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $VehCodes_atxt{$vehicle_L}+"Inv")
	If (Not:C34(Is nil pointer:C315($Rtg_ptr)))
		$invRtg_r:=$Rtg_ptr->
		$Rtg_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $VehCodes_atxt{$vehicle_L}+"Oper")
		$OprRtg_r:=$Rtg_ptr->
		//is there an existing record for this vehicle
		QUERY:C277([RatingReportVehicles:191]; [RatingReportVehicles:191]VehicleID:7=$VehIds_aL{$vehicle_L}; *)
		QUERY:C277([RatingReportVehicles:191];  & ; [RatingReportVehicles:191]RatingID:2=[RatingReports:65]RatingID:21)
		
		If ($invRtg_r>0) | ($OprRtg_r>0)
			//there are some values - either create a record or update existing
			
			If (Records in selection:C76([RatingReportVehicles:191])=0)
				//create record
				CREATE RECORD:C68([RatingReportVehicles:191])
				Inc_Sequence(Table name:C256(->[RatingReportVehicles:191]); ->[RatingReportVehicles:191]RatingVehicleID:1)
				[RatingReportVehicles:191]RatingID:2:=[RatingReports:65]RatingID:21
				SAVE RECORD:C53([RatingReportVehicles:191])
				LogNewRecord(->[RatingReports:65]RatingID:21; ->[RatingReportVehicles:191]RatingID:2; ->[RatingReportVehicles:191]RatingVehicleID:1; 2; Table name:C256(->[RatingReportVehicles:191]))
				
			End if 
			If (ut_LoadRecordInteractive(->[RatingReportVehicles:191]))
				InitChangeStack(3)
				[RatingReportVehicles:191]VehicleID:7:=$VehIds_aL{$vehicle_L}
				[RatingReportVehicles:191]InvRating:3:=$invRtg_r
				[RatingReportVehicles:191]OperRating:4:=$OprRtg_r
				PushAllChanges(3; ->[RatingReportVehicles:191]; ->[RatingReportVehicles:191]RatingID:2; ->[RatingReportVehicles:191]RatingVehicleID:1)
				FlushGrpChgs(3; ->[RatingReports:65]RatingID:21; ->[RatingReportVehicles:191]RatingID:2; ->[RatingReportVehicles:191]RatingVehicleID:1; 2)
				SAVE RECORD:C53([RatingReportVehicles:191])
			Else 
				ALERT:C41("Could not update the record for vehicle "+$VehCodes_atxt{$vehicle_L}+" !")
			End if 
			
		Else 
			//zero rating values - need to update the vehicle record only if it exists
			If (Records in selection:C76([RatingReportVehicles:191])=1)
				//and only if it has non-zero ratings
				If ([RatingReportVehicles:191]InvRating:3=0) & ([RatingReportVehicles:191]OperRating:4=0)
				Else 
					If (ut_LoadRecordInteractive(->[RatingReportVehicles:191]))
						InitChangeStack(3)
						[RatingReportVehicles:191]InvRating:3:=$invRtg_r
						[RatingReportVehicles:191]OperRating:4:=$OprRtg_r
						PushAllChanges(3; ->[RatingReportVehicles:191]; ->[RatingReportVehicles:191]RatingID:2; ->[RatingReportVehicles:191]RatingVehicleID:1)
						FlushGrpChgs(3; ->[RatingReports:65]RatingID:21; ->[RatingReportVehicles:191]RatingID:2; ->[RatingReportVehicles:191]RatingVehicleID:1; 2)
						SAVE RECORD:C53([RatingReportVehicles:191])
						
					Else 
						ALERT:C41("Could not update the record for vehicle "+$VehCodes_atxt{$vehicle_L}+" !")
					End if 
					
				End if 
				
			End if 
			
		End if 
		
	End if 
	
End for 

If (False:C215)
	// *****  
	// *****  Code for listbox instead of fields/variables on form
	// *****  
	ARRAY TEXT:C222($VehName_atxt; 0)
	ARRAY LONGINT:C221($InvRating_aL; 0)
	ARRAY LONGINT:C221($OprRating_aL; 0)
	ARRAY LONGINT:C221($Legacy_aL; 0)
	ARRAY LONGINT:C221($Sequence_aL; 0)
	ARRAY LONGINT:C221($LegacyInvFieldNum_aL; 0)
	ARRAY LONGINT:C221($LegacyOprFieldNum_aL; 0)
	ARRAY LONGINT:C221($VehicleID_aL; 0)
	Begin SQL
		select [RatingVehicleTypes].[VehicleName_s]
		, [RatingVehicleTypes].[VehicleID]
		, [RatingVehicleTypes].[Sequence]
		, cast([RatingVehicleTypes].[Legacy] as INT)
		, [RatingVehicleTypes].[LegacyInvFieldNo_L]
		, [RatingVehicleTypes].[LegacyOprFieldNo_L]
		, cast([RatingVehicleTypes].[OperRating] as INT)
		, cast([RatingVehicleTypes].[InvRating] as INT)
		from
		[RatingVehicleTypes]
		order by [RatingVehicleTypes].[Sequence]
		into :$VehName_atxt
		, :$VehicleID_aL
		, :$Sequence_aL
		, :$Legacy_aL
		, :$LegacyInvFieldNum_aL
		, :$LegacyOprFieldNum_aL
		, :$OprRating_aL
		, :$InvRating_aL ;
		
	End SQL
	
	C_LONGINT:C283($vehicle_L)
	C_REAL:C285($invRtg_r; $OprRtg_r)
	C_TEXT:C284($arrayName_txt)
	C_POINTER:C301($colVar_ptr)
	For ($vehicle_L; 1; Size of array:C274($VehicleID_aL))
		$arrayName_txt:=$VehName_atxt{$vehicle_L}+"arr"
		$colVar_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $arrayName_txt)
		$invRtg_r:=$colVar_ptr->{1}
		$OprRtg_r:=$colVar_ptr->{2}
		
		If ($Legacy_aL{$vehicle_L}=1)
			//data is in the [ratingreport] table {1} is inventory {2} Operating
			(Field:C253(Table:C252(->[RatingReports:65]); $LegacyInvFieldNum_aL{$vehicle_L}))->:=$invRtg_r
			(Field:C253(Table:C252(->[RatingReports:65]); $LegacyOprFieldNum_aL{$vehicle_L}))->:=$OprRtg_r
			
		Else 
			//data in the [RatingReportVehicles] table
			
			//is there an existing record for this vehicle
			QUERY:C277([RatingReportVehicles:191]; [RatingReportVehicles:191]VehicleID:7=$VehicleID_aL{$vehicle_L}; *)
			QUERY:C277([RatingReportVehicles:191];  & ; [RatingReportVehicles:191]RatingID:2=[RatingReports:65]RatingID:21)
			
			If ($invRtg_r>0) | ($OprRtg_r>0)
				//there are some values - either create a record or update existing
				
				If (Records in selection:C76([RatingReportVehicles:191])=0)
					//create record
					CREATE RECORD:C68([RatingReportVehicles:191])
					Inc_Sequence(Table name:C256(->[RatingReportVehicles:191]); ->[RatingReportVehicles:191]RatingVehicleID:1)
					[RatingReportVehicles:191]RatingID:2:=[RatingReports:65]RatingID:21
					SAVE RECORD:C53([RatingReportVehicles:191])
					LogNewRecord(->[RatingReports:65]RatingID:21; ->[RatingReportVehicles:191]RatingID:2; ->[RatingReportVehicles:191]RatingVehicleID:1; 2; Table name:C256(->[RatingReportVehicles:191]))
					
				End if 
				If (ut_LoadRecordInteractive(->[RatingReportVehicles:191]))
					InitChangeStack(3)
					[RatingReportVehicles:191]VehicleID:7:=$VehicleID_aL{$vehicle_L}
					[RatingReportVehicles:191]InvRating:3:=$invRtg_r
					[RatingReportVehicles:191]OperRating:4:=$OprRtg_r
					PushAllChanges(3; ->[RatingReportVehicles:191]; ->[RatingReportVehicles:191]RatingID:2; ->[RatingReportVehicles:191]RatingVehicleID:1)
					FlushGrpChgs(3; ->[RatingReports:65]RatingID:21; ->[RatingReportVehicles:191]RatingID:2; ->[RatingReportVehicles:191]RatingVehicleID:1; 2)
					SAVE RECORD:C53([RatingReportVehicles:191])
				Else 
					ALERT:C41("Could not update the record for vehicle "+$VehName_atxt{$vehicle_L}+" !")
				End if 
				
			Else 
				//zero rating values - need to update the vehicle record only if it exists
				If (Records in selection:C76([RatingReportVehicles:191])=1)
					//and only if it has non-zero ratings
					If ([RatingReportVehicles:191]InvRating:3=0) & ([RatingReportVehicles:191]OperRating:4=0)
					Else 
						If (ut_LoadRecordInteractive(->[RatingReportVehicles:191]))
							InitChangeStack(3)
							[RatingReportVehicles:191]InvRating:3:=$invRtg_r
							[RatingReportVehicles:191]OperRating:4:=$OprRtg_r
							PushAllChanges(3; ->[RatingReportVehicles:191]; ->[RatingReportVehicles:191]RatingID:2; ->[RatingReportVehicles:191]RatingVehicleID:1)
							FlushGrpChgs(3; ->[RatingReports:65]RatingID:21; ->[RatingReportVehicles:191]RatingID:2; ->[RatingReportVehicles:191]RatingVehicleID:1; 2)
							SAVE RECORD:C53([RatingReportVehicles:191])
							
						Else 
							ALERT:C41("Could not update the record for vehicle "+$VehName_atxt{$vehicle_L}+" !")
						End if 
						
					End if 
					
				End if 
				
			End if 
			
		End if 
		
	End for 
	
	
End if 
//End RatRep_SaveVehRecords