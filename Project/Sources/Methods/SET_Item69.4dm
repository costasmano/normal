//%attributes = {"invisible":true}
//GP SET_Item69
//Written by Thomas D. Nee

//Modified
//    1-dec-1999 per memo from CSC dated 23-jun-1999
//Modified in Aug and Sept 2000 to match the code from the
// FHWA's Edit/Update program


//Calculate and return Item69, Underclearances Evaluation, for the current bridge.

C_TEXT:C284($Item69; $Item69B; $0)  // Command Replaced was o_C_STRING length was 2
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

$Item42B:=Substring:C12([Bridge MHD NBIS:1]Item42:85; 2; 1)
Case of 
	: (($Item42B="3") | ($Item42B="5") | ($Item42B="9") | ($Item42B="0"))
		//The bridge is not over a highway or a railroad.
		$Item69:="N"
	: (([Bridge MHD NBIS:1]Item54A:107="N") | ([Bridge MHD NBIS:1]Item54B:108=0) | ([Bridge MHD NBIS:1]Item55A:110="N"))
		//The underclearances are not set?  
		$Item69:="N"
	: ((([Bridge MHD NBIS:1]Item54A:107#"R") & ([Bridge MHD NBIS:1]Item54A:107#"H")) | (([Bridge MHD NBIS:1]Item55A:110#"R") & ([Bridge MHD NBIS:1]Item55A:110#"H")))
		//The underclearances are not set?
		//3/23/01 : Changed the ? to N to avoid problems with the last If statement
		//       at the end of this routine.
		// $Item69:="?"
		$Item69:="N"
	Else 
		
		//Find the column to use in Table 3A and 3B.  This is determined
		//by the functional classification of the underpassing route.
		If (([Bridge MHD NBIS:1]Item54A:107="R"))
			//The bridge is over a railroad.
			$Column:=4
		Else 
			//Look for secondary records.
			If (False:C215)
				RELATE MANY:C262([Bridge MHD NBIS:1]BIN:3)
			Else 
				QUERY:C277([NBIS Secondary:3]; [NBIS Secondary:3]BIN:1=[Bridge MHD NBIS:1]BIN:3)
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
					: ([Bridge MHD NBIS:1]Item54B:108>5.18)
						$Item69:="9"
					: ([Bridge MHD NBIS:1]Item54B:108=5.18)
						$Item69:="8"
					: ([Bridge MHD NBIS:1]Item54B:108>=5.1)
						$Item69:="7"
					: ([Bridge MHD NBIS:1]Item54B:108>=5.02)
						$Item69:="6"
					: ([Bridge MHD NBIS:1]Item54B:108>=4.8)
						$Item69:="5"
					: ([Bridge MHD NBIS:1]Item54B:108>=4.57)
						$Item69:="4"
					: ([Bridge MHD NBIS:1]Item41:141="K")
						//The rating is low and the bridge is closed.        
						$Item69:="0"
					: (([Bridge MHD NBIS:1]Item75A:152="31") | ([Bridge MHD NBIS:1]Item75A:152="32"))
						//Replacement planned.
						$Item69:="2"
					Else 
						$Item69:="3"
				End case 
				
			: (($Column=2) | ($Column=3))
				Case of 
					: ([Bridge MHD NBIS:1]Item54B:108>5.02)
						$Item69:="9"
					: ([Bridge MHD NBIS:1]Item54B:108=5.02)
						$Item69:="8"
					: ([Bridge MHD NBIS:1]Item54B:108>=4.72)
						$Item69:="7"
					: ([Bridge MHD NBIS:1]Item54B:108>=4.41)
						$Item69:="6"
					: ([Bridge MHD NBIS:1]Item54B:108>=4.34)
						$Item69:="5"
					: ([Bridge MHD NBIS:1]Item54B:108>=4.26)
						$Item69:="4"
					: ([Bridge MHD NBIS:1]Item41:141="K")
						//The rating is low and the bridge is closed.        
						$Item69:="0"
					: (([Bridge MHD NBIS:1]Item75A:152="31") | ([Bridge MHD NBIS:1]Item75A:152="32"))
						//Replacement planned.
						$Item69:="2"
					Else 
						$Item69:="3"
				End case 
				
			Else   //Use the 4th column, railroad.
				Case of 
					: ([Bridge MHD NBIS:1]Item54B:108>7.01)
						$Item69:="9"
					: ([Bridge MHD NBIS:1]Item54B:108=7.01)
						$Item69:="8"
					: ([Bridge MHD NBIS:1]Item54B:108>=6.85)
						$Item69:="7"
					: ([Bridge MHD NBIS:1]Item54B:108>=6.7)
						$Item69:="6"
					: ([Bridge MHD NBIS:1]Item54B:108>=6.4)
						$Item69:="5"
					: ([Bridge MHD NBIS:1]Item54B:108>=6.09)
						$Item69:="4"
					: ([Bridge MHD NBIS:1]Item41:141="K")
						//The rating is low and the bridge is closed.        
						$Item69:="0"
					: (([Bridge MHD NBIS:1]Item75A:152="31") | ([Bridge MHD NBIS:1]Item75A:152="32"))
						//Replacement planned.
						$Item69:="2"
					Else 
						$Item69:="3"
				End case 
		End case   //End of Table 3A.
		
		//Table 3B.     
		//8/23/00:    Need to check if item55a = Railroad for table 3b
		
		If (([Bridge MHD NBIS:1]Item55A:110="R"))
			//The bridge is over a railroad.
			$Column:=4
		End if 
		
		//Commented the line below as using the MinLatClr is incorrect.    
		//    $MinLatClr:=MinNum ([Bridge MHD NBIS]Item55B;[Bridge MHD NBIS]Item56)
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
						: (([Bridge MHD NBIS:1]Item55B:111>3) & ([Bridge MHD NBIS:1]Item56:112>1.2))
							$Item69B:="9"
						: ((([Bridge MHD NBIS:1]Item55B:111=3) & ([Bridge MHD NBIS:1]Item56:112>=1.2)) | (([Bridge MHD NBIS:1]Item55B:111>=3) & ([Bridge MHD NBIS:1]Item56:112=1.2)))
							$Item69B:="8"
						: (([Bridge MHD NBIS:1]Item55B:111>=2.7) & ([Bridge MHD NBIS:1]Item56:112>=0.9))
							$Item69B:="7"
						: (([Bridge MHD NBIS:1]Item55B:111>=2.4) & ([Bridge MHD NBIS:1]Item56:112>=0.6))
							$Item69B:="6"
						: (([Bridge MHD NBIS:1]Item55B:111>=1.8) & ([Bridge MHD NBIS:1]Item56:112>=0.6))
							$Item69B:="5"
						: (([Bridge MHD NBIS:1]Item55B:111>=1.2) & ([Bridge MHD NBIS:1]Item56:112>=0.6))
							$Item69B:="4"
						: ([Bridge MHD NBIS:1]Item41:141="K")
							//The rating is low and the bridge is closed.        
							$Item69B:="0"
						: (([Bridge MHD NBIS:1]Item75A:152="31") | ([Bridge MHD NBIS:1]Item75A:152="32"))
							//Replacement planned.
							$Item69B:="2"
						Else 
							$Item69B:="3"
					End case 
				Else 
					//Main Line (not a ramp).          
					Case of 
						: (([Bridge MHD NBIS:1]Item55B:111>9.1) & ([Bridge MHD NBIS:1]Item56:112>9.1))
							$Item69B:="9"
						: ((([Bridge MHD NBIS:1]Item55B:111=9.1) & ([Bridge MHD NBIS:1]Item56:112>=9.1)) | (([Bridge MHD NBIS:1]Item55B:111>=9.1) & ([Bridge MHD NBIS:1]Item56:112=9.1)))
							$Item69B:="8"
						: (([Bridge MHD NBIS:1]Item55B:111>=6.4) & ([Bridge MHD NBIS:1]Item56:112>=5.5))
							$Item69B:="7"
						: (([Bridge MHD NBIS:1]Item55B:111>=3.7) & ([Bridge MHD NBIS:1]Item56:112>=1.8))
							$Item69B:="6"
						: (([Bridge MHD NBIS:1]Item55B:111>=3.4) & ([Bridge MHD NBIS:1]Item56:112>=1.5))
							$Item69B:="5"
						: (([Bridge MHD NBIS:1]Item55B:111>=3) & ([Bridge MHD NBIS:1]Item56:112>=1.2))
							$Item69B:="4"
						: ([Bridge MHD NBIS:1]Item41:141="K")
							//The rating is low and the bridge is closed.        
							$Item69B:="0"
						: (([Bridge MHD NBIS:1]Item75A:152="31") | ([Bridge MHD NBIS:1]Item75A:152="32"))
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
				//       : ([Bridge MHD NBIS]Item55B>3)
				//        $Item69B:="9"
				//     : ([Bridge MHD NBIS]Item55B=3)
				//      $Item69B:="8"
				//   : ([Bridge MHD NBIS]Item55B>=2.7)
				//    $Item69B:="7"
				// : ([Bridge MHD NBIS]Item55B>=2.4)
				//  $Item69B:="6"
				//: ([Bridge MHD NBIS]Item55B>=1.8)
				// $Item69B:="5"
				//: ([Bridge MHD NBIS]Item55B>=1.2)
				// $Item69B:="4"
				//: ([Bridge MHD NBIS]Item41="K")
				//The rating is low and the bridge is closed.        
				// $Item69B:="0"
				//: (([Bridge MHD NBIS]Item75A="31") | ([Bridge MHD NBIS]Item75A="32"))
				//Replacement planned.
				// $Item69B:="2"
				//Else 
				// $Item69B:="3"
				// End case 
				// Else 
				//Main line (not a ramp)
				//  Case of 
				//   : ([Bridge MHD NBIS]Item55B>9.1)
				//    $Item69B:="9"
				// : ([Bridge MHD NBIS]Item55B=9.1)
				//  $Item69B:="8"
				//: ([Bridge MHD NBIS]Item55B>=6.4)
				// $Item69B:="7"
				//  : ([Bridge MHD NBIS]Item55B>=3.7)
				//   $Item69B:="6"
				//: ([Bridge MHD NBIS]Item55B>=3.4)
				// $Item69B:="5"
				//: ([Bridge MHD NBIS]Item55B>=3)
				//  $Item69B:="4"
				// : ([Bridge MHD NBIS]Item41="K")
				//The rating is low and the bridge is closed.        
				//  $Item69B:="0"
				//: (([Bridge MHD NBIS]Item75A="31") | ([Bridge MHD NBIS]Item75A="32"))
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
				//        : ([Bridge MHD NBIS]Item55B>3)
				//         $Item69B:="9"
				//      : ([Bridge MHD NBIS]Item55B=3)
				//       $Item69B:="8"
				//    : ([Bridge MHD NBIS]Item55B>=2.7)
				//     $Item69B:="7"
				//  : ([Bridge MHD NBIS]Item55B>=2.4)
				//   $Item69B:="6"
				//: ([Bridge MHD NBIS]Item55B>=1.8)
				// $Item69B:="5"
				//: ([Bridge MHD NBIS]Item55B>=1.2)
				// $Item69B:="4"
				//: ([Bridge MHD NBIS]Item41="K")
				//The rating is low and the bridge is closed.        
				// $Item69B:="0"
				//: (([Bridge MHD NBIS]Item75A="31") | ([Bridge MHD NBIS]Item75A="32"))
				//Replacement planned.
				// $Item69B:="2"
				//Else 
				// $Item69B:="3"
				//End case 
				// *** End of change #5       
				//End of change on 8/22/00
				
			: ($Column=2)
				Case of 
					: ([Bridge MHD NBIS:1]Item55B:111>9.1)
						$Item69B:="9"
					: ([Bridge MHD NBIS:1]Item55B:111=9.1)
						$Item69B:="8"
					: ([Bridge MHD NBIS:1]Item55B:111>=6.4)
						$Item69B:="7"
					: ([Bridge MHD NBIS:1]Item55B:111>=3.7)
						$Item69B:="6"
					: ([Bridge MHD NBIS:1]Item55B:111>=3)
						$Item69B:="5"
					: ([Bridge MHD NBIS:1]Item55B:111>=1.8)
						$Item69B:="4"
					: ([Bridge MHD NBIS:1]Item41:141="K")
						//The rating is low and the bridge is closed.        
						$Item69B:="0"
					: (([Bridge MHD NBIS:1]Item75A:152="31") | ([Bridge MHD NBIS:1]Item75A:152="32"))
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
				//       : ([Bridge MHD NBIS]Item55B>3)
				//         $Item69B:="9"
				//       : ([Bridge MHD NBIS]Item55B=3)
				//         $Item69B:="8"
				//       : ([Bridge MHD NBIS]Item55B>=2.7)
				//         $Item69B:="7"
				//       : ([Bridge MHD NBIS]Item55B>=2.4)
				//         $Item69B:="6"
				//       : ([Bridge MHD NBIS]Item55B>=1.8)
				//         $Item69B:="5"
				//       : ([Bridge MHD NBIS]Item55B>=1.2)
				//         $Item69B:="4"
				//       : ([Bridge MHD NBIS]Item41="K")
				//           `The rating is low and the bridge is closed.        
				//        $Item69B:="0"
				//     : (([Bridge MHD NBIS]Item75A="31") | ([Bridge MHD NBIS]Item75A="32"))
				//        `Replacement planned.
				//     $Item69B:="2"
				//  Else 
				//   $Item69B:="3"
				//End case 
				//End of change on 8/22/00
				// *** End of Change #6
				
			: ($Column=3)
				Case of 
					: ([Bridge MHD NBIS:1]Item55B:111>3.7)
						$Item69B:="9"
					: ([Bridge MHD NBIS:1]Item55B:111=3.7)
						$Item69B:="8"
					: ([Bridge MHD NBIS:1]Item55B:111>=3.4)
						$Item69B:="7"
					: ([Bridge MHD NBIS:1]Item55B:111>=3)
						$Item69B:="6"
					: ([Bridge MHD NBIS:1]Item55B:111>=2.4)
						$Item69B:="5"
					: ([Bridge MHD NBIS:1]Item55B:111>=1.2)
						$Item69B:="4"
					: ([Bridge MHD NBIS:1]Item41:141="K")
						//The rating is low and the bridge is closed.        
						$Item69B:="0"
					: (([Bridge MHD NBIS:1]Item75A:152="31") | ([Bridge MHD NBIS:1]Item75A:152="32"))
						//Replacement planned.
						$Item69B:="2"
					Else 
						$Item69B:="3"
				End case 
				
			Else   //Use the 4th column, railroad.
				Case of 
					: ([Bridge MHD NBIS:1]Item55B:111>6.1)
						$Item69B:="9"
					: ([Bridge MHD NBIS:1]Item55B:111=6.1)
						$Item69B:="8"
					: ([Bridge MHD NBIS:1]Item55B:111>=5.2)
						$Item69B:="7"
					: ([Bridge MHD NBIS:1]Item55B:111>=4.3)
						$Item69B:="6"
					: ([Bridge MHD NBIS:1]Item55B:111>=3.4)
						$Item69B:="5"
					: ([Bridge MHD NBIS:1]Item55B:111>=2.4)
						$Item69B:="4"
					: ([Bridge MHD NBIS:1]Item41:141="K")
						//The rating is low and the bridge is closed.        
						$Item69B:="0"
					: (([Bridge MHD NBIS:1]Item75A:152="31") | ([Bridge MHD NBIS:1]Item75A:152="32"))
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