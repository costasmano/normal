//%attributes = {"invisible":true}
// Method: ARCHIVE_RecalcAASHTO
// Description
// ReCalc aashto for selected [BridgeMHDNBISArchive] records
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/11/10, 18:18:19
	// ----------------------------------------------------
	// 
	// Parameters
	// $1 : $Task_txt
	// ----------------------------------------------------
	
	Mods_2011_09
	// Modified by: Costas Manousakis-(Designer)-(3/1/17 15:56:03)
	Mods_2017_03
	//  `use ◊SIA_LoadRtg_63_RF_txt to decide if  item 64 is rating factor or MT
	// Modified by: Costas Manousakis-(Designer)-(10/25/17 12:12:14)
	Mods_2017_10
	//  `use new ProgressNew and UpdateProgressNew
End if 
C_TEXT:C284($Task_txt)
If (Count parameters:C259=1)
	C_TEXT:C284($1)
	$Task_txt:=$1
Else 
	$Task_txt:=""
End if 

Case of 
	: ($Task_txt="SET_Item67")
		
		C_TEXT:C284($0)
		C_TEXT:C284($Item67)  // Command Replaced was o_C_STRING length was 2
		
		//First, lookup the value from Table 1 in the coding guide.
		//Item 29, Average Daily Traffic
		//Item 26, Functional Class:
		//    01=Rural Interstate    
		//    11=Urban Interstate    
		//    12=Urban Other Freeways or Expressways 
		//Item 66, Inventory Rating (Metric Tons)   
		//TRACE
		Case of 
				//check for ADT=0 taken out on 8-8-2000    
				//: (([BridgeMHDNBISArchive]Item66<0) | ([BridgeMHDNBISArchive]Item29<=0))
			: ([BridgeMHDNBISArchive:139]Item66:138<0)
				//End of changes  on 8-8-2000   
				$Item67:="N"
			: (([BridgeMHDNBISArchive:139]Item29:87>5000) | ([BridgeMHDNBISArchive:139]Item26:119="01") | ([BridgeMHDNBISArchive:139]Item26:119="11") | ([BridgeMHDNBISArchive:139]Item26:119="12"))
				//    Change made on 3/8/01: 
				// Item66 is being truncated to 1 decimal point before making any comparisons 
				//This is done because the NBI file that is created also truncates the value
				// and the Edit/Updat program gets item66 truncated when it makes its comparisons
				
				Case of 
						// : ([BridgeMHDNBISArchive]Item66>32.4)
					: (Trunc:C95([BridgeMHDNBISArchive:139]Item66:138; 1)>32.4)
						$Item67:="9"
						//: ([BridgeMHDNBISArchive]Item66=32.4)
					: (Trunc:C95([BridgeMHDNBISArchive:139]Item66:138; 1)=32.4)
						$Item67:="8"
						//  : ([BridgeMHDNBISArchive]Item66>=27.9)
					: (Trunc:C95([BridgeMHDNBISArchive:139]Item66:138; 1)>=27.9)
						
						$Item67:="7"
						//: ([BridgeMHDNBISArchive]Item66>=24.3)
					: (Trunc:C95([BridgeMHDNBISArchive:139]Item66:138; 1)>=24.3)
						$Item67:="6"
						//: ([BridgeMHDNBISArchive]Item66>=19.8)
					: (Trunc:C95([BridgeMHDNBISArchive:139]Item66:138; 1)>=19.8)
						$Item67:="5"
						// : ([BridgeMHDNBISArchive]Item66>=16.2)
					: (Trunc:C95([BridgeMHDNBISArchive:139]Item66:138; 1)>=16.2)
						$Item67:="4"
					: ([BridgeMHDNBISArchive:139]Item41:140="K")
						//The rating is low and the bridge is closed.        
						$Item67:="0"
					: (([BridgeMHDNBISArchive:139]Item75A:151="31") | ([BridgeMHDNBISArchive:139]Item75A:151="32"))
						//Replacement planned.
						$Item67:="2"
					Else 
						$Item67:="3"
				End case 
			: ([BridgeMHDNBISArchive:139]Item29:87>500)
				Case of 
						//: ([BridgeMHDNBISArchive]Item66>32.4)        
					: (Trunc:C95([BridgeMHDNBISArchive:139]Item66:138; 1)>32.4)
						$Item67:="9"
						// : ([BridgeMHDNBISArchive]Item66=32.4)
					: (Trunc:C95([BridgeMHDNBISArchive:139]Item66:138; 1)=32.4)
						$Item67:="8"
						//: ([BridgeMHDNBISArchive]Item66>=27.9)
					: (Trunc:C95([BridgeMHDNBISArchive:139]Item66:138; 1)>=27.9)
						$Item67:="7"
						//: ([BridgeMHDNBISArchive]Item66>=22.5)
					: (Trunc:C95([BridgeMHDNBISArchive:139]Item66:138; 1)>=22.5)
						$Item67:="6"
						//: ([BridgeMHDNBISArchive]Item66>=18)
					: (Trunc:C95([BridgeMHDNBISArchive:139]Item66:138; 1)>=18)
						$Item67:="5"
						// : ([BridgeMHDNBISArchive]Item66>=12.6)
					: (Trunc:C95([BridgeMHDNBISArchive:139]Item66:138; 1)>=12.6)
						$Item67:="4"
					: ([BridgeMHDNBISArchive:139]Item41:140="K")
						//The rating is low and the bridge is closed.        
						$Item67:="0"
					: (([BridgeMHDNBISArchive:139]Item75A:151="31") | ([BridgeMHDNBISArchive:139]Item75A:151="32"))
						//Replacement planned.
						$Item67:="2"
					Else 
						$Item67:="3"
				End case 
			Else 
				//ADT up to 500    
				Case of 
						// : ([BridgeMHDNBISArchive]Item66>32.4)
					: (Trunc:C95([BridgeMHDNBISArchive:139]Item66:138; 1)>32.4)
						$Item67:="9"
						//  : ([BridgeMHDNBISArchive]Item66=32.4)
					: (Trunc:C95([BridgeMHDNBISArchive:139]Item66:138; 1)=32.4)
						$Item67:="8"
						//   : ([BridgeMHDNBISArchive]Item66>=27.9)
					: (Trunc:C95([BridgeMHDNBISArchive:139]Item66:138; 1)>=27.9)
						$Item67:="7"
						// : ([BridgeMHDNBISArchive]Item66>=20.7)
					: (Trunc:C95([BridgeMHDNBISArchive:139]Item66:138; 1)>=20.7)
						$Item67:="6"
						//: ([BridgeMHDNBISArchive]Item66>=16.2)
					: (Trunc:C95([BridgeMHDNBISArchive:139]Item66:138; 1)>=16.2)
						$Item67:="5"
						//   : ([BridgeMHDNBISArchive]Item66>=10.8)
					: (Trunc:C95([BridgeMHDNBISArchive:139]Item66:138; 1)>=10.8)
						$Item67:="4"
					: ([BridgeMHDNBISArchive:139]Item41:140="K")
						//The rating is low and the bridge is closed.        
						$Item67:="0"
					: (([BridgeMHDNBISArchive:139]Item75A:151="31") | ([BridgeMHDNBISArchive:139]Item75A:151="32"))
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
		If (Substring:C12([BridgeMHDNBISArchive:139]Item43:74; 2; 2)="19")
			//A Culvert.
			If (([BridgeMHDNBISArchive:139]Item62:133#"N") & ([BridgeMHDNBISArchive:139]Item62:133#"?"))
				//The culvert rating is numeric.    
				If ($Item67="N")
					//The value from Table 1 is not numeric, use the culvert rating.      
					$Item67:=[BridgeMHDNBISArchive:139]Item62:133
				Else 
					//Both are numeric, use the smaller value.      
					$Item67:=String:C10(MinNum(Num:C11([BridgeMHDNBISArchive:139]Item62:133); Num:C11($Item67)))
				End if 
			End if 
		Else 
			//A Bridge.    
			Case of 
				: (([BridgeMHDNBISArchive:139]Item59:130="N") | ([BridgeMHDNBISArchive:139]Item59:130="?"))
					If (([BridgeMHDNBISArchive:139]Item60:131="N") | ([BridgeMHDNBISArchive:139]Item60:131="?"))
						//Do nothing; use the value already obtained from Table 1.
					Else 
						If ($Item67="N")
							//The value from Table 1 is not numeric, use the Substructure rating.      
							$Item67:=[BridgeMHDNBISArchive:139]Item60:131
						Else 
							//Substructure rating and Table 1 value are numeric; use the smaller value.      
							$Item67:=String:C10(MinNum(Num:C11([BridgeMHDNBISArchive:139]Item60:131); Num:C11($Item67)))
						End if 
					End if 
				: (([BridgeMHDNBISArchive:139]Item60:131="N") | ([BridgeMHDNBISArchive:139]Item60:131="?"))
					If ($Item67="N")
						//The value from Table 1 is not numeric, use the Superstructure rating.      
						$Item67:=[BridgeMHDNBISArchive:139]Item59:130
					Else 
						//Superstructure rating and Table 1 value are numeric; use the smaller value.     
						$Item67:=String:C10(MinNum(Num:C11([BridgeMHDNBISArchive:139]Item59:130); Num:C11($Item67)))
					End if 
				Else 
					If ($Item67="N")
						//Superstructure and substructure are numeric; use the smaller value.         
						$Item67:=String:C10(MinNum(Num:C11([BridgeMHDNBISArchive:139]Item59:130); Num:C11([BridgeMHDNBISArchive:139]Item60:131)))
					Else 
						//All are numeric; use the lowest rating of the three.
						$Item67:=String:C10(MinNum(Num:C11([BridgeMHDNBISArchive:139]Item59:130); Num:C11([BridgeMHDNBISArchive:139]Item60:131); Num:C11($Item67)))
					End if 
			End case 
		End if 
		
		If ($Item67="1")
			//The Structural Evaluation is zero for a structural rating of 1.
			$Item67:="0"
		End if 
		
		$0:=$Item67
		
	: ($Task_txt="SET_Item68")
		C_TEXT:C284($0)
		
		
		C_TEXT:C284($Item5c)  // Command Replaced was o_C_STRING length was 1
		C_TEXT:C284($Item26)  // Command Replaced was o_C_STRING length was 2
		C_LONGINT:C283($Item28a)  //Command Replaced was o_C_INTEGER
		C_LONGINT:C283($Item29)
		C_TEXT:C284($Item41)  // Command Replaced was o_C_STRING length was 1
		C_REAL:C285($Item49)
		C_REAL:C285($Item51)
		C_REAL:C285($Item53)
		C_TEXT:C284($Item75a)  // Command Replaced was o_C_STRING length was 2
		C_TEXT:C284($Item102)  // Command Replaced was o_C_STRING length was 1
		
		C_TEXT:C284($value)  // Command Replaced was o_C_STRING length was 1
		//ARRAY INTEGER($value2;5)
		C_LONGINT:C283($n)  //Command Replaced was o_C_INTEGER
		C_TEXT:C284($Item68)  // Command Replaced was o_C_STRING length was 2
		
		//8/15/2000: Added new variables
		C_TEXT:C284($value2E)  // Command Replaced was o_C_STRING length was 1
		C_LONGINT:C283($val2a2d)  //Command Replaced was o_C_INTEGER
		C_LONGINT:C283($valTab2e)  //Command Replaced was o_C_INTEGER
		//End of change 8/15/2000
		$Item102:=[BridgeMHDNBISArchive:139]Item102:122
		$Item28a:=[BridgeMHDNBISArchive:139]Item28A:85
		//3/21/01 changes: Added round function
		//$Item51:=[BridgeMHDNBISArchive]Item51
		$Item51:=Round:C94([BridgeMHDNBISArchive:139]Item51:95; 1)
		//End of changes on 3/21/01
		$Item29:=[BridgeMHDNBISArchive:139]Item29:87
		//3/21/01 changes: Added round function
		//$Item49:=[BridgeMHDNBISArchive]Item49
		$Item49:=Round:C94([BridgeMHDNBISArchive:139]Item49:92; 1)
		//End of changes on 3/21/01  
		$Item41:=[BridgeMHDNBISArchive:139]Item41:140
		$Item26:=[BridgeMHDNBISArchive:139]Item26:119
		$Item5c:=Substring:C12([BridgeMHDNBISArchive:139]Item5:58; 3; 1)
		$Item53:=[BridgeMHDNBISArchive:139]Item53:104
		$Item75a:=[BridgeMHDNBISArchive:139]Item75A:151
		
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
		If ((Substring:C12([BridgeMHDNBISArchive:139]Item43:74; 2; 2)="19") & ($Item51=0))
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
	: ($Task_txt="SET_Item69")
		C_TEXT:C284($0)
		//GP SET_Item69
		//Written by Thomas D. Nee
		
		//Modified
		//    1-dec-1999 per memo from CSC dated 23-jun-1999
		//Modified in Aug and Sept 2000 to match the code from the
		// FHWA's Edit/Update program
		
		
		//Calculate and return Item69, Underclearances Evaluation, for the current bridge.
		
		C_TEXT:C284($Item69; $Item69B)  // Command Replaced was o_C_STRING length was 2
		C_TEXT:C284($Item42B)  // Command Replaced was o_C_STRING length was 1
		C_LONGINT:C283($SecRecs; $Column)  //Command Replaced was o_C_INTEGER
		C_BOOLEAN:C305($Ramp)
		//C_REAL($MinLatClr)
		// *** Change #1 memo 23-6-1999
		C_BOOLEAN:C305($oneway)
		C_BOOLEAN:C305($twoway)
		// *** end of change #1
		
		//First, lookup the value from Table 1 in the coding guide.
		//Item 29, Average Daily Traffic
		//Item 26, Functional Class:
		//    01=Rural Interstate    
		//    11=Urban Interstate    
		//    12=Urban Other Freeways or Expressways 
		//Item 66, Inventory Rating (Metric Tons)   
		
		$Item42B:=Substring:C12([BridgeMHDNBISArchive:139]Item42:84; 2; 1)
		Case of 
			: (($Item42B="3") | ($Item42B="5") | ($Item42B="9") | ($Item42B="0"))
				//The bridge is not over a highway or a railroad.
				$Item69:="N"
			: (([BridgeMHDNBISArchive:139]Item54A:106="N") | ([BridgeMHDNBISArchive:139]Item54B:107=0) | ([BridgeMHDNBISArchive:139]Item55A:109="N"))
				//The underclearances are not set?  
				$Item69:="N"
			: ((([BridgeMHDNBISArchive:139]Item54A:106#"R") & ([BridgeMHDNBISArchive:139]Item54A:106#"H")) | (([BridgeMHDNBISArchive:139]Item55A:109#"R") & ([BridgeMHDNBISArchive:139]Item55A:109#"H")))
				//The underclearances are not set?
				//3/23/01 : Changed the ? to N to avoid problems with the last If statement
				//       at the end of this routine.
				// $Item69:="?"
				$Item69:="N"
			Else 
				
				//Find the column to use in Table 3A and 3B.  This is determined
				//by the functional classification of the underpassing route.
				If (([BridgeMHDNBISArchive:139]Item54A:106="R"))
					//The bridge is over a railroad.
					$Column:=4
				Else 
					//Look for secondary records.
					If (False:C215)
						RELATE MANY:C262([BridgeMHDNBISArchive:139]BIN:3)
					Else 
						QUERY:C277([NBIS Secondary:3]; [NBIS Secondary:3]BIN:1=[BridgeMHDNBISArchive:139]BIN:3)
					End if 
					$SecRecs:=Records in selection:C76([NBIS Secondary:3])
					If ($SecRecs<1)
						//No secondary record; assume Major/Minor Collector/Local.
						$Column:=3
					Else 
						//Use the functional classification of the secondary record
						//for the most significant route (i.e., lowest functional class).
						
						// CHANGE on 10-4-00: SORT SELECTION is changed to ORDER BY for v6.5.6
						//  SORT SELECTION([NBIS Secondary];[NBIS Secondary]Item26)
						
						ORDER BY:C49([NBIS Secondary:3]; [NBIS Secondary:3]Item26:18)
						
						// *** Change #2 memo 23-6-1999
						If ([NBIS Secondary:3]Item102:30="1")
							$oneway:=True:C214
						Else 
							$oneway:=False:C215
						End if 
						
						If ([NBIS Secondary:3]Item102:30="2")
							$twoway:=True:C214
						Else 
							$twoway:=False:C215
						End if 
						// *** end of change #2
						
						Case of 
								
							: (([NBIS Secondary:3]Item26:18="01") | ([NBIS Secondary:3]Item26:18="11") | ([NBIS Secondary:3]Item26:18="12") | ([NBIS Secondary:3]Item26:18="  ") | ([NBIS Secondary:3]Item26:18=""))
								//Interstate and other Freeway.  Assume this if I26 is blank.
								$Column:=1
								If (Substring:C12([NBIS Secondary:3]Item5:4; 3; 1)="7")
									//This is a secondary record for a ramp underneath.          
									$Ramp:=True:C214
								Else 
									$Ramp:=False:C215
								End if 
								
							: (([NBIS Secondary:3]Item26:18="02") | ([NBIS Secondary:3]Item26:18="06") | ([NBIS Secondary:3]Item26:18="14") | ([NBIS Secondary:3]Item26:18="16"))
								
								//Other Principal and Minor Arterial.
								$Column:=2
							Else 
								//Major and Minor Collectors and Locals.
								$Column:=3
						End case 
					End if 
				End if 
				
				
				
				//Table 3A     
				Case of 
					: ($Column=1)
						Case of 
							: ([BridgeMHDNBISArchive:139]Item54B:107>5.18)
								$Item69:="9"
							: ([BridgeMHDNBISArchive:139]Item54B:107=5.18)
								$Item69:="8"
							: ([BridgeMHDNBISArchive:139]Item54B:107>=5.1)
								$Item69:="7"
							: ([BridgeMHDNBISArchive:139]Item54B:107>=5.02)
								$Item69:="6"
							: ([BridgeMHDNBISArchive:139]Item54B:107>=4.8)
								$Item69:="5"
							: ([BridgeMHDNBISArchive:139]Item54B:107>=4.57)
								$Item69:="4"
							: ([BridgeMHDNBISArchive:139]Item41:140="K")
								//The rating is low and the bridge is closed.        
								$Item69:="0"
							: (([BridgeMHDNBISArchive:139]Item75A:151="31") | ([BridgeMHDNBISArchive:139]Item75A:151="32"))
								//Replacement planned.
								$Item69:="2"
							Else 
								$Item69:="3"
						End case 
						
					: (($Column=2) | ($Column=3))
						Case of 
							: ([BridgeMHDNBISArchive:139]Item54B:107>5.02)
								$Item69:="9"
							: ([BridgeMHDNBISArchive:139]Item54B:107=5.02)
								$Item69:="8"
							: ([BridgeMHDNBISArchive:139]Item54B:107>=4.72)
								$Item69:="7"
							: ([BridgeMHDNBISArchive:139]Item54B:107>=4.41)
								$Item69:="6"
							: ([BridgeMHDNBISArchive:139]Item54B:107>=4.34)
								$Item69:="5"
							: ([BridgeMHDNBISArchive:139]Item54B:107>=4.26)
								$Item69:="4"
							: ([BridgeMHDNBISArchive:139]Item41:140="K")
								//The rating is low and the bridge is closed.        
								$Item69:="0"
							: (([BridgeMHDNBISArchive:139]Item75A:151="31") | ([BridgeMHDNBISArchive:139]Item75A:151="32"))
								//Replacement planned.
								$Item69:="2"
							Else 
								$Item69:="3"
						End case 
						
					Else   //Use the 4th column, railroad.
						Case of 
							: ([BridgeMHDNBISArchive:139]Item54B:107>7.01)
								$Item69:="9"
							: ([BridgeMHDNBISArchive:139]Item54B:107=7.01)
								$Item69:="8"
							: ([BridgeMHDNBISArchive:139]Item54B:107>=6.85)
								$Item69:="7"
							: ([BridgeMHDNBISArchive:139]Item54B:107>=6.7)
								$Item69:="6"
							: ([BridgeMHDNBISArchive:139]Item54B:107>=6.4)
								$Item69:="5"
							: ([BridgeMHDNBISArchive:139]Item54B:107>=6.09)
								$Item69:="4"
							: ([BridgeMHDNBISArchive:139]Item41:140="K")
								//The rating is low and the bridge is closed.        
								$Item69:="0"
							: (([BridgeMHDNBISArchive:139]Item75A:151="31") | ([BridgeMHDNBISArchive:139]Item75A:151="32"))
								//Replacement planned.
								$Item69:="2"
							Else 
								$Item69:="3"
						End case 
				End case   //End of Table 3A.
				
				//Table 3B.     
				//8/23/00:    Need to check if item55a = Railroad for table 3b
				
				If (([BridgeMHDNBISArchive:139]Item55A:109="R"))
					//The bridge is over a railroad.
					$Column:=4
				End if 
				
				//Commented the line below as using the MinLatClr is incorrect.    
				//    $MinLatClr:=MinNum ([BridgeMHDNBISArchive]Item55B;[BridgeMHDNBISArchive]Item56)
				// end of change on 8/23/00
				
				Case of 
						// *** Change #3 memo 23-6-1999        
						//      : ($Column=1)
						//8/22/00 - EDIT/UPDATE doesn't check for traffic direction
						// Go back to original 
						//  : ($Column=1) & ($oneway)
					: ($Column=1)
						// End of change 8/22/00        
						If ($Ramp)
							Case of 
								: (([BridgeMHDNBISArchive:139]Item55B:110>3) & ([BridgeMHDNBISArchive:139]Item56:111>1.2))
									$Item69B:="9"
								: ((([BridgeMHDNBISArchive:139]Item55B:110=3) & ([BridgeMHDNBISArchive:139]Item56:111>=1.2)) | (([BridgeMHDNBISArchive:139]Item55B:110>=3) & ([BridgeMHDNBISArchive:139]Item56:111=1.2)))
									$Item69B:="8"
								: (([BridgeMHDNBISArchive:139]Item55B:110>=2.7) & ([BridgeMHDNBISArchive:139]Item56:111>=0.9))
									$Item69B:="7"
								: (([BridgeMHDNBISArchive:139]Item55B:110>=2.4) & ([BridgeMHDNBISArchive:139]Item56:111>=0.6))
									$Item69B:="6"
								: (([BridgeMHDNBISArchive:139]Item55B:110>=1.8) & ([BridgeMHDNBISArchive:139]Item56:111>=0.6))
									$Item69B:="5"
								: (([BridgeMHDNBISArchive:139]Item55B:110>=1.2) & ([BridgeMHDNBISArchive:139]Item56:111>=0.6))
									$Item69B:="4"
								: ([BridgeMHDNBISArchive:139]Item41:140="K")
									//The rating is low and the bridge is closed.        
									$Item69B:="0"
								: (([BridgeMHDNBISArchive:139]Item75A:151="31") | ([BridgeMHDNBISArchive:139]Item75A:151="32"))
									//Replacement planned.
									$Item69B:="2"
								Else 
									$Item69B:="3"
							End case 
						Else 
							//Main Line (not a ramp).          
							Case of 
								: (([BridgeMHDNBISArchive:139]Item55B:110>9.1) & ([BridgeMHDNBISArchive:139]Item56:111>9.1))
									$Item69B:="9"
								: ((([BridgeMHDNBISArchive:139]Item55B:110=9.1) & ([BridgeMHDNBISArchive:139]Item56:111>=9.1)) | (([BridgeMHDNBISArchive:139]Item55B:110>=9.1) & ([BridgeMHDNBISArchive:139]Item56:111=9.1)))
									$Item69B:="8"
								: (([BridgeMHDNBISArchive:139]Item55B:110>=6.4) & ([BridgeMHDNBISArchive:139]Item56:111>=5.5))
									$Item69B:="7"
								: (([BridgeMHDNBISArchive:139]Item55B:110>=3.7) & ([BridgeMHDNBISArchive:139]Item56:111>=1.8))
									$Item69B:="6"
								: (([BridgeMHDNBISArchive:139]Item55B:110>=3.4) & ([BridgeMHDNBISArchive:139]Item56:111>=1.5))
									$Item69B:="5"
								: (([BridgeMHDNBISArchive:139]Item55B:110>=3) & ([BridgeMHDNBISArchive:139]Item56:111>=1.2))
									$Item69B:="4"
								: ([BridgeMHDNBISArchive:139]Item41:140="K")
									//The rating is low and the bridge is closed.        
									$Item69B:="0"
								: (([BridgeMHDNBISArchive:139]Item75A:151="31") | ([BridgeMHDNBISArchive:139]Item75A:151="32"))
									//Replacement planned.
									$Item69B:="2"
								Else 
									$Item69B:="3"
							End case 
						End if 
						// *** Change #4 memo 23-6-1999
						//8/22/00 Edit/Update doesn't check for direction of traffic
						// comment out change# 4 from memo on 23-6-1999
						//    : ($Column=1) & ($twoway)
						//     If ($ramp)
						//      Case of 
						//       : ([BridgeMHDNBISArchive]Item55B>3)
						//        $Item69B:="9"
						//     : ([BridgeMHDNBISArchive]Item55B=3)
						//      $Item69B:="8"
						//   : ([BridgeMHDNBISArchive]Item55B>=2.7)
						//    $Item69B:="7"
						// : ([BridgeMHDNBISArchive]Item55B>=2.4)
						//  $Item69B:="6"
						//: ([BridgeMHDNBISArchive]Item55B>=1.8)
						// $Item69B:="5"
						//: ([BridgeMHDNBISArchive]Item55B>=1.2)
						// $Item69B:="4"
						//: ([BridgeMHDNBISArchive]Item41="K")
						//The rating is low and the bridge is closed.        
						// $Item69B:="0"
						//: (([BridgeMHDNBISArchive]Item75A="31") | ([BridgeMHDNBISArchive]Item75A="32"))
						//Replacement planned.
						// $Item69B:="2"
						//Else 
						// $Item69B:="3"
						// End case 
						// Else 
						//Main line (not a ramp)
						//  Case of 
						//   : ([BridgeMHDNBISArchive]Item55B>9.1)
						//    $Item69B:="9"
						// : ([BridgeMHDNBISArchive]Item55B=9.1)
						//  $Item69B:="8"
						//: ([BridgeMHDNBISArchive]Item55B>=6.4)
						// $Item69B:="7"
						//  : ([BridgeMHDNBISArchive]Item55B>=3.7)
						//   $Item69B:="6"
						//: ([BridgeMHDNBISArchive]Item55B>=3.4)
						// $Item69B:="5"
						//: ([BridgeMHDNBISArchive]Item55B>=3)
						//  $Item69B:="4"
						// : ([BridgeMHDNBISArchive]Item41="K")
						//The rating is low and the bridge is closed.        
						//  $Item69B:="0"
						//: (([BridgeMHDNBISArchive]Item75A="31") | ([BridgeMHDNBISArchive]Item75A="32"))
						//Replacement planned.
						//      $Item69B:="2"
						//   Else 
						//    $Item69B:="3"
						//End case 
						// End if 
						// *** end of change #4 
						
						// *** Change #5 memo 23-6-1999
						// 8/22/00:         
						//Edit Update doesn't check for Ramps under two-way traffic i.e note3 on page54
						
						//      : ($Column=2) & ($ramp)
						//       Case of 
						//        : ([BridgeMHDNBISArchive]Item55B>3)
						//         $Item69B:="9"
						//      : ([BridgeMHDNBISArchive]Item55B=3)
						//       $Item69B:="8"
						//    : ([BridgeMHDNBISArchive]Item55B>=2.7)
						//     $Item69B:="7"
						//  : ([BridgeMHDNBISArchive]Item55B>=2.4)
						//   $Item69B:="6"
						//: ([BridgeMHDNBISArchive]Item55B>=1.8)
						// $Item69B:="5"
						//: ([BridgeMHDNBISArchive]Item55B>=1.2)
						// $Item69B:="4"
						//: ([BridgeMHDNBISArchive]Item41="K")
						//The rating is low and the bridge is closed.        
						// $Item69B:="0"
						//: (([BridgeMHDNBISArchive]Item75A="31") | ([BridgeMHDNBISArchive]Item75A="32"))
						//Replacement planned.
						// $Item69B:="2"
						//Else 
						// $Item69B:="3"
						//End case 
						// *** End of change #5       
						//End of change on 8/22/00
						
					: ($Column=2)
						Case of 
							: ([BridgeMHDNBISArchive:139]Item55B:110>9.1)
								$Item69B:="9"
							: ([BridgeMHDNBISArchive:139]Item55B:110=9.1)
								$Item69B:="8"
							: ([BridgeMHDNBISArchive:139]Item55B:110>=6.4)
								$Item69B:="7"
							: ([BridgeMHDNBISArchive:139]Item55B:110>=3.7)
								$Item69B:="6"
							: ([BridgeMHDNBISArchive:139]Item55B:110>=3)
								$Item69B:="5"
							: ([BridgeMHDNBISArchive:139]Item55B:110>=1.8)
								$Item69B:="4"
							: ([BridgeMHDNBISArchive:139]Item41:140="K")
								//The rating is low and the bridge is closed.        
								$Item69B:="0"
							: (([BridgeMHDNBISArchive:139]Item75A:151="31") | ([BridgeMHDNBISArchive:139]Item75A:151="32"))
								//Replacement planned.
								$Item69B:="2"
							Else 
								$Item69B:="3"
						End case 
						
						// *** Change #6 memo 23-6-1999
						// 8/22/00:         
						//Edit Update doesn't check for Ramps under two-way traffic i.e note3 on page54
						//    : ($Column=3) & ($ramp)
						//     Case of 
						//       : ([BridgeMHDNBISArchive]Item55B>3)
						//         $Item69B:="9"
						//       : ([BridgeMHDNBISArchive]Item55B=3)
						//         $Item69B:="8"
						//       : ([BridgeMHDNBISArchive]Item55B>=2.7)
						//         $Item69B:="7"
						//       : ([BridgeMHDNBISArchive]Item55B>=2.4)
						//         $Item69B:="6"
						//       : ([BridgeMHDNBISArchive]Item55B>=1.8)
						//         $Item69B:="5"
						//       : ([BridgeMHDNBISArchive]Item55B>=1.2)
						//         $Item69B:="4"
						//       : ([BridgeMHDNBISArchive]Item41="K")
						//           `The rating is low and the bridge is closed.        
						//        $Item69B:="0"
						//     : (([BridgeMHDNBISArchive]Item75A="31") | ([BridgeMHDNBISArchive]Item75A="32"))
						//        `Replacement planned.
						//     $Item69B:="2"
						//  Else 
						//   $Item69B:="3"
						//End case 
						//End of change on 8/22/00
						// *** End of Change #6
						
					: ($Column=3)
						Case of 
							: ([BridgeMHDNBISArchive:139]Item55B:110>3.7)
								$Item69B:="9"
							: ([BridgeMHDNBISArchive:139]Item55B:110=3.7)
								$Item69B:="8"
							: ([BridgeMHDNBISArchive:139]Item55B:110>=3.4)
								$Item69B:="7"
							: ([BridgeMHDNBISArchive:139]Item55B:110>=3)
								$Item69B:="6"
							: ([BridgeMHDNBISArchive:139]Item55B:110>=2.4)
								$Item69B:="5"
							: ([BridgeMHDNBISArchive:139]Item55B:110>=1.2)
								$Item69B:="4"
							: ([BridgeMHDNBISArchive:139]Item41:140="K")
								//The rating is low and the bridge is closed.        
								$Item69B:="0"
							: (([BridgeMHDNBISArchive:139]Item75A:151="31") | ([BridgeMHDNBISArchive:139]Item75A:151="32"))
								//Replacement planned.
								$Item69B:="2"
							Else 
								$Item69B:="3"
						End case 
						
					Else   //Use the 4th column, railroad.
						Case of 
							: ([BridgeMHDNBISArchive:139]Item55B:110>6.1)
								$Item69B:="9"
							: ([BridgeMHDNBISArchive:139]Item55B:110=6.1)
								$Item69B:="8"
							: ([BridgeMHDNBISArchive:139]Item55B:110>=5.2)
								$Item69B:="7"
							: ([BridgeMHDNBISArchive:139]Item55B:110>=4.3)
								$Item69B:="6"
							: ([BridgeMHDNBISArchive:139]Item55B:110>=3.4)
								$Item69B:="5"
							: ([BridgeMHDNBISArchive:139]Item55B:110>=2.4)
								$Item69B:="4"
							: ([BridgeMHDNBISArchive:139]Item41:140="K")
								//The rating is low and the bridge is closed.        
								$Item69B:="0"
							: (([BridgeMHDNBISArchive:139]Item75A:151="31") | ([BridgeMHDNBISArchive:139]Item75A:151="32"))
								//Replacement planned.
								$Item69B:="2"
							Else 
								$Item69B:="3"
						End case 
				End case   //End of Table 3B.
				
		End case 
		
		If ($Item69#"N")
			If ($Item69B<$Item69)
				$Item69:=$Item69B
			End if 
		End if 
		
		$0:=$Item69
		
		
	: ($Task_txt="SET_Item70")
		//procedure: SET_Item70
		C_TEXT:C284($0)
		
		C_REAL:C285($wt; $legal; $Item64)
		C_TEXT:C284($value)  // Command Replaced was o_C_STRING length was 1
		
		$Item64:=[BridgeMHDNBISArchive:139]Item64:136
		
		$legal:=32.4  //metric tons (36 tons x 0.9)
		
		If (Position:C15([BridgeMHDNBISArchive:139]Item 63:196; <>SIA_LoadRtg_63_RF_txt)>0)
			$wt:=$Item64*100
		Else 
			$wt:=$Item64*100/$legal
		End if 
		
		$value:="0"
		
		Case of 
			: ($wt>=100)
				$value:="5"
			: ($wt>=90.1)
				$value:="4"
			: ($wt>=80.1)
				$value:="3"
			: ($wt>=70.1)
				$value:="2"
			: ($wt>=60.1)
				$value:="1"
		End case 
		
		$0:=$value
		
	: ($Task_txt="RECALCAASHTO")
		
		
		C_LONGINT:C283($LowestRatng; $Lanes; $n)  //Command Replaced was o_C_INTEGER
		C_TEXT:C284($0)
		C_REAL:C285($A; $B; $C; $D; $E; $F; $G; $H; $I; $J; $K; $X; $Y; $GnH)
		C_REAL:C285($S1; $S2; $S3; $S4; $SR)
		C_REAL:C285($Width)
		C_TEXT:C284($Type)  // Command Replaced was o_C_STRING length was 2
		
		[BridgeMHDNBISArchive:139]Item67:141:=ARCHIVE_RecalcAASHTO("SET_Item67")
		[BridgeMHDNBISArchive:139]Item68:142:=ARCHIVE_RecalcAASHTO("SET_Item68")
		[BridgeMHDNBISArchive:139]Item69:143:=ARCHIVE_RecalcAASHTO("SET_Item69")
		If ([BridgeMHDNBISArchive:139]Item103:123=False:C215)
			[BridgeMHDNBISArchive:139]Item70:139:=ARCHIVE_RecalcAASHTO("SET_Item70")
		End if 
		
		If (False:C215)
			//*** S1 Structural Adequacy and Safety (55% maximum).
			
			//Item 59 Superstructure
			//Item 60 Substructure
			//Note:  Function Num will convert a "?" to zero.
		End if 
		
		Case of 
			: (([BridgeMHDNBISArchive:139]Item59:130="N") | ([BridgeMHDNBISArchive:139]Item59:130="?"))
				If (([BridgeMHDNBISArchive:139]Item60:131="N") | ([BridgeMHDNBISArchive:139]Item60:131="?"))
					//Superstructure and Substructure blank, use Culvert Rating.
					
					//09-07-2000 changes
					// There are five bridges where item 59,60 and 62 are N, 
					// In these cases setting LowestRating=100 instead of taking a
					// num(N) which will give a value of zero
					If ([BridgeMHDNBISArchive:139]Item62:133#"N")
						$LowestRatng:=Num:C11([BridgeMHDNBISArchive:139]Item62:133)
					Else 
						$LowestRatng:=100
					End if 
					//End of changes 09-07-2000
					
				Else 
					//Superstructure blank, use Substructure Rating.       
					$LowestRatng:=Num:C11([BridgeMHDNBISArchive:139]Item60:131)
				End if 
			: (([BridgeMHDNBISArchive:139]Item60:131="N") | ([BridgeMHDNBISArchive:139]Item60:131="?"))
				//Substructure blank, use Superstructure Rating.       
				$LowestRatng:=Num:C11([BridgeMHDNBISArchive:139]Item59:130)
			Else 
				//Use the lowest rating of the two.    
				$LowestRatng:=MinNum(Num:C11([BridgeMHDNBISArchive:139]Item59:130); Num:C11([BridgeMHDNBISArchive:139]Item60:131))
		End case 
		
		Case of 
			: ($LowestRatng<=2)
				$A:=55
			: ($LowestRatng=3)
				$A:=40
			: ($LowestRatng=4)
				$A:=25
			: ($LowestRatng=5)
				$A:=10
			Else 
				$A:=0
		End case 
		
		//Inventory Rating, MS loading, metric tons.
		If ([BridgeMHDNBISArchive:139]Item66:138>=32.4)
			$B:=0
		Else 
			//3/21/01: Truncating Item66
			//$B:=((32.4-[BridgeMHDNBISArchive]Item66)^1.5)*0.3254
			$B:=((32.4-Trunc:C95([BridgeMHDNBISArchive:139]Item66:138; 1))^1.5)*0.3254
			//End of change 3/21/01
			//Change on 8/29/00: Edit/Update rounds $B to 4 decimal point
			$B:=Round:C94($B; 4)
			// End of change 8/29/00
		End if 
		$B:=MaxNum(0; $B)
		$B:=MinNum(55; $B)
		
		$S1:=55-($A+$B)
		$S1:=MaxNum(0; $S1)
		$S1:=MinNum(55; $S1)
		
		//*** S2 Serviceability and Functional Obsolescence (30% maximum).
		
		//*** S2.a  Rating Reductions (13% maximum).
		
		//Deck Condition.
		Case of 
			: ([BridgeMHDNBISArchive:139]Item58:129="N")
				$A:=0
			: (Num:C11([BridgeMHDNBISArchive:139]Item58:129)<=3)
				$A:=5
			: (Num:C11([BridgeMHDNBISArchive:139]Item58:129)=4)
				$A:=3
			: (Num:C11([BridgeMHDNBISArchive:139]Item58:129)=5)
				$A:=1
			Else 
				$A:=0
		End case 
		
		//Structural Evaluation.
		Case of 
			: ([BridgeMHDNBISArchive:139]Item67:141="N")
				$B:=0
			: (Num:C11([BridgeMHDNBISArchive:139]Item67:141)<=3)
				$B:=4
			: (Num:C11([BridgeMHDNBISArchive:139]Item67:141)=4)
				$B:=2
			: (Num:C11([BridgeMHDNBISArchive:139]Item67:141)=5)
				$B:=1
			Else 
				$B:=0
		End case 
		
		//Deck Geometry.
		Case of 
			: ([BridgeMHDNBISArchive:139]Item68:142="N")
				$C:=0
			: (Num:C11([BridgeMHDNBISArchive:139]Item68:142)<=3)
				$C:=4
			: (Num:C11([BridgeMHDNBISArchive:139]Item68:142)=4)
				$C:=2
			: (Num:C11([BridgeMHDNBISArchive:139]Item68:142)=5)
				$C:=1
			Else 
				$C:=0
		End case 
		
		//Underclearances.
		Case of 
			: ([BridgeMHDNBISArchive:139]Item69:143="N")
				$D:=0
			: (Num:C11([BridgeMHDNBISArchive:139]Item69:143)<=3)
				$D:=4
			: (Num:C11([BridgeMHDNBISArchive:139]Item69:143)=4)
				$D:=2
			: (Num:C11([BridgeMHDNBISArchive:139]Item69:143)=5)
				$D:=1
			Else 
				$D:=0
		End case 
		
		//Waterway Adequacy.
		Case of 
			: ([BridgeMHDNBISArchive:139]Item71:144="N")
				$E:=0
			: (Num:C11([BridgeMHDNBISArchive:139]Item71:144)<=3)
				$E:=4
			: (Num:C11([BridgeMHDNBISArchive:139]Item71:144)=4)
				$E:=2
			: (Num:C11([BridgeMHDNBISArchive:139]Item71:144)=5)
				$E:=1
			Else 
				$E:=0
		End case 
		
		//Approach Road Alignment.
		Case of 
			: ([BridgeMHDNBISArchive:139]Item72:145="N")
				$F:=0
			: (Num:C11([BridgeMHDNBISArchive:139]Item72:145)<=3)
				$F:=4
			: (Num:C11([BridgeMHDNBISArchive:139]Item72:145)=4)
				$F:=2
			: (Num:C11([BridgeMHDNBISArchive:139]Item72:145)=5)
				$F:=1
			Else 
				$F:=0
		End case 
		
		$J:=$A+$B+$C+$D+$E+$F
		$J:=MaxNum(0; $J)
		$J:=MinNum(13; $J)
		
		
		//*** S2.b  Width of Roadway Insufficiency (15% maximum).
		//3/21/01 change, adding rounding to item51
		//$Width:=[BridgeMHDNBISArchive]Item51
		$Width:=Round:C94([BridgeMHDNBISArchive:139]Item51:95; 1)
		//3/21/01 end of change
		// *** change #2 memo 5-27-1999 
		//If ($Width<=0)
		//    `Bridge width is invalid, try Approach Roadway Width.  
		//  $Width:=[BridgeMHDNBISArchive]Item32
		//End if 
		// *** end of chg 2
		If ($Width<=0)
			//Width is still invalid, use a default value.  
			$Width:=10.9
		End if 
		
		$Lanes:=[BridgeMHDNBISArchive:139]Item28A:85
		If ($Lanes<1)
			//Set a valid number of lanes.  
			$Lanes:=MaxNum(1; Round:C94($Width/3.66; 0))
		End if 
		
		$X:=[BridgeMHDNBISArchive:139]Item29:87/$Lanes  //ADT/lane
		$Y:=$Width/$Lanes
		
		//Change on 8/29/00: Edit/Update rounds $X and $Y to 1 decimal point
		$X:=Round:C94($X; 1)
		$Y:=Round:C94($Y; 1)
		// End of change 8/29/00
		
		
		//Approach Roadway Width for non-Culverts.
		If (False:C215)
			// *** Change #3  memo 5-27-1999    
			//  : ((Substring([BridgeMHDNBISArchive]Item43;2;2)="19") & (([BridgeMHDNBISArchive]Item51+0
			
			//Change 09-07-2000
			// changing(([BridgeMHDNBISArchive]Item51+0.6)=Round(([BridgeMHDNBISArchive]Item51+0.6);1))
			//because the computer processor does not give an absolute value for a real number
			//  If rounding is not used and if item51+0.6=item32, it considers the second half
			//of the case statement below to be true, leading to an error.
			
			//   : ((Substring([BridgeMHDNBISArchive]Item43;2;2)#"19") & (([BridgeMHDNBISArchive]Item51+
		End if 
		Case of 
				
			: ((Substring:C12([BridgeMHDNBISArchive:139]Item43:74; 2; 2)#"19") & (Round:C94(([BridgeMHDNBISArchive:139]Item51:95+0.6); 1)<[BridgeMHDNBISArchive:139]Item32:97))
				$G:=5
			Else 
				$G:=0
		End case 
		
		Case of 
			: ($Lanes=1)
				Case of 
					: ($Y<4.3)
						$H:=15
					: ($Y<5.5)
						$H:=15*(5.5-$Y)/1.2
						//Change on 8/29/00: Edit/Update rounds $H to 4 decimal point
						$H:=Round:C94($H; 4)
						// End of change 8/29/00
					Else 
						$H:=0
				End case 
				
			: (($Lanes=2) & ($Y>=4.9))
				$H:=0
				
			: (($Lanes=3) & ($Y>=4.6))
				$H:=0
				
			: (($Lanes=4) & ($Y>=4.3))
				$H:=0
				
			: (($Lanes>=5) & ($Y>=3.7))
				$H:=0
				
			: (($Y<2.7) & ($X>50))
				$H:=15
				
			: ($X<=50)
				Case of 
					: ($Y<2.7)
						$H:=7.5
					Else 
						$H:=0
				End case 
				
			: ($X<=125)
				Case of 
					: ($Y<3)
						$H:=15
					: ($Y<4)
						$H:=15*(4-$Y)
						//Change on 8/29/00: Edit/Update rounds $H to 4 decimal point
						$H:=Round:C94($H; 4)
						// End of change 8/29/00
					Else 
						$H:=0
				End case 
				
			: ($X<=375)
				Case of 
						// *** Change #4 memo 5-27-1999        
						//      : ($Y<3.3)
					: ($Y<3.4)
						$H:=15
					: ($Y<4.3)
						$H:=15*(4.3-$Y)
						//Change on 8/29/00: Edit/Update rounds $H to 4 decimal point
						$H:=Round:C94($H; 4)
						// End of change 8/29/00
					Else 
						$H:=0
				End case 
				
			: ($X<=1350)
				Case of 
					: ($Y<3.7)
						$H:=15
					: ($Y<4.9)
						$H:=15*(4.9-$Y)/1.2
						//Change on 8/29/00: Edit/Update rounds $H to 4 decimal point
						$H:=Round:C94($H; 4)
						// End of change 8/29/00
					Else 
						$H:=0
				End case 
				
			Else 
				Case of 
					: ($Y<4.6)
						$H:=15
					: ($Y<4.9)
						$H:=15*(4.9-$Y)/0.3
						//Change on 8/29/00: Edit/Update rounds $H to 4 decimal point
						$H:=Round:C94($H; 4)
						// End of change 8/29/00
					Else 
						$H:=0
				End case 
				
		End case 
		
		$GnH:=$G+$H
		$GnH:=MaxNum(0; $GnH)
		$GnH:=MinNum(15; $GnH)
		
		
		//*** S2.c  Vertical Clearance Insufficiency (2% maximum).
		If (Num:C11([BridgeMHDNBISArchive:139]Item100:120)=0)
			//Non-defense.  
			If ([BridgeMHDNBISArchive:139]Item53:104<4.26)
				$I:=2
			Else 
				$I:=0
			End if 
		Else 
			//Defense.
			If ([BridgeMHDNBISArchive:139]Item53:104<4.87)
				$I:=2
			Else 
				$I:=0
			End if 
		End if 
		
		$S2:=30-($J+$GnH+$I)
		//Change on 8/29/00: Edit/Update rounds $S2 to 4 decimal point
		$S2:=Round:C94($S2; 4)
		// End of change 8/29/00
		$S2:=MaxNum(0; $S2)
		$S2:=MinNum(30; $S2)
		
		
		//*** S3 Essentiality for Public Use (15% maximum).
		
		$K:=($S1+$S2)/85
		//Change on 8/29/00: Edit/Update rounds $K to 4 decimal point
		$K:=Round:C94($K; 4)
		// End of change 8/29/00
		$K:=MaxNum($K; 0.0001)
		
		//Item29 ADT; Item19 Detour Length
		
		$A:=15*[BridgeMHDNBISArchive:139]Item29:87*[BridgeMHDNBISArchive:139]Item19:90/(320000*$K)
		
		
		//Change on 8/29/00: Edit/Update rounds $A to 9 decimal point
		$A:=Round:C94($A; 9)
		// End of change 8/29/00
		$A:=MaxNum(0; $A)
		$A:=MinNum(15; $A)
		
		If (Num:C11([BridgeMHDNBISArchive:139]Item100:120)=0)
			//Non-defense.  
			$B:=0
		Else 
			//Defense.
			$B:=2
		End if 
		
		$S3:=15-($A+$B)
		//Change on 8/29/00: Edit/Update rounds $S3 to 4 decimal point
		$S3:=Round:C94($S3; 4)
		// End of change 8/29/00
		$S3:=MaxNum(0; $S3)
		$S3:=MinNum(15; $S3)
		
		
		//*** S4 Special Reductions (13% maximum).
		
		If (($S1+$S2+$S3)<50)
			//No special reductions allowed.
			$S4:=0
			
		Else 
			
			//*** S4.a  Detour Length Reduction (5% maximum).
			
			$A:=([BridgeMHDNBISArchive:139]Item19:90^4)*7.9*(10^(-9))
			
			
			//Change on 8/29/00: Edit/Update rounds $A to 9 decimal point
			$A:=Round:C94($A; 9)
			// End of change 8/29/00
			$A:=MaxNum(0; $A)
			$A:=MinNum(5; $A)
			
			//*** S4.b  Structure Type Reduction (5% maximum).
			$Type:=Substring:C12([BridgeMHDNBISArchive:139]Item43:74; 2; 2)
			If (($Type="10") | ($Type="12") | ($Type="13") | ($Type="14") | ($Type="15") | ($Type="16") | ($Type="17"))
				$B:=5
			Else 
				$B:=0
			End if 
			
			//*** S4.c  Traffic Safety Features Reduction (3% maximum).
			$n:=0
			If ([BridgeMHDNBISArchive:139]Item36A:146="0")
				$n:=$n+1
			End if 
			If ([BridgeMHDNBISArchive:139]Item36B:147="0")
				$n:=$n+1
			End if 
			If ([BridgeMHDNBISArchive:139]Item36C:148="0")
				$n:=$n+1
			End if 
			If ([BridgeMHDNBISArchive:139]Item36D:149="0")
				$n:=$n+1
			End if 
			Case of 
				: ($n=4)
					$C:=3
				: ($n=3)
					$C:=2
				: ($n=2)
					$C:=1
				Else 
					$C:=0
			End case 
			
			$S4:=$A+$B+$C
			//Change on 8/29/00: Edit/Update rounds $S4 to 4 decimal point
			$S4:=Round:C94($S4; 4)
			// End of change 8/29/00
			$S4:=MaxNum(0; $S4)
			$S4:=MinNum(13; $S4)
		End if 
		
		
		//*** AASHTO Sufficiency Rating.
		$SR:=$S1+$S2+$S3-$S4
		$SR:=MaxNum(0; $SR)
		$SR:=MinNum(100; $SR)
		
		$0:=String:C10(Round:C94($SR; 1))
		
	: ($Task_txt="")
		C_LONGINT:C283($loop_L; $Recs; $Interval; $total)  //Command Replaced was o_C_INTEGER
		C_BOOLEAN:C305($vbOnScreen)
		$vbOnScreen:=True:C214
		C_OBJECT:C1216($progressObj_o)
		
		If ($vbOnScreen)
			//<>ProgressPID:=StartProgress ("RecalcArchiveAASHTO";"None";"")
			//UpdateProgress (0;$Recs)
			$progressObj_o:=ProgressNew("Recalculating Archive AASHTO"; $Recs; True:C214; ""; 3)
		End if 
		
		//NewWindow (132;55;0;-5;"Recalculating AASHTO")
		//GOTO XY(1;2)  `2-10-2000 : CM
		//MESSAGE("Record 00001")
		$Recs:=Records in selection:C76([BridgeMHDNBISArchive:139])
		C_BOOLEAN:C305($NBIRecordChange_B)
		$total:=$Recs
		$Interval:=MaxNum(MinNum(Int:C8($Recs/40); 20); 2)  // get an update interval between 2 and 20
		FIRST RECORD:C50([BridgeMHDNBISArchive:139])
		For ($loop_L; 1; $Recs)
			$NBIRecordChange_B:=False:C215
			[BridgeMHDNBISArchive:139]AASHTO:5:=Num:C11(ARCHIVE_RecalcAASHTO("RECALCAASHTO"))
			$NBIRecordChange_B:=([BridgeMHDNBISArchive:139]AASHTO:5#Old:C35([BridgeMHDNBISArchive:139]AASHTO:5))
			$NBIRecordChange_B:=$NBIRecordChange_B | ([BridgeMHDNBISArchive:139]Item67:141#Old:C35([BridgeMHDNBISArchive:139]Item67:141))
			$NBIRecordChange_B:=$NBIRecordChange_B | ([BridgeMHDNBISArchive:139]Item68:142#Old:C35([BridgeMHDNBISArchive:139]Item68:142))
			$NBIRecordChange_B:=$NBIRecordChange_B | ([BridgeMHDNBISArchive:139]Item69:143#Old:C35([BridgeMHDNBISArchive:139]Item69:143))
			$NBIRecordChange_B:=$NBIRecordChange_B | ([BridgeMHDNBISArchive:139]Item70:139#Old:C35([BridgeMHDNBISArchive:139]Item70:139))
			If ($NBIRecordChange_B)
				SAVE RECORD:C53([BridgeMHDNBISArchive:139])
			End if 
			
			NEXT RECORD:C51([BridgeMHDNBISArchive:139])
			
			If ($vbOnScreen)
				If ($loop_L%$Interval)=0
					//GOTO XY(1;2)  `2-10-2000 : CM
					//MESSAGE("Record "+String($i;"00000"))
					//UpdateProgress ($loop_L;$Recs)
					//update progress
					UpdateProgressNew($progressObj_o; $loop_L)
					
				End if 
				// check if we got aborted from the Progress Bar display...
				//If (<>Abort=True)
				//End if 
				//check if progress stopped
				If (Progress Stopped(OB Get:C1224($progressObj_o; "progress")))
					//abort loop
					$total:=$loop_L
					$loop_L:=$Recs+1
				End if 
				
				
			End if 
			
		End for 
		
		If ($vbOnScreen)
			//CALL PROCESS(<>ProgressPID)
			//quit progress
			Progress QUIT(OB Get:C1224($progressObj_o; "progress"))
			//CLOSE WINDOW
			BEEP:C151
			ALERT:C41("AASHTO Recalculated for "+String:C10($total; "#####")+" records!")
		End if 
		
End case 