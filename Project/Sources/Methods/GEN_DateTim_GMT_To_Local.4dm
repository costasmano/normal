//%attributes = {"invisible":true}
//Method: GEN_DateTim_GMT_To_Local
//Description
//         Path: UTIL_DateTime_GMT_To_Local

//         Purpose: Convert ISO GMT date string to local time, date and ISO date string

// Parameters
//         $0 - OBJECT - Local date, time and string
//         $1 - TEXT - GMT Date< Time String
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/26/18, 15:04:18
	// ----------------------------------------------------
	//Created : 
	Mods_2018_09
	
	C_OBJECT:C1216(GEN_DateTim_GMT_To_Local; $0)
	C_TEXT:C284(GEN_DateTim_GMT_To_Local; $1)
	
End if 
//
//method_parameters_declarations
C_OBJECT:C1216($0; $LocalDtTi_O)
C_TEXT:C284($DTStr_GMT_T; $1)
//--------------------------------------------------------------------------
//method_wide_constants_declarations
//--------------------------------------------------------------------------
//local_variable_declarations
C_LONGINT:C283($Ndx; $SOA; $RIS; $Params_L)
C_DATE:C307($DtGMT_D; $DtLocal_D)
C_TIME:C306($TiGMT_H; $TiLocal_H)
C_LONGINT:C283($Offset_L)
C_TEXT:C284($GMToffset_T; $DTStr_GMT_T; $DTStr_T)

$Params_L:=Count parameters:C259
If (Asserted:C1132($Params_L>=1; "Expected one parameter"))
	$DTStr_GMT_T:=$1
	$GMToffset_T:=GEN_GetTimeZoneOffset  // see tech tip http://kb.4d.com/assetid=76220
	
	//======================== Method Actions ==================================
	
	// Extract the hours difference and convert to seconds
	//
	$Offset_L:=Num:C11(Substring:C12($GMToffset_T; 1; Position:C15(":"; $GMToffset_T)-1))*(60*60)
	
	// If $DTStr_GMT_T is a properly formated with "Z" time zone
	// 4D automatically applies date diff if any, otherwise date is unchanged
	//
	$DtGMT_D:=Date:C102($DTStr_GMT_T)
	$TiGMT_H:=Time:C179(Substring:C12($DTStr_GMT_T; 12))
	
	Case of 
		: ($Offset_L<0)  // Time zones west of GMT
			$TiLocal_H:=Time:C179($TiGMT_H+$Offset_L)
			$DtLocal_D:=$DtGMT_D
			If ($TiLocal_H<0)
				$TiLocal_H:=$TiLocal_H+?12:00:00?
			End if 
			
		: ($Offset_L>0)  // Time zones east of GMT
			$TiLocal_H:=Time:C179($TiGMT_H+$Offset_L)
			$DtLocal_D:=$DtGMT_D
			If ($TiLocal_H>(?24:00:00?))
				$TiLocal_H:=$TiLocal_H-?24:00:00?
			End if 
			
		Else   // Same GMT zone
			$TiLocal_H:=$TiGMT_H
			$DtLocal_D:=$DtGMT_D
			
	End case 
	
	//modified from KB not to show AM/PM - instead show 24hr time
	$DTStr_T:=String:C10($DtLocal_D; ISO date:K1:8; $TiLocal_H)  //+Choose($TiLocal_H>?12:00:00?;"AM";"PM")
	OB SET:C1220($LocalDtTi_O; "date"; String:C10($DtLocal_D))
	OB SET:C1220($LocalDtTi_O; "time"; String:C10($TiLocal_H; HH MM SS:K7:1))
	OB SET:C1220($LocalDtTi_O; "string"; $DTStr_T)
	
	//======================== Clean up and Exit =================================
	
	$0:=$LocalDtTi_O
	
End if 

//End GEN_DateTim_GMT_To_Local