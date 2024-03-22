//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/05/11, 17:11:40
	// ----------------------------------------------------
	// Method: SIA_SET_Item67
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	//copy from GP SET_Item67
	//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
	
	//Calculate and return Item67, Structural Evaluation, for the current bridge.
	// Modified in Sept and Oct 2000 to match the FHWA's
	//Edit/Update program
	//Modified 3/8/01: due to one bridge not matching due to
	// item66 needing truncating prior to making a comparison
	//TRACE
	
	Mods_2011_10
End if 

C_TEXT:C284($Item67; $0)  // Command Replaced was o_C_STRING length was 2

//First, lookup the value from Table 1 in the coding guide.
//Item 29, Average Daily Traffic
//Item 26, Functional Class:
//    01=Rural Interstate    
//    11=Urban Interstate    
//    12=Urban Other Freeways or Expressways 
//Item 66, Inventory Rating (Metric Tons)   
//TRACE
C_REAL:C285($Itm66_r; $1)
C_LONGINT:C283($Itm29_L; $2)
C_TEXT:C284($itm26_txt; $3; $itm41_txt; $4; $itm75A_txt; $5; $itm43_txt; $6; $itm62_txt; $7; $itm59_txt; $8; $itm60_txt; $9)
$Itm66_r:=$1
$Itm29_L:=$2
$itm26_txt:=$3
$itm41_txt:=$4
$itm75A_txt:=$5
$itm43_txt:=$6
$itm62_txt:=$7
$itm59_txt:=$8
$itm60_txt:=$9
Case of 
		//check for ADT=0 taken out on 8-8-2000    
		//: (($Itm66_r<0) | ($Itm29_L<=0))
	: ($Itm66_r<0)
		//End of changes  on 8-8-2000   
		$Item67:="N"
	: (($Itm29_L>5000) | ($itm26_txt="01") | ($itm26_txt="11") | ($itm26_txt="12"))
		//    Change made on 3/8/01: 
		// Item66 is being truncated to 1 decimal point before making any comparisons 
		//This is done because the NBI file that is created also truncates the value
		// and the Edit/Updat program gets item66 truncated when it makes its comparisons
		
		Case of 
				// : ($Itm66_r>32.4)
			: (Trunc:C95($Itm66_r; 1)>32.4)
				$Item67:="9"
				//: ($Itm66_r=32.4)
			: (Trunc:C95($Itm66_r; 1)=32.4)
				$Item67:="8"
				//  : ($Itm66_r>=27.9)
			: (Trunc:C95($Itm66_r; 1)>=27.9)
				
				$Item67:="7"
				//: ($Itm66_r>=24.3)
			: (Trunc:C95($Itm66_r; 1)>=24.3)
				$Item67:="6"
				//: ($Itm66_r>=19.8)
			: (Trunc:C95($Itm66_r; 1)>=19.8)
				$Item67:="5"
				// : ($Itm66_r>=16.2)
			: (Trunc:C95($Itm66_r; 1)>=16.2)
				$Item67:="4"
			: ($itm41_txt="K")
				//The rating is low and the bridge is closed.        
				$Item67:="0"
			: (($itm75A_txt="31") | ($itm75A_txt="32"))
				//Replacement planned.
				$Item67:="2"
			Else 
				$Item67:="3"
		End case 
	: ($Itm29_L>500)
		Case of 
				//: ($Itm66_r>32.4)        
			: (Trunc:C95($Itm66_r; 1)>32.4)
				$Item67:="9"
				// : ($Itm66_r=32.4)
			: (Trunc:C95($Itm66_r; 1)=32.4)
				$Item67:="8"
				//: ($Itm66_r>=27.9)
			: (Trunc:C95($Itm66_r; 1)>=27.9)
				$Item67:="7"
				//: ($Itm66_r>=22.5)
			: (Trunc:C95($Itm66_r; 1)>=22.5)
				$Item67:="6"
				//: ($Itm66_r>=18)
			: (Trunc:C95($Itm66_r; 1)>=18)
				$Item67:="5"
				// : ($Itm66_r>=12.6)
			: (Trunc:C95($Itm66_r; 1)>=12.6)
				$Item67:="4"
			: ($itm41_txt="K")
				//The rating is low and the bridge is closed.        
				$Item67:="0"
			: (($itm75A_txt="31") | ($itm75A_txt="32"))
				//Replacement planned.
				$Item67:="2"
			Else 
				$Item67:="3"
		End case 
	Else 
		//ADT up to 500    
		Case of 
				// : ($Itm66_r>32.4)
			: (Trunc:C95($Itm66_r; 1)>32.4)
				$Item67:="9"
				//  : ($Itm66_r=32.4)
			: (Trunc:C95($Itm66_r; 1)=32.4)
				$Item67:="8"
				//   : ($Itm66_r>=27.9)
			: (Trunc:C95($Itm66_r; 1)>=27.9)
				$Item67:="7"
				// : ($Itm66_r>=20.7)
			: (Trunc:C95($Itm66_r; 1)>=20.7)
				$Item67:="6"
				//: ($Itm66_r>=16.2)
			: (Trunc:C95($Itm66_r; 1)>=16.2)
				$Item67:="5"
				//   : ($Itm66_r>=10.8)
			: (Trunc:C95($Itm66_r; 1)>=10.8)
				$Item67:="4"
			: ($itm41_txt="K")
				//The rating is low and the bridge is closed.        
				$Item67:="0"
			: (($itm75A_txt="31") | ($itm75A_txt="32"))
				//Replacement planned.
				$Item67:="2"
			Else 
				$Item67:="3"
		End case 
End case 

//Next, compare the value from Table 1 with the structural ratings.
//Item 43 Structure Type
//Item 59 Superstructure Rating
//Item 60 Substructure Rating
//Item 62 Culvert Rating
//Note:  Function Num will convert a "?" to zero.
If (Substring:C12($itm43_txt; 2; 2)="19")
	//A Culvert.
	If (($itm62_txt#"N") & ($itm62_txt#"?"))
		//The culvert rating is numeric.    
		If ($Item67="N")
			//The value from Table 1 is not numeric, use the culvert rating.      
			$Item67:=$itm62_txt
		Else 
			//Both are numeric, use the smaller value.      
			$Item67:=String:C10(MinNum(Num:C11($itm62_txt); Num:C11($Item67)))
		End if 
	End if 
Else 
	//A Bridge.    
	Case of 
		: (($itm59_txt="N") | ($itm59_txt="?"))
			If (($itm60_txt="N") | ($itm60_txt="?"))
				//Do nothing; use the value already obtained from Table 1.
			Else 
				If ($Item67="N")
					//The value from Table 1 is not numeric, use the Substructure rating.      
					$Item67:=$itm60_txt
				Else 
					//Substructure rating and Table 1 value are numeric; use the smaller value.      
					$Item67:=String:C10(MinNum(Num:C11($itm60_txt); Num:C11($Item67)))
				End if 
			End if 
		: (($itm60_txt="N") | ($itm60_txt="?"))
			If ($Item67="N")
				//The value from Table 1 is not numeric, use the Superstructure rating.      
				$Item67:=$itm59_txt
			Else 
				//Superstructure rating and Table 1 value are numeric; use the smaller value.     
				$Item67:=String:C10(MinNum(Num:C11($itm59_txt); Num:C11($Item67)))
			End if 
		Else 
			If ($Item67="N")
				//Superstructure and substructure are numeric; use the smaller value.         
				$Item67:=String:C10(MinNum(Num:C11($itm59_txt); Num:C11($itm60_txt)))
			Else 
				//All are numeric; use the lowest rating of the three.
				$Item67:=String:C10(MinNum(Num:C11($itm59_txt); Num:C11($itm60_txt); Num:C11($Item67)))
			End if 
	End case 
End if 

If ($Item67="1")
	//The Structural Evaluation is zero for a structural rating of 1.
	$Item67:="0"
End if 


$0:=$Item67