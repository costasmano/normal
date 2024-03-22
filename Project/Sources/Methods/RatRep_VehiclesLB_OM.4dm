//%attributes = {"invisible":true}
//Method: RatRep_VehiclesLB_OM
//Description
// object method for the rating vehicles Listbox in the the rating report input form
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/15/19, 12:44:29
	// ----------------------------------------------------
	//Created : 
	Mods_2019_11
End if 
//
C_TEXT:C284($LBName_txt)
$LBName_txt:=OBJECT Get name:C1087(Object current:K67:2)

Case of 
	: (Form event code:C388=On Load:K2:1)
		//load data from definitions table
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
		
		//create the listbox
		
		C_LONGINT:C283($loop_L; $bestW; $BestHt; $total_w; $colW)
		C_POINTER:C301($NilPtr; $colVar_ptr)
		C_TEXT:C284($arrayName_txt; $HeaderName_txt)
		
		LISTBOX DELETE COLUMN:C830(*; $LBName_txt; 1; 99)
		$arrayName_txt:="FirstColumn"
		$HeaderName_txt:=$arrayName_txt+"hdr"
		LISTBOX INSERT COLUMN:C829(*; $LBName_txt; 1; $arrayName_txt; $NilPtr; $HeaderName_txt; $NilPtr)
		$colVar_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $arrayName_txt)
		ARRAY TEXT:C222($colVar_ptr->; 2)
		$colVar_ptr->{1}:="Inv."
		$colVar_ptr->{2}:="Oper."
		LISTBOX SET COLUMN WIDTH:C833(*; $arrayName_txt; 60)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $arrayName_txt; Align center:K42:3)
		OBJECT SET VERTICAL ALIGNMENT:C1187(*; $arrayName_txt; Align center:K42:3)
		OBJECT SET ENTERABLE:C238(*; $arrayName_txt; False:C215)
		$total_w:=60
		
		For ($loop_L; 1; Size of array:C274($VehName_atxt))
			$arrayName_txt:=$VehName_atxt{$loop_L}+"arr"
			$HeaderName_txt:=$VehName_atxt{$loop_L}+"hdr"
			LISTBOX INSERT COLUMN:C829(*; $LBName_txt; ($loop_L+1); $arrayName_txt; $NilPtr; $HeaderName_txt; $NilPtr)
			OBJECT SET TITLE:C194(*; $HeaderName_txt; $VehName_atxt{$loop_L})
			OBJECT GET BEST SIZE:C717(*; $HeaderName_txt; $bestW; $BestHt)
			$colVar_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $arrayName_txt)
			ARRAY REAL:C219($colVar_ptr->; 2)
			If ($InvRating_aL{$loop_L}=0)
				$colVar_ptr->{1}:=-1
			End if 
			If ($OprRating_aL{$loop_L}=0)
				$colVar_ptr->{2}:=-1
			End if 
			OBJECT SET FILTER:C235(*; $arrayName_txt; "|PosReals")
			OBJECT SET FORMAT:C236(*; $arrayName_txt; "#,###.0;-")
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $arrayName_txt; Align center:K42:3)
			OBJECT SET VERTICAL ALIGNMENT:C1187(*; $arrayName_txt; Align center:K42:3)
			$colW:=MaxNum(50; ($bestW+20))
			LISTBOX SET COLUMN WIDTH:C833(*; $arrayName_txt; $colW)
			$total_w:=$total_w+$colw
		End for 
		C_LONGINT:C283($ol; $oT; $oR; $ob)
		
		OBJECT GET COORDINATES:C663(*; $LBName_txt; $ol; $oT; $oR; $ob)
		
		OBJECT MOVE:C664(*; $LBName_txt; 0; 0; ($total_w-($oR-$ol)); 0)
		
		//get data from the [RatingReportVehicles]
		ARRAY LONGINT:C221($RVID_al; 0)
		ARRAY REAL:C219($RVInv_ar; 0)
		ARRAY REAL:C219($RVOper_ar; 0)
		C_LONGINT:C283($Reportid_L)
		$Reportid_L:=[RatingReports:65]RatingID:21
		Begin SQL
			select
			[RatingReportVehicles].[VehicleID]
			, [RatingReportVehicles].[InvRating]
			, [RatingReportVehicles].[OperRating]
			from [RatingReportVehicles]
			where [RatingReportVehicles].[RatingID] = :$Reportid_L
			into 
			:$RVID_al
			, :$RVInv_ar
			, :$RVOper_ar ;
		End SQL
		
		//load data in the listbox arrays
		C_LONGINT:C283($indx_L)
		C_REAL:C285($Inv_r; $Opr_r)
		For ($loop_L; 1; Size of array:C274($VehName_atxt))
			$arrayName_txt:=$VehName_atxt{$loop_L}+"arr"
			$colVar_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $arrayName_txt)
			$Inv_r:=$colVar_ptr->{1}
			$Opr_r:=$colVar_ptr->{2}
			
			If ($Legacy_aL{$loop_L}=1)
				//data is in the [ratingreport] table {1} is inventory {2} Operating
				$Inv_r:=(Field:C253(Table:C252(->[RatingReports:65]); $LegacyInvFieldNum_aL{$loop_L}))->
				$Opr_r:=(Field:C253(Table:C252(->[RatingReports:65]); $LegacyOprFieldNum_aL{$loop_L}))->
				
			Else 
				//data in the [RatingReportVehicles] table
				$indx_L:=Find in array:C230($RVID_al; $VehicleID_aL{$loop_L})
				If ($indx_L>0)
					$Inv_r:=$RVInv_ar{$indx_L}
					$Opr_r:=$RVOper_ar{$indx_L}
				End if 
			End if 
			
			$colVar_ptr->{1}:=$Inv_r
			$colVar_ptr->{2}:=$Opr_r
			
		End for 
		
	: (Form event code:C388=On Data Change:K2:15)
		C_LONGINT:C283($Col_L; $row_L)
		C_POINTER:C301($var_ptr)
		LISTBOX GET CELL POSITION:C971(*; $LBName_txt; $Col_L; $row_L; $var_ptr)
		//check if we changed from a negative number
		If ($var_ptr->{0}<0)
			$var_ptr->{$row_L}:=-1  //set it back to -1
		End if 
		
	: (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Getting Focus:K2:7)
		C_LONGINT:C283($Col_L; $row_L)
		C_POINTER:C301($var_ptr)
		LISTBOX GET CELL POSITION:C971(*; $LBName_txt; $Col_L; $row_L; $var_ptr)
		
		
	: (Form event code:C388=On Before Data Entry:K2:39)
		//how do we get where we're at?
		C_LONGINT:C283($Col_L; $row_L)
		C_POINTER:C301($var_ptr)
		LISTBOX GET CELL POSITION:C971(*; $LBName_txt; $Col_L; $row_L; $var_ptr)
		//check the current value of the array 
		If ($var_ptr->{$row_L}>=0)
			//ok
		Else 
			//we have to skip this
			POST KEY:C465(Tab key:K12:28)
			//and set it back to -1 
			$var_ptr->{$row_L}:=-1
		End if 
End case 

//End RatRep_VehiclesLB_OM