//%attributes = {"invisible":true}
//GP SET_Item67
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
//Calculate and return Item67, Structural Evaluation, for the current bridge.

If (False:C215)
	// Modified in Sept and Oct 2000 to match the FHWA's
	//Edit/Update program
	//Modified 3/8/01: due to one bridge not matching due to
	// item66 needing truncating prior to making a comparison
	//TRACE
	// Modified by: Costas Manousakis-(Designer)-(10/7/14 12:37:37)
	Mods_2014_10_bug
	//  `fixes for load factor values in item66  ; also allow passing of parameters for all required items
	// Modified by: Costas Manousakis-(Designer)-(2/15/18 16:16:11)
	Mods_2018_02_bug
	//  ``more fixes for load factor values in item66  - use <>SIA_LoadRtg_63_RF_txt to check on Item 65
	
	C_TEXT:C284(SET_Item67; $0)  // old C_STRING length 2
	C_REAL:C285(SET_Item67; $1)
	C_LONGINT:C283(SET_Item67; $2)
	C_TEXT:C284(SET_Item67; $3; $4; $5; $7; $8; $9; $10)  // old C_STRING length 2
	C_TEXT:C284(SET_Item67; $6)  // old C_STRING length 3
	
End if 
C_TEXT:C284($Item67; $0)  // old C_STRING length 2

C_REAL:C285($Item66)
C_LONGINT:C283($Item29)
C_TEXT:C284($item26; $Item75A; $item65; $item59; $item60; $item62; $item41)  // old C_STRING length 2
C_TEXT:C284($item43)  // old C_STRING length 3

If (Count parameters:C259=9)
	C_REAL:C285($1)
	C_LONGINT:C283($2)
	C_TEXT:C284($3; $4; $5; $7; $8; $9; $10)  // old C_STRING length 2
	C_TEXT:C284($6)  // old C_STRING length 3
	
	$item66:=$1
	$item29:=$2
	$item26:=$3
	$item41:=$4
	$item75A:=$5
	$item43:=$6
	$item59:=$7
	$item60:=$8
	$item62:=$9
	$item65:=$10
Else 
	$item66:=[Bridge MHD NBIS:1]Item66:139
	$item29:=[Bridge MHD NBIS:1]Item29:88
	$item26:=[Bridge MHD NBIS:1]Item26:120
	$item41:=[Bridge MHD NBIS:1]Item41:141
	$item75A:=[Bridge MHD NBIS:1]Item75A:152
	$item43:=[Bridge MHD NBIS:1]Item43:75
	$item59:=[Bridge MHD NBIS:1]Item59:131
	$item60:=[Bridge MHD NBIS:1]Item60:132
	$item62:=[Bridge MHD NBIS:1]Item62:134
	$item65:=[Bridge MHD NBIS:1]Item 65:200
End if 

//First, lookup the value from Table 1 in the coding guide.
//Item 29, Average Daily Traffic
//Item 26, Functional Class:
//    01=Rural Interstate    
//    11=Urban Interstate    
//    12=Urban Other Freeways or Expressways 


If ((Position:C15($item65; <>SIA_LoadRtg_63_RF_txt)>0))
	//Rating factor - multiple item66 by 32.4
	$Item66:=$Item66*32.4
End if 

//Item 66, Inventory Rating (Metric Tons)   
//TRACE
Case of 
		//check for ADT=0 taken out on 8-8-2000    
		//: (($Item66<0) | ($Item29<=0))
	: ($Item66<0)
		//End of changes  on 8-8-2000   
		$Item67:="N"
	: (($Item29>5000) | ($Item26="01") | ($Item26="11") | ($Item26="12"))
		//    Change made on 3/8/01: 
		// Item66 is being truncated to 1 decimal point before making any comparisons 
		//This is done because the NBI file that is created also truncates the value
		// and the Edit/Updat program gets item66 truncated when it makes its comparisons
		
		Case of 
				// : ($Item66>32.4)
			: (Trunc:C95($Item66; 1)>32.4)
				$Item67:="9"
				//: ($Item66=32.4)
			: (Trunc:C95($Item66; 1)=32.4)
				$Item67:="8"
				//  : ($Item66>=27.9)
			: (Trunc:C95($Item66; 1)>=27.9)
				
				$Item67:="7"
				//: ($Item66>=24.3)
			: (Trunc:C95($Item66; 1)>=24.3)
				$Item67:="6"
				//: ($Item66>=19.8)
			: (Trunc:C95($Item66; 1)>=19.8)
				$Item67:="5"
				// : ($Item66>=16.2)
			: (Trunc:C95($Item66; 1)>=16.2)
				$Item67:="4"
			: ($Item41="K")
				//The rating is low and the bridge is closed.        
				$Item67:="0"
			: (($Item75A="31") | ($Item75A="32"))
				//Replacement planned.
				$Item67:="2"
			Else 
				$Item67:="3"
		End case 
	: ($Item29>500)
		Case of 
				//: ($Item66>32.4)        
			: (Trunc:C95($Item66; 1)>32.4)
				$Item67:="9"
				// : ($Item66=32.4)
			: (Trunc:C95($Item66; 1)=32.4)
				$Item67:="8"
				//: ($Item66>=27.9)
			: (Trunc:C95($Item66; 1)>=27.9)
				$Item67:="7"
				//: ($Item66>=22.5)
			: (Trunc:C95($Item66; 1)>=22.5)
				$Item67:="6"
				//: ($Item66>=18)
			: (Trunc:C95($Item66; 1)>=18)
				$Item67:="5"
				// : ($Item66>=12.6)
			: (Trunc:C95($Item66; 1)>=12.6)
				$Item67:="4"
			: ($Item41="K")
				//The rating is low and the bridge is closed.        
				$Item67:="0"
			: (($Item75A="31") | ($Item75A="32"))
				//Replacement planned.
				$Item67:="2"
			Else 
				$Item67:="3"
		End case 
	Else 
		//ADT up to 500    
		Case of 
				// : ($Item66>32.4)
			: (Trunc:C95($Item66; 1)>32.4)
				$Item67:="9"
				//  : ($Item66=32.4)
			: (Trunc:C95($Item66; 1)=32.4)
				$Item67:="8"
				//   : ($Item66>=27.9)
			: (Trunc:C95($Item66; 1)>=27.9)
				$Item67:="7"
				// : ($Item66>=20.7)
			: (Trunc:C95($Item66; 1)>=20.7)
				$Item67:="6"
				//: ($Item66>=16.2)
			: (Trunc:C95($Item66; 1)>=16.2)
				$Item67:="5"
				//   : ($Item66>=10.8)
			: (Trunc:C95($Item66; 1)>=10.8)
				$Item67:="4"
			: ($Item41="K")
				//The rating is low and the bridge is closed.        
				$Item67:="0"
			: (($Item75A="31") | ($Item75A="32"))
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
If (Substring:C12($Item43; 2; 2)="19")
	//A Culvert.
	If (($Item62#"N") & ($Item62#"?"))
		//The culvert rating is numeric.    
		If ($Item67="N")
			//The value from Table 1 is not numeric, use the culvert rating.      
			$Item67:=$Item62
		Else 
			//Both are numeric, use the smaller value.      
			$Item67:=String:C10(MinNum(Num:C11($Item62); Num:C11($Item67)))
		End if 
	End if 
Else 
	//A Bridge.    
	Case of 
		: (($Item59="N") | ($Item59="?"))
			If (($Item60="N") | ($Item60="?"))
				//Do nothing; use the value already obtained from Table 1.
			Else 
				If ($Item67="N")
					//The value from Table 1 is not numeric, use the Substructure rating.      
					$Item67:=$Item60
				Else 
					//Substructure rating and Table 1 value are numeric; use the smaller value.      
					$Item67:=String:C10(MinNum(Num:C11($Item60); Num:C11($Item67)))
				End if 
			End if 
		: (($Item60="N") | ($Item60="?"))
			If ($Item67="N")
				//The value from Table 1 is not numeric, use the Superstructure rating.      
				$Item67:=$Item59
			Else 
				//Superstructure rating and Table 1 value are numeric; use the smaller value.     
				$Item67:=String:C10(MinNum(Num:C11($Item59); Num:C11($Item67)))
			End if 
		Else 
			If ($Item67="N")
				//Superstructure and substructure are numeric; use the smaller value.         
				$Item67:=String:C10(MinNum(Num:C11($Item59); Num:C11($Item60)))
			Else 
				//All are numeric; use the lowest rating of the three.
				$Item67:=String:C10(MinNum(Num:C11($Item59); Num:C11($Item60); Num:C11($Item67)))
			End if 
	End case 
End if 

If ($Item67="1")
	//The Structural Evaluation is zero for a structural rating of 1.
	$Item67:="0"
End if 


$0:=$Item67