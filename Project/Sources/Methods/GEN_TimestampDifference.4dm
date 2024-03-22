//%attributes = {"invisible":true}
//Method: GEN_TimestampDifference
//Description 
// Compare two ISO dateTimeStamps and return the time difference between them 
// Copied from 4D knowledgebase
// Parameters
// $0 - C_TIME-Difference in time
// $1 - C_STRING-ISO dateTimeStamp #1
// $2 - C_STRING - ISO dateTimeStamp #2

// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/26/18, 10:55:10
	// ----------------------------------------------------
	//Created : 
	Mods_2018_09
	C_TIME:C306(GEN_TimestampDifference; $0)
	C_TEXT:C284(GEN_TimestampDifference; $1)
	C_TEXT:C284(GEN_TimestampDifference; $2)
	
End if 
//
//method_parameters_declarations
C_TIME:C306($0)
C_TEXT:C284($Timestamp1_A19; $1)
C_TEXT:C284($Timestamp2_A19; $2)

//--------------------------------------------------------------------------
//method_wide_constants_declarations
//--------------------------------------------------------------------------
//local_variable_declarations
C_LONGINT:C283($Ndx; $SOA; $RIS; $Params_L; $Year_L; $Month_L; $Day_L)
C_DATE:C307($Date1_D; $Date2_D)
C_TIME:C306($Hours_H; $Time1_H; $Time2_H)

$Params_L:=Count parameters:C259
$0:=?00:00:00?

//======================== Method Actions ==================================

Case of 
	: ($Params_L<2)
		
	: (Length:C16($1)#19)
		
	: (Length:C16($2)#19)
		
	: ($1=$2)
		
	Else 
		If ($1>$2)  //if 1st timestamp is the most recent
			$Timestamp1_A19:=$1
			$Timestamp2_A19:=$2
			
		Else 
			$Timestamp1_A19:=$2
			$Timestamp2_A19:=$1
			
		End if 
		
		$Year_L:=Num:C11(Substring:C12($Timestamp1_A19; 1; 4))
		$Month_L:=Num:C11(Substring:C12($Timestamp1_A19; 6; 2))
		$Day_L:=Num:C11(Substring:C12($Timestamp1_A19; 9; 2))
		$Date1_D:=Add to date:C393(!00-00-00!; $Year_L; $Month_L; $Day_L)
		
		$Year_L:=Num:C11(Substring:C12($Timestamp2_A19; 1; 4))
		$Month_L:=Num:C11(Substring:C12($Timestamp2_A19; 6; 2))
		$Day_L:=Num:C11(Substring:C12($Timestamp2_A19; 9; 2))
		$Date2_D:=Add to date:C393(!00-00-00!; $Year_L; $Month_L; $Day_L)
		
		$Hours_H:=(24*?01:00:00?)*($Date1_D-$Date2_D)
		$Time1_H:=Time:C179(Substring:C12($Timestamp1_A19; 12))
		$Time2_H:=Time:C179(Substring:C12($Timestamp2_A19; 12))
		
		$0:=$Hours_H+($Time1_H-$Time2_H)
		
End case 
//End GEN_TimestampDifference