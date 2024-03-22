//%attributes = {"invisible":true}
If (False:C215)
	//procedure: SET_Item68
	//by: Albert Leung
	//created: 11/6/97
	//purpose: calculate Item 68
	
	// Modified 
	//     1-dec-1999 per memo from CSC dated 22-jun-1999
	
	// Modified in August and Sept 2000 to match the code 
	//in the FHWA's Edit/Update Routines
	
	//Modified 3/19/01 to fix a bug
	//Modified 3/21/01 : Rounding Items 49 and 51 before making any comparisons
	
End if 

C_TEXT:C284($Item5c; $1)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($Item26; $2)  // Command Replaced was o_C_STRING length was 2
C_LONGINT:C283($Item28a; $3)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Item29; $4)
C_TEXT:C284($Item41; $5)  // Command Replaced was o_C_STRING length was 1
C_REAL:C285($Item49; $6)
C_REAL:C285($Item51; $7)
C_REAL:C285($Item53; $8)
C_TEXT:C284($Item75a; $9)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($Item102; $10)  // Command Replaced was o_C_STRING length was 1

C_TEXT:C284($value)  // Command Replaced was o_C_STRING length was 1
//ARRAY INTEGER($value2;5)
C_LONGINT:C283($n)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($Item68; $0)  // Command Replaced was o_C_STRING length was 2

//8/15/2000: Added new variables
C_TEXT:C284($value2E)  // Command Replaced was o_C_STRING length was 1
C_LONGINT:C283($val2a2d)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($valTab2e)  //Command Replaced was o_C_INTEGER
//End of change 8/15/2000

If (Count parameters:C259#10)
	$Item102:=[Bridge MHD NBIS:1]Item102:123
	$Item28a:=[Bridge MHD NBIS:1]Item28A:86
	//3/21/01 changes: Added round function
	//$Item51:=[Bridge MHD NBIS]Item51
	$Item51:=Round:C94([Bridge MHD NBIS:1]Item51:96; 1)
	//End of changes on 3/21/01
	$Item29:=[Bridge MHD NBIS:1]Item29:88
	//3/21/01 changes: Added round function
	//$Item49:=[Bridge MHD NBIS]Item49
	$Item49:=Round:C94([Bridge MHD NBIS:1]Item49:93; 1)
	//End of changes on 3/21/01  
	$Item41:=[Bridge MHD NBIS:1]Item41:141
	$Item26:=[Bridge MHD NBIS:1]Item26:120
	$Item5c:=Substring:C12([Bridge MHD NBIS:1]Item5:59; 3; 1)
	$Item53:=[Bridge MHD NBIS:1]Item53:105
	$Item75a:=[Bridge MHD NBIS:1]Item75A:152
Else 
	$Item5c:=$1
	$Item26:=$2
	$Item28a:=$3
	$Item29:=$4
	$Item41:=$5
	//3/21/01 changes: Added round function
	//$Item49:=$6
	// $Item51:=$7
	$Item49:=Round:C94($6; 1)
	$Item51:=Round:C94($7; 1)
	//End of changes on 3/21/01
	$Item53:=$8
	$Item75a:=$9
	$Item102:=$10
End if 

// Change 8/15/00: 
//Edit update program doesn't check for item102="0" 

//If ($Item102="0")
// $0:="N"
//Else 

// End of change on 8/15/00

$0:="N"

//Table 2A
$value:="N"
// *** Change #1 memo 6-22-1999
//  If (($Item102="2") & ($Item28a=2)) | (($Item51>4.8) & ($Item28a=1))


//Change 8/15/00: Edit/Update program doesn't check for the last OR (note3, page49
// or the check for Not Ramps as in note 6 on page 49
// Going back to the original statement

//If (($Item102="2")&($Item28a=2))|(($Item51>4.8)&($Item28a=1)&($Item5c#"7"))|(($I
If ((($Item102="2") & ($Item28a=2)) | (($Item51>4.8) & ($Item28a=1)))
	// End of change for 8/15/00    
	
	If ($Item29>5000)
		Case of 
				// 8/15/00: Edit/Update checks for bridge= closed alongwith 
				// the width criteria
				
				//   : ($Item41="K")
				//    $value:="0"
				
			: (($Item49>60) & ($Item51<7.9) & ($Item41#"K"))
				$value:="2"
			: (($Item49>60) & ($Item51<7.9) & ($Item41="K"))
				$value:="0"
				
				// 8/15/00: Edit update checks for bridge being closed
			: (($Item49>60) & ($Item51<8.5))
				$value:="3"
				// 8/15/00: Edit/Update checks for bridge= closed  alongwith the width criteria
			: (($Item49<=60) & ($Item51<9.1) & ($Item41#"K"))
				$value:="2"
			: (($Item49<=60) & ($Item51<9.1) & ($Item41="K"))
				$value:="0"  //3/19/01 bug fix
				//End of change 8/15/00
				
			: (($Item49<=60) & ($Item51<9.8))
				$value:="3"
			: ($Item51<11.6)
				$value:="4"
			: ($Item51<13.4)
				$value:="5"
			: ($Item51=13.4)
				$value:="6"
			: ($Item51>13.4)
				$value:="9"
		End case 
	End if 
	If (($Item29<5001) & ($Item29>2000))
		Case of 
				// 8/15/00: Edit/Update checks for bridge= closed  alongwith  the width criteria 
				//   : ($Item41="K")
				//    $value:="0"            
			: (($Item51<7.9) & ($item41#"K"))
				$value:="2"
			: (($Item51<7.9) & ($Item41="K"))
				$value:="0"
				//End of change 8/15/00
			: ($Item51<8.5)
				$value:="3"
			: ($Item51<10.4)
				$value:="4"
			: ($Item51<12.2)
				$value:="5"
			: ($Item51<13.4)
				$value:="6"
			: ($Item51=13.4)
				$value:="7"
			: ($Item51>13.4)
				$value:="9"
		End case 
	End if 
	If (($Item29<2001) & ($Item29>1000))
		Case of 
				// 8/15/00: Edit/Update checks for bridge= closed  alongwith the width criteria 
				//   : ($Item41="K")
				//    $value:="0"     
			: (($Item51<6.7) & ($item41#"K"))
				$value:="2"
			: (($Item51<6.7) & ($item41="K"))
				$value:="0"
				//End of change 8/15/00
			: ($Item51<7.3)
				$value:="3"
			: ($Item51<8.5)
				$value:="4"
			: ($Item51<10.4)
				$value:="5"
			: ($Item51<12.2)
				$value:="6"
			: ($Item51<13.4)
				$value:="7"
			: ($Item51=13.4)
				$value:="8"
			: ($Item51>13.4)
				$value:="9"
		End case 
	End if 
	// *** Change #2 memo 6-22-1999
	If (($Item29<1001) & ($Item29>400))
		Case of 
				// 8/15/00: Edit/Update checks for bridge= closed  alongwith the width criteria 
				//   : ($Item41="K")
				//    $value:="0"  
			: (($Item51<6.1) & ($Item41#"K"))
				$value:="2"
			: (($Item51<6.1) & ($Item41="K"))
				$value:="0"
				//End of change 8/15/00
			: ($Item51<6.7)
				$value:="3"
			: ($Item51<7.9)
				$value:="4"
			: ($Item51<9.1)
				$value:="5"
			: ($Item51<11)
				$value:="6"
			: ($Item51<12.2)
				$value:="7"
			: ($Item51=12.2)
				$value:="8"
			: ($Item51>12.2)
				$value:="9"
		End case 
	End if 
	// *** end of change #2   
	// *** Change #3 memo 6-22-1999 
	//    If (($Item29<1001) & ($Item29>400))
	If (($Item29<401) & ($Item29>100))
		Case of 
				// 8/15/00: Edit/Update checks for bridge= closed  alongwith the width criteria 
				//   : ($Item41="K")
				//    $value:="0"  
			: (($Item51<5.5) & ($item41#"K"))
				$value:="2"
			: (($Item51<5.5) & ($item41="K"))
				$value:="0"
				//End of change 8/15/00
			: ($Item51<6.1)
				$value:="3"
			: ($Item51<7.3)
				$value:="4"
			: ($Item51<8.5)
				$value:="5"
			: ($Item51<9.8)
				$value:="6"
			: ($Item51<11)
				$value:="7"
			: ($Item51=11)
				$value:="8"
			: ($Item51>11)
				$value:="9"
		End case 
	End if 
	If ($Item29<101)
		Case of 
				// 8/15/00: Edit/Update checks for bridge= closed  alongwith the width criteria
				//   : ($Item41="K")
				//    $value:="0"    
				// *** Change #5 memo 6-22-1999
				//        : ($Item51<4.8)
			: (($Item51<4.9) & ($item41#"K"))
				$value:="2"
			: (($Item51<4.9) & ($item41="K"))
				$value:="0"
				//End of change 8/15/00
			: ($Item51<5.5)
				$value:="3"
			: ($Item51<6.1)
				$value:="4"
			: ($Item51<7.3)
				$value:="5"
			: ($Item51<8.5)
				$value:="6"
			: ($Item51<9.8)
				$value:="7"
			: ($Item51=9.8)
				$value:="8"
			: ($Item51>9.8)
				$value:="9"
		End case 
	End if 
End if 
// Change on 8-15-00
//The following lines are commented out as the interpretation of taking the minini
//value from Table2a-2e is incorrect.

//  If ($value#"N")
//      $value2{1}:=Num($value)
//   Else 
//    $value2{1}:=100
//  End if 

//Table 2B

//  $value:="N"
// End of change 8/15/00

// *** Change #4 memo 6-22-1999
//  If (($Item51<=4.8) & ($Item28a=1))

//8/15/00: Edit/Update program doesn't check fort 2-way traffic
// Going back to the original commented out code above

//If (($Item51<=4.8) & ($Item28a=1) & (($Item102="2") | ($Item102="3")))

If (($Item51<=4.8) & ($Item28a=1))
	//End of change for 8/15/00      
	If ($Item29<101)
		Case of 
				// 8/15/00: Edit/Update checks for bridge= closed  alongwith the width criteria 
				//   : ($Item41="K") 
				//    $value:="0"     
			: (($Item51<3.4) & ($item41#"K"))
				$value:="2"
			: (($Item51<3.4) & ($item41="K"))
				$value:="0"
				//End of change 8/15/00
			: ($Item51<3.7)
				$value:="3"
			: ($Item51<4)
				$value:="4"
			: ($Item51<4.3)
				$value:="5"
			: ($Item51<4.6)
				$value:="6"
				// *** Change #5 memo 6-22-1999
				//        : ($Item51<4.8)
				//8/15/00: Edit/Update program still uses 4.8 as the cut off          
				//       : ($Item51<4.9)
			: ($Item51<4.8)
				//8/15/00: End of change          
				$value:="7"
				// *** Change #5 memo 6-22-1999
				//        : ($Item51=4.8)
				//8/15/00: Edit/Update program still uses 4.8 as the cut off 
				//  : ($Item51=4.9)
			: ($Item51=4.8)
				//8/15/00: End of change
				$value:="8"
		End case 
	Else 
		Case of 
				// 8/15/00: Edit/Update checks for bridge= closed  alongwith the width criteria
				// Edit/Update also does not check for item51<4.8
				//   : ($Item41="K")
				//    $value:="0"      
				//       : ($Item51<4.8)
				//      $value:="2"
			: ($Item51=4.8)
				$value:="3"
			: ($Item41#"K")
				$value:="2"
				// 8/15/00: Edit update checks for bridge being closed at the end
			: ($Item41="K")
				$value:="0"
				// 8/15/00: End of change            
		End case 
	End if 
End if 


//8/15/00: Edit/Update doesn't take the min of Tab 2A through Tab2D
// There was an interpretation error of the NBI coding guide    

//   If ($value#"N")
//     $value2{2}:=Num($value)
//  Else 
//   $value2{2}:=100
// End if 



//Table 2C
//  $value:="N"
//8/15/00  End of change


If (($Item102="1") & ($Item28a=2))
	If (($Item26="01") | ($Item26="11") | ($Item26="12"))
		Case of 
				// 8/15/00: Edit/Update checks for bridge= closed  alongwith the width  criteria 
				//   : ($Item41="K")
				//    $value:="0"                  
			: (($Item51<10.1) & ($Item49<=60) & ($Item41#"K"))
				$value:="2"
			: (($Item51<10.1) & ($Item49<=60) & ($Item41="K"))
				$value:="0"
				// End of changes on 8/15/00
			: (($Item51<10.4) & ($Item49<=60))
				$value:="3"
			: (($Item51<8.5) & ($Item49>60) & ($Item41#"K"))
				$value:="2"
			: (($Item51<8.5) & ($Item49>60) & ($Item41="K"))
				$value:="0"
			: (($Item51<8.8) & ($Item49>60))
				$value:="3"
			: ($Item51<11)
				$value:="4"
			: ($Item51<11.6)
				$value:="5"
			: ($Item51<12.2)
				$value:="6"
			: ($Item51<12.8)
				$value:="7"
			: ($Item51=12.8)
				$value:="8"
			: ($Item51>12.8)
				$value:="9"
		End case 
	End if 
End if 

If (($Item102="1") & ($Item28a=2))
	If (($Item26#"01") & ($Item26#"11") & ($Item26#"12"))
		Case of 
				// 8/15/00: Edit/Update checks for bridge= closed  alongwith the width criteria 
				//   : ($Item41="K")
				//    $value:="0"     
			: (($Item51<8.2) & ($Item41#"K"))
				$value:="2"
			: (($Item51<8.2) & ($Item41="K"))
				$value:="0"
				// End of changes on 8/15/00
			: ($Item51<9.1)
				$value:="3"
			: ($Item51<10.1)
				$value:="4"
			: ($Item51<11)
				$value:="5"
			: ($Item51<11.6)
				$value:="6"
			: ($Item51<12.8)
				$value:="7"
			: ($Item51=12.8)
				$value:="8"
			: ($Item51>12.8)
				$value:="9"
		End case 
	End if 
End if 

If ($Item28a>2)
	If (($Item26="01") | ($Item26="11") | ($Item26="12"))
		Case of 
				// 8/15/00: Edit/Update checks for bridge= closed  alongwith the width criteria
				//   : ($Item41="K")
				//    $value:="0"      
				
				//09-11-00 Change for real number comparisons 
				//The computer processor does not give an absolute value for a real number
				//Added round function to be able to do correct comparisons
				//   : ($Item51<(($Item28a*3.4)+3.4)) & ($Item49<=60) & ($item41#"K")
			: (($Item51<(Round:C94((($Item28a*3.4)+3.4); 1))) & ($Item49<=60) & ($item41#"K"))
				$value:="2"
				//   : ($Item51<(($Item28a*3.4)+3.4)) & ($Item49<=60) & ($item41="K")
			: (($Item51<(Round:C94((($Item28a*3.4)+3.4); 1))) & ($Item49<=60) & ($item41="K"))
				$value:="0"
				//  : ($Item51<(($Item28a*3.4)+3.7)) & ($Item49<=60)
			: (($Item51<(Round:C94((($Item28a*3.4)+3.7); 1))) & ($Item49<=60))
				$value:="3"
				//: ($Item51<(($Item28a*3.4)+1.8)) & ($Item49>60) & ($item41#"K")
			: (($Item51<(Round:C94((($Item28a*3.4)+1.8); 1))) & ($Item49>60) & ($item41#"K"))
				$value:="2"
				//: ($Item51<(($Item28a*3.4)+1.8)) & ($Item49>60) & ($item41="K")
			: (($Item51<(Round:C94((($Item28a*3.4)+1.8); 1))) & ($Item49>60) & ($item41="K"))
				$value:="0"
				// : ($Item51<(($Item28a*3.4)+2.1)) & ($Item49>60)
			: (($Item51<(Round:C94((($Item28a*3.4)+2.1); 1))) & ($Item49>60))
				$value:="3"
				//: ($Item51<(($Item28a*3.7)+4.3))
			: ($Item51<(Round:C94((($Item28a*3.7)+4.3); 1)))
				$value:="4"
				//  : ($Item51<(($Item28a*3.7)+4.9))
			: ($Item51<(Round:C94((($Item28a*3.7)+4.9); 1)))
				$value:="5"
				//  : ($Item51<(($Item28a*3.7)+6.1))
			: ($Item51<(Round:C94((($Item28a*3.7)+6.1); 1)))
				$value:="6"
				// : ($Item51<(($Item28a*3.7)+7.3))
			: ($Item51<(Round:C94((($Item28a*3.7)+7.3); 1)))
				$value:="7"
				// : ($Item51=(($Item28a*3.7)+7.3))
			: ($Item51=(Round:C94((($Item28a*3.7)+7.3); 1)))
				$value:="8"
				// : ($Item51>(($Item28a*3.7)+7.3))
			: ($Item51>(Round:C94((($Item28a*3.7)+7.3); 1)))
				$value:="9"
		End case 
	End if 
End if 

If ($Item28a>2)
	If (($Item26#"01") & ($Item26#"11") & ($Item26#"12"))
		Case of 
				//8/15/00: Edit/Update checks for bridge= closed  alongwith width
				//   : ($Item41="K")
				//    $value:="0"       
				
				//09-11-00 Change for real number comparisons 
				//The computer processor does not give an absolute value for a real number
				//Added round function to be able to do correct comparisons
				
				//: ($Item51<(($Item28a*3.4)+1.5)) & ($item41#"K")
			: (($Item51<(Round:C94((($Item28a*3.4)+1.5); 1))) & ($item41#"K"))
				$value:="2"
				//  : ($Item51<(($Item28a*3.4)+1.5)) & ($item41="K")
			: (($Item51<(Round:C94((($Item28a*3.4)+1.5); 1))) & ($item41="K"))
				$value:="0"
				//: ($Item51<(($Item28a*3.4)+1.8))
			: ($Item51<(Round:C94((($Item28a*3.4)+1.8); 1)))
				$value:="3"
				// : ($Item51<(($Item28a*3.4)+3))
			: ($Item51<(Round:C94((($Item28a*3.4)+3); 1)))
				$value:="4"
				//: ($Item51<(($Item28a*3.7)+3.7))
			: ($Item51<(Round:C94((($Item28a*3.7)+3.7); 1)))
				$value:="5"
				// : ($Item51<(($Item28a*3.7)+4.6))
			: ($Item51<(Round:C94((($Item28a*3.7)+4.6); 1)))
				$value:="6"
				// : ($Item51<(($Item28a*3.7)+5.5))
			: ($Item51<(Round:C94((($Item28a*3.7)+5.5); 1)))
				$value:="7"
				// : ($Item51=(($Item28a*3.7)+5.5))
			: ($Item51=(Round:C94((($Item28a*3.7)+5.5); 1)))
				$value:="8"
				//  : ($Item51>(($Item28a*3.7)+5.5))
			: ($Item51>(Round:C94((($Item28a*3.7)+5.5); 1)))
				$value:="9"
		End case 
	End if 
End if 


//8/15/00: Edit/Update doesn't take the min of Tab 2A through Tab2D 
//If ($value#"N")
// $value2{3}:=Num($value)
//Else 
//  $value2{3}:=100
//End if 

//Table 2D
//$value:="N"
//8/15/00: End of change


// *** Change #6a memo 6-22-1999  
//  If ($Item5c="7") & ($Item28a=1)
//8/15/00: Edit/Update doesn't check for 1-way traffic in its code,
// going back to the original code

//If ($Item5c="7") & ($Item28a=1) & ($Item102="1")
If (($Item5c="7") & ($Item28a=1))
	// End of change for 8/15/00
	Case of 
			// 8/15/00: Edit/Update checks for bridge= closed  alongwith width 
			//   : ($Item41="K")
			//    $value:="0"        
		: (($Item51<4.9) & ($item41#"K"))
			$value:="2"
		: (($Item51<4.9) & ($item41="K"))
			$value:="0"
		: ($Item51<5.5)
			$value:="3"
		: ($Item51<6.1)
			$value:="4"
		: ($Item51<6.7)
			$value:="5"
		: ($Item51<7.3)
			$value:="6"
		: ($Item51<7.9)
			$value:="7"
		: ($Item51=7.9)
			$value:="8"
		: ($Item51>7.9)
			$value:="9"
	End case 
End if 

// *** Change #6b memo 6-22-1999  
//  If ($Item5c="7") & ($Item28a>1)
//8/15/00: Edit/Update doesn't check for 1-way traffic in its code,
// going back to the original code
//If ($Item5c="7") & ($Item28a>1) & ($Item102="1")
If (($Item5c="7") & ($Item28a>1))
	Case of 
			// 8/15/00: Edit/Update checks for bridge= closed  alongwith the width criteria
			//   : ($Item41="K")
			//    $value:="0"       
			
			//09-11-00 Change for real number comparisons 
			//The computer processor does not give an absolute value for a real number
			//Added round function to be able to do correct comparisons
			
			//  : ($Item51<(($Item28a*3.7)+0.6)) & ($item41#"K")
		: (($Item51<(Round:C94((($Item28a*3.7)+0.6); 1))) & ($item41#"K"))
			$value:="2"
			//  : ($Item51<(($Item28a*3.7)+0.6)) & ($item41="K")
		: (($Item51<(Round:C94((($Item28a*3.7)+0.6); 1))) & ($item41="K"))
			$value:="0"
			// : ($Item51<(($Item28a*3.7)+1.2))
		: ($Item51<(Round:C94((($Item28a*3.7)+1.2); 1)))
			$value:="3"
			//: ($Item51<(($Item28a*3.7)+1.8))
		: ($Item51<(Round:C94((($Item28a*3.7)+1.8); 1)))
			$value:="4"
			//  : ($Item51<(($Item28a*3.7)+2.4))
		: ($Item51<(Round:C94((($Item28a*3.7)+2.4); 1)))
			$value:="5"
			// : ($Item51<(($Item28a*3.7)+3))
		: ($Item51<(Round:C94((($Item28a*3.7)+3); 1)))
			$value:="6"
			//: ($Item51<(($Item28a*3.7)+3.7))
		: ($Item51<(Round:C94((($Item28a*3.7)+3.7); 1)))
			$value:="7"
			// : ($Item51=(($Item28a*3.7)+3.7))
		: ($Item51=(Round:C94((($Item28a*3.7)+3.7); 1)))
			$value:="8"
			//  : ($Item51>(($Item28a*3.7)+3.7))
		: ($Item51>(Round:C94((($Item28a*3.7)+3.7); 1)))
			$value:="9"
	End case 
End if 


//8/15/00: Edit/Update doesn't take the min of Tab 2a through Tab2D
//If ($value#"N")
//  $value2{4}:=Num($value)
//Else 
//  $value2{4}:=100
//End if 





//Table 2E
//$value:="N"
//Need to take the min between the last value of Tab2a-Tab2d and Tab2E
// All occurences of value are changed to value2e for Table2e below
$value2E:="N"
//8/15/00: End of change

If (($Item26="01") | ($Item26="11") | ($Item26="12"))
	Case of 
			// 8/15/00: Edit/Update checks for bridge= closed  alongwith the width criteria
			//   : ($Item41="K")
			//    $value:="0"     
		: (($Item53<4.57) & ($item41="K"))
			$value2E:="0"
		: (($Item53<4.57) & (Position:C15($Item75a; "31.32")>0))
			// $value:="2"
			$value2E:="2"
		: (($Item53<4.57) & (Position:C15($Item75a; "33.34.35.36.37.38")>0))
			//  $value:="3"
			$value2e:="3"
		: ($Item53<4.57)
			//$value:="3"
			$value2e:="3"
		: ($Item53<4.8)
			// $value:="4"
			$value2e:="4"
		: ($Item53<5.02)
			// $value:="5"
			$value2e:="5"
		: ($Item53<5.1)
			// $value:="6"
			$value2e:="6"
		: ($Item53<5.18)
			//  $value:="7"
			$value2e:="7"
		: ($Item53=5.18)
			$value2e:="8"
			//$value:="8"
		: ($Item53>5.18)
			// $value:="9"
			$value2e:="9"
	End case 
End if 

If (Position:C15($Item26; "07.08.09.17.19.02.06.14.16")>0)
	Case of 
			// 8/15/00: Edit/Update checks for bridge= closed  alongwith the width criteria
			//   : ($Item41="K")
			//    $value:="0"     
		: (($Item53<4.26) & ($item41="K"))
			$value2e:="0"
		: (($Item53<4.26) & (Position:C15($Item75a; "31.32")>0))
			// $value:="2"
			$value2e:="2"
		: (($Item53<4.26) & (Position:C15($Item75a; "33.34.35.36.37.38")>0))
			// $value:="3"
			$value2e:="3"
		: ($Item53<4.26)
			// $value:="3"
			$value2e:="3"
		: ($Item53<4.34)
			//  $value:="4"
			$value2e:="4"
		: ($Item53<4.41)
			// $value:="5"
			$value2e:="5"
		: ($Item53<4.72)
			// $value:="6"
			$value2e:="6"
		: ($Item53<5.02)
			//$value:="7"
			$value2e:="7"
		: ($Item53=5.02)
			//  $value:="8"
			$value2e:="8"
		: ($Item53>5.02)
			//  $value:="9"
			$value2e:="9"
	End case 
End if 

//If ($value#"N")
//  $value2{5}:=Num($value)
//Else 
//  $value2{5}:=100
//End if 


If ($value#"N")
	$val2a2d:=Num:C11($value)
Else 
	$val2a2d:=100
End if 

If ($value2e#"N")
	$valTab2e:=Num:C11($value2e)
Else 
	$valTab2e:=100
End if 


If (($val2a2d#100) & ($valTab2e#100))
	$n:=MinNum($val2a2d; $valTab2e)
Else 
	$n:=100
End if 



//The code below is commented out as Edit/Update doesnot take the minimum
// from Tab2A through Tab2E.  This was mis-interpretation of the NBI coding guide

//$n:=MinNum ($value2{1};$value2{2})
//$n:=MinNum ($value2{3};$n)
//$n:=MinNum ($value2{4};$n)
//$n:=MinNum ($value2{5};$n)

If ($n#100)
	$value:=String:C10($n)
Else 
	$value:="N"
End if 

// *** Change #7 memo 6-22-1999  
If ((Substring:C12([Bridge MHD NBIS:1]Item43:75; 2; 2)="19") & ($Item51=0))
	$value:="N"
End if 
// *** end of Change #7  

//8/15/00 changes
//1)Edit/Update program cross-checks item28a with item103
// 2)Edit/Update program checks for item51=0
// Added the above two cross checks

If ((($item102="3") & ($item28a>1)) | ($item51=0))
	$value:="N"
End if 

// 8/15/00:End of changes

$Item68:=$value
$0:=$Item68

// 8\15\00:There is no longer an ELSE statement
//End if 