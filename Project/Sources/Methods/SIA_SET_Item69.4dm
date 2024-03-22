//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/05/11, 17:14:17
	// ----------------------------------------------------
	// Method: SIA_SET_Item69
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_10
End if 
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
C_TEXT:C284($itm42_txt; $1; $itm54A_txt; $2; $itm55a_txt; $3; $itm41_txt; $4; $itm75a_txt; $5; $BIN_txt; $6)
C_REAL:C285($itm54b_r; $7; $itm55b_r; $8; $itm56_r; $9)
C_TEXT:C284($ArchReas_txt)
C_DATE:C307($archDate_d)
$itm42_txt:=$1
$itm54A_txt:=$2
$itm55a_txt:=$3
$itm41_txt:=$4
$itm75a_txt:=$5
$BIN_txt:=$6
$itm54b_r:=$7
$itm55b_r:=$8
$itm56_r:=$9
If (Count parameters:C259=11)
	C_TEXT:C284($10)
	C_DATE:C307($11)
	$ArchReas_txt:=$10
	$archDate_d:=$11
Else 
	$ArchReas_txt:=""
	$archDate_d:=!00-00-00!
	
End if 

//First, lookup the value from Table 1 in the coding guide.
//Item 29, Average Daily Traffic
//Item 26, Functional Class:
//    01=Rural Interstate    
//    11=Urban Interstate    
//    12=Urban Other Freeways or Expressways 
//Item 66, Inventory Rating (Metric Tons)   

$Item42B:=Substring:C12($itm42_txt; 2; 1)
Case of 
	: (($Item42B="3") | ($Item42B="5") | ($Item42B="9") | ($Item42B="0"))
		//The bridge is not over a highway or a railroad.
		$Item69:="N"
	: (($itm54A_txt="N") | ($itm54b_r=0) | ($itm55a_txt="N"))
		//The underclearances are not set?  
		$Item69:="N"
	: ((($itm54A_txt#"R") & ($itm54A_txt#"H")) | (($itm55a_txt#"R") & ($itm55a_txt#"H")))
		//The underclearances are not set?
		//3/23/01 : Changed the ? to N to avoid problems with the last If statement
		//       at the end of this routine.
		// $Item69:="?"
		$Item69:="N"
	Else 
		
		//Find the column to use in Table 3A and 3B.  This is determined
		//by the functional classification of the underpassing route.
		If (($itm54A_txt="R"))
			//The bridge is over a railroad.
			$Column:=4
		Else 
			//Look for secondary records.
			If ($ArchReas_txt="")
				QUERY:C277([NBIS Secondary:3]; [NBIS Secondary:3]BIN:1=$BIN_txt)
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
			Else 
				QUERY:C277([NBISSecondaryArchive:140]; [NBISSecondaryArchive:140]BIN:1=$BIN_txt; *)
				QUERY:C277([NBISSecondaryArchive:140];  & ; [NBISSecondaryArchive:140]ArchiveReason_s:39=$ArchReas_txt; *)
				QUERY:C277([NBISSecondaryArchive:140];  & ; [NBISSecondaryArchive:140]ArchiveDate_d:40=$archDate_d; *)
				
				$SecRecs:=Records in selection:C76([NBISSecondaryArchive:140])
				If ($SecRecs<1)
					//No secondary record; assume Major/Minor Collector/Local.
					$Column:=3
				Else 
					//Use the functional classification of the secondary record
					//for the most significant route (i.e., lowest functional class).
					
					// CHANGE on 10-4-00: SORT SELECTION is changed to ORDER BY for v6.5.6
					//  SORT SELECTION([NBIS Secondary];[NBIS Secondary]Item26)
					
					ORDER BY:C49([NBISSecondaryArchive:140]; [NBISSecondaryArchive:140]Item26:18)
					
					// *** Change #2 memo 23-6-1999
					If ([NBISSecondaryArchive:140]Item102:30="1")
						$oneway:=True:C214
					Else 
						$oneway:=False:C215
					End if 
					
					If ([NBISSecondaryArchive:140]Item102:30="2")
						$twoway:=True:C214
					Else 
						$twoway:=False:C215
					End if 
					// *** end of change #2
					
					Case of 
							
						: (([NBISSecondaryArchive:140]Item26:18="01") | ([NBISSecondaryArchive:140]Item26:18="11") | ([NBISSecondaryArchive:140]Item26:18="12") | ([NBISSecondaryArchive:140]Item26:18="  ") | ([NBISSecondaryArchive:140]Item26:18=""))
							//Interstate and other Freeway.  Assume this if I26 is blank.
							$Column:=1
							If (Substring:C12([NBISSecondaryArchive:140]Item5:4; 3; 1)="7")
								//This is a secondary record for a ramp underneath.          
								$Ramp:=True:C214
							Else 
								$Ramp:=False:C215
							End if 
							
						: (([NBISSecondaryArchive:140]Item26:18="02") | ([NBISSecondaryArchive:140]Item26:18="06") | ([NBISSecondaryArchive:140]Item26:18="14") | ([NBISSecondaryArchive:140]Item26:18="16"))
							
							//Other Principal and Minor Arterial.
							$Column:=2
						Else 
							//Major and Minor Collectors and Locals.
							$Column:=3
					End case 
				End if 
				
			End if 
			
		End if 
		
		//Table 3A     
		Case of 
			: ($Column=1)
				Case of 
					: ($itm54b_r>5.18)
						$Item69:="9"
					: ($itm54b_r=5.18)
						$Item69:="8"
					: ($itm54b_r>=5.1)
						$Item69:="7"
					: ($itm54b_r>=5.02)
						$Item69:="6"
					: ($itm54b_r>=4.8)
						$Item69:="5"
					: ($itm54b_r>=4.57)
						$Item69:="4"
					: ($itm41_txt="K")
						//The rating is low and the bridge is closed.        
						$Item69:="0"
					: (($itm75a_txt="31") | ($itm75a_txt="32"))
						//Replacement planned.
						$Item69:="2"
					Else 
						$Item69:="3"
				End case 
				
			: (($Column=2) | ($Column=3))
				Case of 
					: ($itm54b_r>5.02)
						$Item69:="9"
					: ($itm54b_r=5.02)
						$Item69:="8"
					: ($itm54b_r>=4.72)
						$Item69:="7"
					: ($itm54b_r>=4.41)
						$Item69:="6"
					: ($itm54b_r>=4.34)
						$Item69:="5"
					: ($itm54b_r>=4.26)
						$Item69:="4"
					: ($itm41_txt="K")
						//The rating is low and the bridge is closed.        
						$Item69:="0"
					: (($itm75a_txt="31") | ($itm75a_txt="32"))
						//Replacement planned.
						$Item69:="2"
					Else 
						$Item69:="3"
				End case 
				
			Else   //Use the 4th column, railroad.
				Case of 
					: ($itm54b_r>7.01)
						$Item69:="9"
					: ($itm54b_r=7.01)
						$Item69:="8"
					: ($itm54b_r>=6.85)
						$Item69:="7"
					: ($itm54b_r>=6.7)
						$Item69:="6"
					: ($itm54b_r>=6.4)
						$Item69:="5"
					: ($itm54b_r>=6.09)
						$Item69:="4"
					: ($itm41_txt="K")
						//The rating is low and the bridge is closed.        
						$Item69:="0"
					: (($itm75a_txt="31") | ($itm75a_txt="32"))
						//Replacement planned.
						$Item69:="2"
					Else 
						$Item69:="3"
				End case 
		End case   //End of Table 3A.
		
		//Table 3B.     
		//8/23/00:    Need to check if item55a = Railroad for table 3b
		
		If (($itm55a_txt="R"))
			//The bridge is over a railroad.
			$Column:=4
		End if 
		
		//Commented the line below as using the MinLatClr is incorrect.    
		//    $MinLatClr:=MinNum ($itm55b_r;$itm56_r)
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
						: (($itm55b_r>3) & ($itm56_r>1.2))
							$Item69B:="9"
						: ((($itm55b_r=3) & ($itm56_r>=1.2)) | (($itm55b_r>=3) & ($itm56_r=1.2)))
							$Item69B:="8"
						: (($itm55b_r>=2.7) & ($itm56_r>=0.9))
							$Item69B:="7"
						: (($itm55b_r>=2.4) & ($itm56_r>=0.6))
							$Item69B:="6"
						: (($itm55b_r>=1.8) & ($itm56_r>=0.6))
							$Item69B:="5"
						: (($itm55b_r>=1.2) & ($itm56_r>=0.6))
							$Item69B:="4"
						: ($itm41_txt="K")
							//The rating is low and the bridge is closed.        
							$Item69B:="0"
						: (($itm75a_txt="31") | ($itm75a_txt="32"))
							//Replacement planned.
							$Item69B:="2"
						Else 
							$Item69B:="3"
					End case 
				Else 
					//Main Line (not a ramp).          
					Case of 
						: (($itm55b_r>9.1) & ($itm56_r>9.1))
							$Item69B:="9"
						: ((($itm55b_r=9.1) & ($itm56_r>=9.1)) | (($itm55b_r>=9.1) & ($itm56_r=9.1)))
							$Item69B:="8"
						: (($itm55b_r>=6.4) & ($itm56_r>=5.5))
							$Item69B:="7"
						: (($itm55b_r>=3.7) & ($itm56_r>=1.8))
							$Item69B:="6"
						: (($itm55b_r>=3.4) & ($itm56_r>=1.5))
							$Item69B:="5"
						: (($itm55b_r>=3) & ($itm56_r>=1.2))
							$Item69B:="4"
						: ($itm41_txt="K")
							//The rating is low and the bridge is closed.        
							$Item69B:="0"
						: (($itm75a_txt="31") | ($itm75a_txt="32"))
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
				//       : ($itm55b_r>3)
				//        $Item69B:="9"
				//     : ($itm55b_r=3)
				//      $Item69B:="8"
				//   : ($itm55b_r>=2.7)
				//    $Item69B:="7"
				// : ($itm55b_r>=2.4)
				//  $Item69B:="6"
				//: ($itm55b_r>=1.8)
				// $Item69B:="5"
				//: ($itm55b_r>=1.2)
				// $Item69B:="4"
				//: ($itm41_txt="K")
				//The rating is low and the bridge is closed.        
				// $Item69B:="0"
				//: (($itm75a_txt="31") | ($itm75a_txt="32"))
				//Replacement planned.
				// $Item69B:="2"
				//Else 
				// $Item69B:="3"
				// End case 
				// Else 
				//Main line (not a ramp)
				//  Case of 
				//   : ($itm55b_r>9.1)
				//    $Item69B:="9"
				// : ($itm55b_r=9.1)
				//  $Item69B:="8"
				//: ($itm55b_r>=6.4)
				// $Item69B:="7"
				//  : ($itm55b_r>=3.7)
				//   $Item69B:="6"
				//: ($itm55b_r>=3.4)
				// $Item69B:="5"
				//: ($itm55b_r>=3)
				//  $Item69B:="4"
				// : ($itm41_txt="K")
				//The rating is low and the bridge is closed.        
				//  $Item69B:="0"
				//: (($itm75a_txt="31") | ($itm75a_txt="32"))
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
				//        : ($itm55b_r>3)
				//         $Item69B:="9"
				//      : ($itm55b_r=3)
				//       $Item69B:="8"
				//    : ($itm55b_r>=2.7)
				//     $Item69B:="7"
				//  : ($itm55b_r>=2.4)
				//   $Item69B:="6"
				//: ($itm55b_r>=1.8)
				// $Item69B:="5"
				//: ($itm55b_r>=1.2)
				// $Item69B:="4"
				//: ($itm41_txt="K")
				//The rating is low and the bridge is closed.        
				// $Item69B:="0"
				//: (($itm75a_txt="31") | ($itm75a_txt="32"))
				//Replacement planned.
				// $Item69B:="2"
				//Else 
				// $Item69B:="3"
				//End case 
				// *** End of change #5       
				//End of change on 8/22/00
				
			: ($Column=2)
				Case of 
					: ($itm55b_r>9.1)
						$Item69B:="9"
					: ($itm55b_r=9.1)
						$Item69B:="8"
					: ($itm55b_r>=6.4)
						$Item69B:="7"
					: ($itm55b_r>=3.7)
						$Item69B:="6"
					: ($itm55b_r>=3)
						$Item69B:="5"
					: ($itm55b_r>=1.8)
						$Item69B:="4"
					: ($itm41_txt="K")
						//The rating is low and the bridge is closed.        
						$Item69B:="0"
					: (($itm75a_txt="31") | ($itm75a_txt="32"))
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
				//       : ($itm55b_r>3)
				//         $Item69B:="9"
				//       : ($itm55b_r=3)
				//         $Item69B:="8"
				//       : ($itm55b_r>=2.7)
				//         $Item69B:="7"
				//       : ($itm55b_r>=2.4)
				//         $Item69B:="6"
				//       : ($itm55b_r>=1.8)
				//         $Item69B:="5"
				//       : ($itm55b_r>=1.2)
				//         $Item69B:="4"
				//       : ($itm41_txt="K")
				//           `The rating is low and the bridge is closed.        
				//        $Item69B:="0"
				//     : (($itm75a_txt="31") | ($itm75a_txt="32"))
				//        `Replacement planned.
				//     $Item69B:="2"
				//  Else 
				//   $Item69B:="3"
				//End case 
				//End of change on 8/22/00
				// *** End of Change #6
				
			: ($Column=3)
				Case of 
					: ($itm55b_r>3.7)
						$Item69B:="9"
					: ($itm55b_r=3.7)
						$Item69B:="8"
					: ($itm55b_r>=3.4)
						$Item69B:="7"
					: ($itm55b_r>=3)
						$Item69B:="6"
					: ($itm55b_r>=2.4)
						$Item69B:="5"
					: ($itm55b_r>=1.2)
						$Item69B:="4"
					: ($itm41_txt="K")
						//The rating is low and the bridge is closed.        
						$Item69B:="0"
					: (($itm75a_txt="31") | ($itm75a_txt="32"))
						//Replacement planned.
						$Item69B:="2"
					Else 
						$Item69B:="3"
				End case 
				
			Else   //Use the 4th column, railroad.
				Case of 
					: ($itm55b_r>6.1)
						$Item69B:="9"
					: ($itm55b_r=6.1)
						$Item69B:="8"
					: ($itm55b_r>=5.2)
						$Item69B:="7"
					: ($itm55b_r>=4.3)
						$Item69B:="6"
					: ($itm55b_r>=3.4)
						$Item69B:="5"
					: ($itm55b_r>=2.4)
						$Item69B:="4"
					: ($itm41_txt="K")
						//The rating is low and the bridge is closed.        
						$Item69B:="0"
					: (($itm75a_txt="31") | ($itm75a_txt="32"))
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