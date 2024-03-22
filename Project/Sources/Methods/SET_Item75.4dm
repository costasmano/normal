//%attributes = {"invisible":true}
//SET_Item75 

//This procedure updates Item75a, Item75b, Item76, Item94, Item95, Item96 and 
//Item97 based on the logic provided by Alex Bardow
If (False:C215)
	
	//April, 2001
	
	//ReplaceCost ; RehabCost ; DeckRepCost :   
	//       Declared and Passed by form [Dialogs]Item75Costs
	
	// Modified by: costasmanousakis-(Designer)-(12/5/08 08:40:50)
	Mods_2008_CM_5404
	//  `Added code to export various values to a tab delim text file controlled by the M_SetItem75 method.
	// Modified by: Costas Manousakis-(Designer)-(3/1/17 15:39:08)
	Mods_2017_03
	//  `use ◊SIA_LoadRtg_63_RF_txt to decide if  InvRating is rating factor or MT and convert item66 to MT if RF
End if 

//Variable declaration for Item75
C_REAL:C285($RyWdth)
C_TEXT:C284($Item75a)  // Command Replaced was o_C_STRING length was 2
C_TEXT:C284($Item75b)  // Command Replaced was o_C_STRING length was 1
C_LONGINT:C283($key)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($curryear)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($Item42b)  // Command Replaced was o_C_STRING length was 1

//Variable declaration for Item76
C_LONGINT:C283($Item76)  //Command Replaced was o_C_INTEGER
C_REAL:C285($lengthfctr; $skew)
C_REAL:C285($length)

//Variable declaration for Item94
C_REAL:C285($barrier)
C_REAL:C285($area)
C_REAL:C285($span)
C_REAL:C285($widening)
C_REAL:C285($costwide)
C_REAL:C285($costdeckrep)
C_LONGINT:C283($Item94)  //Command Replaced was o_C_INTEGER

//Initialize: Set Item75a and Item75b to blank
$Item75a:=""
$Item75b:=""
$key:=0
$curryear:=Year of:C25(Current date:C33(*))
$item42b:=Substring:C12([Bridge MHD NBIS:1]Item42:85; 2; 1)

C_TEXT:C284($Itm75Reason_txt; $ExportLine_txt)
$Itm75Reason_txt:=""
$ExportLine_txt:=""

//If the bridge was worked on within the last 9 years, Item75 remains blank 
// and you want to STOP

//DBD 010902 Added condition for Item41 = "G" (New structure) to if statement

If (([Bridge MHD NBIS:1]Item27:83>($curryear-9)) | ([Bridge MHD NBIS:1]Item106:84>($curryear-9)) | ([Bridge MHD NBIS:1]Item41:141="G"))
	[Bridge MHD NBIS:1]Item75A:152:="  "
	[Bridge MHD NBIS:1]Item75B:153:=" "
	[Bridge MHD NBIS:1]Item76:154:=0
	[Bridge MHD NBIS:1]Item94:155:=0
	[Bridge MHD NBIS:1]Item95:156:=0
	[Bridge MHD NBIS:1]Item96:157:=0
	[Bridge MHD NBIS:1]Item97:158:=0
Else 
	C_REAL:C285($InvRtg_r)
	If (Position:C15([Bridge MHD NBIS:1]Item 65:200; <>SIA_LoadRtg_63_RF_txt)>0)
		$InvRtg_r:=[Bridge MHD NBIS:1]Item66:139*32.4
	Else 
		$InvRtg_r:=[Bridge MHD NBIS:1]Item66:139
	End if 
	
	$ExportLine_txt:=[Bridge MHD NBIS:1]Item102:123+<>sTAB+String:C10([Bridge MHD NBIS:1]Item51:96)+<>sTAB+String:C10([Bridge MHD NBIS:1]Item32:98)+<>sTAB+String:C10([Bridge MHD NBIS:1]Item53:105)
	$ExportLine_txt:=$ExportLine_txt+<>sTAB+[Bridge MHD NBIS:1]Item71:145+<>STAB+[Bridge MHD NBIS:1]Item58:130+<>STAB+[Bridge MHD NBIS:1]Item59:131
	$ExportLine_txt:=$ExportLine_txt+<>sTAB+[Bridge MHD NBIS:1]Item60:132+<>STAB+[Bridge MHD NBIS:1]Item62:134+<>STAB+String:C10($InvRtg_r)
	$ExportLine_txt:=$ExportLine_txt+<>sTAB+[Bridge MHD NBIS:1]Item72:146+<>STAB+[Bridge MHD NBIS:1]Item107:79+<>STAB+[Bridge MHD NBIS:1]Item69:144
	$ExportLine_txt:=$ExportLine_txt+<>sTAB+[Bridge MHD NBIS:1]Item113:151+<>STAB+[Bridge MHD NBIS:1]Item36A:147+<>STAB+String:C10([Bridge MHD NBIS:1]Item34:100)
	$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10([Bridge MHD NBIS:1]Item49:93)+<>STAB+String:C10([Bridge MHD NBIS:1]Item52:97)+<>STAB+[Bridge MHD NBIS:1]Item41:141
	$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10([Bridge MHD NBIS:1]Item29:88)+<>STAB+String:C10([Bridge MHD NBIS:1]Item28A:86)
	$ExportLine_txt:=[Bridge MHD NBIS:1]BDEPT:1+<>sTAB+[Bridge MHD NBIS:1]BIN:3+<>STAB+[Bridge MHD NBIS:1]Item8:206+<>STAB+[Bridge MHD NBIS:1]Item7:65+<>sTAB+[Bridge MHD NBIS:1]Item6A:63+<>sTab+$ExportLine_txt
	
	$RyWdth:=SET_Rywdth
	
	//If it is a single lane bridge for 2-way traffic, replace bridge    
	If ([Bridge MHD NBIS:1]Item102:123="3")
		$Item75a:="31"
		$Itm75Reason_txt:="Single Lane 2-way traffic"
	End if 
	// If roadway width is less than 11 feet (3.4m) for one-way traffic, replace bridg
	If ([Bridge MHD NBIS:1]Item102:123="1")
		If (([Bridge MHD NBIS:1]Item51:96>0) & ([Bridge MHD NBIS:1]Item51:96<3.4))
			$Item75a:="31"
			$Itm75Reason_txt:="<11ft 1-way traffic"
		End if 
		If ([Bridge MHD NBIS:1]Item51:96=0)
			If ([Bridge MHD NBIS:1]Item32:98<3.4)
				$item75a:="31"
				$Itm75Reason_txt:="<11ft 1-way traffic"
			End if 
		End if 
	End if 
	//If roadway width is less than 16feet(4.9m) for 2-way traffic, replace bridge
	If ([Bridge MHD NBIS:1]Item102:123="2")
		If (([Bridge MHD NBIS:1]Item51:96>0) & ([Bridge MHD NBIS:1]Item51:96<4.9))
			$Item75a:="31"
			$Itm75Reason_txt:="<16ft 2-way traffic"
		End if 
		If ([Bridge MHD NBIS:1]Item51:96=0)
			If ([Bridge MHD NBIS:1]Item32:98<4.9)
				$item75a:="31"
				$Itm75Reason_txt:="<16ft 2-way traffic"
			End if 
		End if 
	End if 
	
	If ($Item75a="")
		Case of 
				//If the clearance over the bridge is less than 13 feet(3.96m), replace bridge
			: ([Bridge MHD NBIS:1]Item53:105<3.96)
				$Item75a:="31"
				$Itm75Reason_txt:="Over Clearance<13ft"
				
				//If waterway opening is too restrictive, replace bridge  
			: ((($Item42b="0") | (Num:C11($Item42b)>=5)) & ((Num:C11([Bridge MHD NBIS:1]Item71:145)<=2) & bIsNumeric([Bridge MHD NBIS:1]Item71:145)))
				$Item75a:="31"
				$Itm75Reason_txt:="Waterway Opening restrictive"
				
				//If bridge super/sub/culvert conditions are critical or worse, replace bridge
			: ((bIsNumeric([Bridge MHD NBIS:1]Item59:131)) & (Num:C11([Bridge MHD NBIS:1]Item59:131)<=2))
				$Item75a:="31"
				$Itm75Reason_txt:="Item 59 <=2"
			: ((bIsNumeric([Bridge MHD NBIS:1]Item60:132)) & (Num:C11([Bridge MHD NBIS:1]Item60:132)<=2))
				$Item75a:="31"
				$Itm75Reason_txt:="Item 60 <=2"
			: ((bIsNumeric([Bridge MHD NBIS:1]Item62:134)) & (Num:C11([Bridge MHD NBIS:1]Item62:134)<=2))
				$Item75a:="31"
				$Itm75Reason_txt:="Item 62 <=2"
		End case 
	End if 
	
	// If brige inventory rating does not meet statutory and the super/sub/culvert
	//conditions are poor or worse, replace bridge
	
	If (($item75a="") & ($InvRtg_r<32.4))
		Case of 
			: ((Num:C11([Bridge MHD NBIS:1]Item59:131)>2) & (Num:C11([Bridge MHD NBIS:1]Item59:131)<=4))
				$Item75a:="31"
				$Itm75Reason_txt:="Inv Rtg < 32.4  &  2< Item59 <=4"
			: ((Num:C11([Bridge MHD NBIS:1]Item60:132)>2) & (Num:C11([Bridge MHD NBIS:1]Item60:132)<=4))
				$Item75a:="31"
				$Itm75Reason_txt:="Inv Rtg < 32.4  &  2< Item60 <=4"
			: ((Num:C11([Bridge MHD NBIS:1]Item62:134)>2) & (Num:C11([Bridge MHD NBIS:1]Item62:134)<=4))
				$Item75a:="31"
				$Itm75Reason_txt:="Inv Rtg < 32.4  &  2< Item62 <=4"
		End case 
	End if 
	
	// If brige inventory rating does not meet statutory and the super/sub/culvert
	//conditions are better than poor, rehabilitate bridge
	If (($item75a="") & ($InvRtg_r<32.4))
		Case of 
			: (Num:C11([Bridge MHD NBIS:1]Item59:131)>4)
				$Item75a:="35"
				$Itm75Reason_txt:="Inv Rtg < 32.4  &  Item59 >4"
			: (Num:C11([Bridge MHD NBIS:1]Item60:132)>4)
				$Item75a:="35"
				$Itm75Reason_txt:="Inv Rtg < 32.4  &  Item60 >4"
			: (Num:C11([Bridge MHD NBIS:1]Item62:134)>4)
				$Item75a:="35"
				$Itm75Reason_txt:="Inv Rtg < 32.4  &  Item62 >4"
		End case 
	End if 
	
	// If brige invntory rating meets statutory and the super/sub/culvert
	//conditions are better than critical up to satisfactory, rehabilitate bridge
	If (($Item75a="") & ($InvRtg_r>=32.4))
		Case of 
			: ((Num:C11([Bridge MHD NBIS:1]Item59:131)>2) & (Num:C11([Bridge MHD NBIS:1]Item59:131)<=5))
				$Item75a:="35"
				$Itm75Reason_txt:="Inv Rating >=32.4 & 2< Item62 <=5"
			: ((Num:C11([Bridge MHD NBIS:1]Item60:132)>2) & (Num:C11([Bridge MHD NBIS:1]Item60:132)<=5))
				$Item75a:="35"
				$Itm75Reason_txt:="Inv Rating >=32.4 & 2< Item62 <=5"
			: ((Num:C11([Bridge MHD NBIS:1]Item62:134)>2) & (Num:C11([Bridge MHD NBIS:1]Item62:134)<=5))
				$Item75a:="35"
				$Itm75Reason_txt:="Inv Rating >=32.4 & 2< Item62 <=5"
		End case 
	End if 
	
	//Relocate road if approach roadway alignment condition is 3 or less
	If (($Item75a="") & ((Num:C11([Bridge MHD NBIS:1]Item72:146)<=3) & (bIsNumeric([Bridge MHD NBIS:1]Item72:146))))
		$Item75a:="32"
		$Itm75Reason_txt:="Approach Rwy alignment <=3"
	End if 
	
	//DBD First If
	
	If ($Item75a="")
		
		If ([Bridge MHD NBIS:1]Item107:79#"N")
			//Check if the road width is equal or greater than desirable
			If ([Bridge MHD NBIS:1]Item51:96>=$RyWdth)
				Case of 
						// If deck condition is poor or worse,replace          
					: ((bIsNumeric([Bridge MHD NBIS:1]Item58:130)) & (Num:C11([Bridge MHD NBIS:1]Item58:130)<=4))
						$item75a:="37"
						$Itm75Reason_txt:="Adequate Road Width & Item58 <=4"
						// DBD 013002 Added line to test if culvert condition is poor or worse,replace    
					: ((bIsNumeric([Bridge MHD NBIS:1]Item62:134)) & (Num:C11([Bridge MHD NBIS:1]Item62:134)<=4))
						$item75a:="37"
						//If deck condition is fair, rehabilitate
						$Itm75Reason_txt:="Adequate Road Width & Item62 <=4"
					: ([Bridge MHD NBIS:1]Item58:130="5")
						$item75a:="36"
						//DBD 013002 Added line to test if deck condition is fair, rehabilitate
						$Itm75Reason_txt:="Adequate Road Width & Item58 =5"
					: ([Bridge MHD NBIS:1]Item62:134="5")
						$item75a:="36"
						$Itm75Reason_txt:="Adequate Road Width & Item62 =5"
				End case 
			Else 
				Case of 
						//If road width is less than desirable and deck condition is less than or
						// equal to fair, widen with rehabilitation / replacement             
					: ((bIsNumeric([Bridge MHD NBIS:1]Item58:130)) & (Num:C11([Bridge MHD NBIS:1]Item58:130)<=5))
						$item75a:="34"
						$Itm75Reason_txt:="InAdequate Road Width & Item58 <=5"
						//DBD 013002 Added condition to test if culvert condition is less than or
						// equal to fair, widen with rehabilitation / replacement             
					: ((bIsNumeric([Bridge MHD NBIS:1]Item62:134)) & (Num:C11([Bridge MHD NBIS:1]Item62:134)<=5))
						$item75a:="34"
						$Itm75Reason_txt:="InAdequate Road Width & Item62 <=5"
						//If road width is less than desirable and deck condition is better than fair
						// widen without  rehabilitation / replacement   
					: (Num:C11([Bridge MHD NBIS:1]Item58:130)>5)
						$item75a:="33"
						$Itm75Reason_txt:="InAdequate Road Width & Item58 >5"
						//DBD 013002 Added condition to test if culvert condition is better than fair
						// widen without  rehabilitation / replacement   
					: (Num:C11([Bridge MHD NBIS:1]Item62:134)>5)
						$item75a:="33"
						$Itm75Reason_txt:="InAdequate Road Width & Item62 >5"
				End case 
			End if 
			
		Else 
			// If there is no deck but road width is less than desirable, set item75a=33
			Case of 
				: (([Bridge MHD NBIS:1]Item51:96>0) & ([Bridge MHD NBIS:1]Item51:96<$RyWdth))
					$item75a:="33"
					$Itm75Reason_txt:="No Deck & InAdequate Road Width"
				: (([Bridge MHD NBIS:1]Item51:96=0) & ([Bridge MHD NBIS:1]Item32:98<$RyWdth))
					$item75a:="33"
					$Itm75Reason_txt:="No Deck & InAdequate Road Width"
			End case 
		End if 
	End if 
	
	//If bridge inventory rating meets statutory and the super/sub/culvert
	//conditions are satisfactory, perform other structural work
	If (($item75a="") & ($InvRtg_r>=32.4))
		If (([Bridge MHD NBIS:1]Item59:131="6") | ([Bridge MHD NBIS:1]Item60:132="6") | ([Bridge MHD NBIS:1]Item62:134="6"))
			$item75a:="38"
			$Itm75Reason_txt:="Inv Rtg>=32.4 & Itm58 or 60 or 62 = 6"
			$key:=1
		End if 
	End if 
	
	//If clearance under bridge is less than the MHD specified minimum, do other 
	//structural work
	If ((($item75a="") & ((Num:C11([Bridge MHD NBIS:1]Item69:144)<6) & bIsNumeric([Bridge MHD NBIS:1]Item69:144))))
		$item75a:="38"
		$Itm75Reason_txt:="UnderClearance < 6m"
		$key:=2
	End if 
	
	//If waterway opening is only somewhat restrictive, do other structural work
	If ($item75a="")
		If (($item42b="0") | (Num:C11($item42b)>=5))
			If ([Bridge MHD NBIS:1]Item71:145="3")
				$item75a:="38"
				$Itm75Reason_txt:="Waterway Opening is only somewhat restrictive"
				$key:=3
			End if 
		End if 
	End if 
	
	//Check to see if scour repair/countermeasures are required
	If ($item75a="")
		If ((Num:C11([Bridge MHD NBIS:1]Item113:151)>0) & (Num:C11([Bridge MHD NBIS:1]Item113:151)<=4))
			$item75a:="38"
			$Itm75Reason_txt:="Scour Repair/Countermeasures are required"
			$key:=4
		End if 
	End if 
	
	// Check to see if bridge rail upgrades are needed
	If ($item75a="")
		If (([Bridge MHD NBIS:1]Item36A:147#"N") & ([Bridge MHD NBIS:1]Item36A:147="0"))
			$item75a:="38"
			$Itm75Reason_txt:="Bridge Rail upgrades are needed"
			$key:=5
		End if 
	End if 
	
	If ($item75a#"")
		$ExportLine_txt:=$ExportLine_txt+<>sTAB+$Itm75Reason_txt
		$ExportLine_txt:=$ExportLine_txt+<>sTAB+$item75a
		$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10($RyWdth)
		
		//All work indicated as needed by Item 75A will be done by contract forces
		$Item75b:="1"
		
		//calculate Cosine of skew
		If ([Bridge MHD NBIS:1]Item34:100<=90)
			$skew:=Cos:C18(Degree:K30:2*[Bridge MHD NBIS:1]Item34:100)
		Else 
			// if item34 is bigger than 90 ie 99 assume skew is 0
			$skew:=Cos:C18(Degree:K30:2*0)
		End if 
		// ****************************************************
		// Calculate NBI Item76: Length of Structure Improvement 
		// ****************************************************
		
		//Use formula provided in the Coding Guide to estimate the length of structure
		//for replacement structures (Item75A=31 or 32)    
		If (($Item75a="31") | ($Item75a="32"))
			//Calculate Item 76 for non-culvert bridges based on structure length (Item 49)
			If ([Bridge MHD NBIS:1]Item62:134="N")
				If (Round:C94([Bridge MHD NBIS:1]Item49:93; 1)<=30.9)
					$lengthfctr:=2.894-(0.1919*[Bridge MHD NBIS:1]Item49:93)+(0.00815*([Bridge MHD NBIS:1]Item49:93^2))-(0.0001176*([Bridge MHD NBIS:1]Item49:93^3))
				Else 
					If ([Bridge MHD NBIS:1]Item49:93<=300)
						$lengthfctr:=1.436-(0.00623*[Bridge MHD NBIS:1]Item49:93)+(0.0000351*([Bridge MHD NBIS:1]Item49:93^2))-(0.000000071*([Bridge MHD NBIS:1]Item49:93^3))
					Else 
						$lengthfctr:=1
					End if 
				End if 
				$Item76:=Round:C94((([Bridge MHD NBIS:1]Item49:93*$lengthfctr)+0.5); 0)
				$ExportLine_txt:=$ExportLine_txt+<>sTAB+"Itm49Factor"+<>sTAB+String:C10($lengthfctr)
			Else 
				//Calculate Item76 for culverts along the centerline of barrel based on the
				//roadway width and the skew of the culvert (include  3 m for barriers/sidewalk)
				$length:=($RyWdth/$skew)+3
				$item76:=Round:C94(($length+0.5); 0)
				$ExportLine_txt:=$ExportLine_txt+<>sTAB+"CulvertLen+3"+<>sTAB+String:C10($lengthfctr)
			End if 
		End if 
		
		//For all other types of work, no increase in structure length is assumed, so 
		//Item76 will be equal to the present length of structure (Item49) except for 
		// culverts    
		If ((Num:C11($Item75a)>=33) & (Num:C11($Item75a)<=38))
			If ([Bridge MHD NBIS:1]Item62:134="N")
				$Item76:=Round:C94(([Bridge MHD NBIS:1]Item49:93+0.5); 0)
				$ExportLine_txt:=$ExportLine_txt+<>sTAB+"Itm49Factor"+<>sTAB+String:C10(1)
			End if 
		End if 
		
		// For Item 75A=33 for culverts, calculate Item76 along the centerline of culvert
		//based on the estimated length of widening required    
		If ([Bridge MHD NBIS:1]Item62:134#"N")
			If ($Item75a="33")
				If ([Bridge MHD NBIS:1]Item51:96=0)
					$length:=$RyWdth-([Bridge MHD NBIS:1]Item32:98)
					$Item76:=Round:C94((($length/$skew)+0.5); 0)
					$ExportLine_txt:=$ExportLine_txt+<>sTAB+"RwyWidt-I32"+<>sTAB+String:C10($length)
				Else 
					$length:=$RyWdth-([Bridge MHD NBIS:1]Item51:96)
					$Item76:=Round:C94((($length/$skew)+0.5); 0)
					$ExportLine_txt:=$ExportLine_txt+<>sTAB+"RwyWidt-I51"+<>sTAB+String:C10($length)
				End if 
			End if 
			
			//For Item75A=35 or 38 for culverts, no increase of culvert length is assumed,
			//so calculate item 76 based on the existing centerline length of culvert
			If (($Item75a="35") | ($Item75a="38"))
				If ([Bridge MHD NBIS:1]Item51:96=0)
					$Item76:=Round:C94((([Bridge MHD NBIS:1]Item32:98/$skew)+0.5); 0)
					$ExportLine_txt:=$ExportLine_txt+<>sTAB+"I32/skew"+<>sTAB+String:C10([Bridge MHD NBIS:1]Item32:98/$skew)
				Else 
					//Changed from item 52 to 51          
					$Item76:=Round:C94((([Bridge MHD NBIS:1]Item51:96/$skew)+0.5); 0)
					$ExportLine_txt:=$ExportLine_txt+<>sTAB+"I51/skew"+<>sTAB+String:C10([Bridge MHD NBIS:1]Item51:96/$skew)
				End if 
			End if 
		End if 
		$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10($Item76)
		
		// ****************************************************
		//Calculate Item94: Bridge Improvement Cost 
		// ****************************************************   
		
		// For structure replacements, calculate Item94 based on the estimated structure
		//area and the inputted bridge replacement cost    
		If (($Item75a="31") | ($Item75a="32"))
			If ([Bridge MHD NBIS:1]Item62:134="N")
				$barrier:=([Bridge MHD NBIS:1]Item52:97-[Bridge MHD NBIS:1]Item51:96)
				$area:=$Item76*($RyWdth+$barrier)
				$item94:=Round:C94(((($area*ReplaceCost)/1000)+0.5); 0)
				$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10($RyWdth+$barrier)+<>sTAB+String:C10($area)+<>sTAB+String:C10(ReplaceCost)+<>sTAB+String:C10(1)
				
				// for culvert replacements, assume that the span of the culvert will be increased
				//by 20% in addition to any widening estimated by Item76
			Else 
				$span:=[Bridge MHD NBIS:1]Item49:93*1.2*$skew
				$area:=$Item76*$span
				$item94:=Round:C94(((($area*ReplaceCost)/1000)+0.5); 0)
				$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10($span)+<>sTAB+String:C10($area)+<>sTAB+String:C10(ReplaceCost)+<>sTAB+String:C10(1)
			End if 
		End if 
		
		If ($Item75a="33")
			//For structure widening, calculate Item94 based on the estimated area of the 
			//widening and 180% of the bridge replacement cost, as specified in the coding
			//guide
			If ([Bridge MHD NBIS:1]Item62:134="N")
				$widening:=($RyWdth-[Bridge MHD NBIS:1]Item51:96)
				$area:=$Item76*$widening
				$Item94:=Round:C94(((($area*ReplaceCost*1.8)/1000)+0.5); 0)
				$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10($widening)+<>sTAB+String:C10($area)+<>sTAB+String:C10(ReplaceCost)+<>sTAB+String:C10(1.8)
			Else 
				$area:=$Item76*[Bridge MHD NBIS:1]Item49:93*$skew
				$Item94:=Round:C94(((($area*ReplaceCost*1.8)/1000)+0.5); 0)
				$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10([Bridge MHD NBIS:1]Item49:93*$skew)+<>sTAB+String:C10($area)+<>sTAB+String:C10(ReplaceCost)+<>sTAB+String:C10(1.8)
			End if 
		End if 
		
		//For deck widening with rehabilitation/replacement of the existing deck, calculat
		//Item94 based on the sum of the widening cost and rehabilitation/
		//replacement cost
		If ($Item75a="34")
			$widening:=($RyWdth-[Bridge MHD NBIS:1]Item51:96)
			$costwide:=$widening*$Item76*ReplaceCost*1.8
			$costdeckrep:=[Bridge MHD NBIS:1]Item52:97*$Item76*DeckRepCost
			$Item94:=Round:C94(((($costwide+$costdeckrep)/1000)+0.5); 0)
			$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10($widening)+<>sTAB+String:C10([Bridge MHD NBIS:1]Item52:97)+<>sTAB+String:C10(ReplaceCost)+<>sTAB+String:C10(1.8)
		End if 
		
		//For bridge rehabilitations, calculate Item94 based on the existing deck or 
		//culvert area and the inputted bridge rehabilitation cost
		If ($Item75a="35")
			If ([Bridge MHD NBIS:1]Item62:134="N")
				$area:=$Item76*[Bridge MHD NBIS:1]Item52:97
				$item94:=Round:C94(((($area*RehabCost)/1000)+0.5); 0)
				$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10([Bridge MHD NBIS:1]Item52:97)+<>sTAB+String:C10($area)+<>sTAB+String:C10(RehabCost)+<>sTAB+String:C10(1)
			Else 
				$span:=[Bridge MHD NBIS:1]Item49:93*$skew
				$area:=$Item76*$span
				$item94:=Round:C94(((($area*RehabCost)/1000)+0.5); 0)
				$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10([Bridge MHD NBIS:1]Item49:93*$skew)+<>sTAB+String:C10($area)+<>sTAB+String:C10(RehabCost)+<>sTAB+String:C10(1)
			End if 
		End if 
		
		//For a deck rehabilitation calculate Item94 based on the existing deck area and
		//60% of the inputted deck repalcement cost
		If ($Item75a="36")
			$area:=$Item76*[Bridge MHD NBIS:1]Item52:97
			$item94:=Round:C94(((($area*DeckRepCost*0.6)/1000)+0.5); 0)
			$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10([Bridge MHD NBIS:1]Item52:97)+<>sTAB+String:C10($area)+<>sTAB+String:C10(DeckRepCost)+<>sTAB+String:C10(0.6)
		End if 
		
		//For deck replacement calculate Item94 based on the existing deck area and 
		// the inputted deck repalcement cost
		If ($Item75a="37")
			$area:=$Item76*[Bridge MHD NBIS:1]Item52:97
			$item94:=Round:C94(((($area*DeckRepCost)/1000)+0.5); 0)
			$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10([Bridge MHD NBIS:1]Item52:97)+<>sTAB+String:C10($area)+<>sTAB+String:C10(DeckRepCost)+<>sTAB+String:C10(1)
		End if 
		
		//For Item75A=38, other structural work, use the existing deck or culvert area
		//multiplied by a percentage of the inputted bridge rehabilitation cost
		If ($Item75a="38")
			If ([Bridge MHD NBIS:1]Item62:134="N")
				$area:=$Item76*[Bridge MHD NBIS:1]Item52:97
				$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10([Bridge MHD NBIS:1]Item52:97)+<>sTAB+String:C10($area)
			Else 
				$span:=[Bridge MHD NBIS:1]Item49:93*$skew
				$area:=$Item76*$span
				$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10([Bridge MHD NBIS:1]Item49:93*$skew)+<>sTAB+String:C10($area)
			End if 
			
			Case of 
					//Assume bridge betterments will cost 20% of a bridge rehab      
				: ($key=1)
					$Item94:=Round:C94(((($area*RehabCost*0.2)/1000)+0.5); 0)
					$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10(RehabCost)+<>sTAB+String:C10(0.2)
					//Assume bridge clearance improvements  cost 10% of a bridge rehab
				: ($key=2)
					$Item94:=Round:C94(((($area*RehabCost*0.1)/1000)+0.5); 0)
					$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10(RehabCost)+<>sTAB+String:C10(0.1)
					//Assume waterway improvements cost 15% of a bridge rehab
				: ($key=3)
					$Item94:=Round:C94(((($area*RehabCost*0.15)/1000)+0.5); 0)
					$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10(RehabCost)+<>sTAB+String:C10(0.15)
					//Assume scour repairs/countermeasures cost 30% of a bridge rehab
				: ($key=4)
					$Item94:=Round:C94(((($area*RehabCost*0.3)/1000)+0.5); 0)
					$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10(RehabCost)+<>sTAB+String:C10(0.3)
					//Assume that bridge railing improvements cost 5% of a bridge rehab
				: ($key=5)
					$Item94:=Round:C94(((($area*RehabCost*0.05)/1000)+0.5); 0)
					$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10(RehabCost)+<>sTAB+String:C10(0.05)
			End case 
		End if 
		
		[Bridge MHD NBIS:1]Item75A:152:=$Item75a
		[Bridge MHD NBIS:1]Item75B:153:=$Item75b
		
		//Some messages...
		If ($RyWdth=0)
			ut_Message("BIN : "+[Bridge MHD NBIS:1]BIN:3+" - Rd Width not calculated !!!"+<>sCR+<>sLF)
			//SEND PACKET(dMsgFile;"BIN : "+[Bridge MHD NBIS]BIN+" - Rd Width not calculated !!!"+◊sCR+◊sLF)
			bItm75Errors:=True:C214
		End if 
		If ($Item76<=0)
			ut_Message("BIN : "+[Bridge MHD NBIS:1]BIN:3+" - Length not calculated properly ("+String:C10($Item76)+") !!!"+<>sCR+<>sLF)
			//SEND PACKET(dMsgFile;"BIN : "+[Bridge MHD NBIS]BIN+" - Length not calculated properly ("+String($Item76)+") !!!"+◊sCR+◊sLF)
			bItm75Errors:=True:C214
		End if 
		
		//DBD 010902 Added message for condition if Item41<> K and Item29 ADT = 0
		If ([Bridge MHD NBIS:1]Item41:141#"K")
			If ([Bridge MHD NBIS:1]Item29:88=0)
				ut_Message("BIN : "+[Bridge MHD NBIS:1]BIN:3+" - Bridge not closed but ADT = 0 !!!"+<>sCR+<>sLF)
				//SEND PACKET(dMsgFile;"BIN : "+[Bridge MHD NBIS]BIN+" - Bridge not closed but ADT = 0 !!!"+◊sCR+◊sLF)
				bItm75Errors:=True:C214
			End if 
		End if 
		
		//DBD 010902 Added message for condition if Item102 = 0 and Item29 ADT > 0
		If ([Bridge MHD NBIS:1]Item102:123="0")
			If ([Bridge MHD NBIS:1]Item29:88>0)
				ut_Message("BIN :"+[Bridge MHD NBIS:1]BIN:3+" - Highway traffic not carried / ADT>0"+<>sCR+<>sLF)
				//SEND PACKET(dMsgFile;"BIN : "+[Bridge MHD NBIS]BIN+" - Highway traffic not carried / ADT > 0 !!!"+◊sCR+◊sLF)
				bItm75Errors:=True:C214
			End if 
		End if 
		
		//DBD 010902 Added message for condition if Item102 > 0 and Item28A = 0
		If ([Bridge MHD NBIS:1]Item102:123>"0")
			If ([Bridge MHD NBIS:1]Item28A:86=0)
				ut_Message("BIN : "+[Bridge MHD NBIS:1]BIN:3+" - Highway traffic on / NO lanes on!!!"+<>sCR+<>sLF)
				//SEND PACKET(dMsgFile;"BIN : "+[Bridge MHD NBIS]BIN+" - Highway traffic on / NO lanes on!!!"+◊sCR+◊sLF)
				bItm75Errors:=True:C214
			End if 
		End if 
		
		//DBD 010902 Added message for condition if Item29 > 0 and Item28A = 0
		If ([Bridge MHD NBIS:1]Item29:88>0)
			If ([Bridge MHD NBIS:1]Item28A:86=0)
				ut_Message("BIN : "+[Bridge MHD NBIS:1]BIN:3+" - ADT > 0 / No Lanes on!!!"+<>sCR+<>sLF)
				//SEND PACKET(dMsgFile;"BIN : "+[Bridge MHD NBIS]BIN+" -ADT > 0/ No Lanes on!!!"+◊sCR+◊sLF)
				bItm75Errors:=True:C214
			End if 
		End if 
		
		//DBD 013002 Added message for condition if Item102 = 2 and Item28A = 1
		If ([Bridge MHD NBIS:1]Item102:123="2")
			If ([Bridge MHD NBIS:1]Item28A:86=1)
				ut_Message("BIN : "+[Bridge MHD NBIS:1]BIN:3+" - 2 way direction of traffic/only 1 lane on-Code 102 as 3!!!"+<>sCR+<>sLF)
				//SEND PACKET(dMsgFile;"BIN : "+[Bridge MHD NBIS]BIN+" - 2 way direction of traffic/only 1 lane on-Code 102 as 3!!!"+◊sCR+◊sLF)
				bItm75Errors:=True:C214
			End if 
		End if 
		
		//DBD 021402 Added message for condition Item102 = 0
		If ([Bridge MHD NBIS:1]Item102:123="0")
			ut_Message("BIN : "+[Bridge MHD NBIS:1]BIN:3+" - NBI Structure--102=0 !!!"+<>sCR+<>sLF)
			//SEND PACKET(dMsgFile;"BIN : "+[Bridge MHD NBIS]BIN+" - NBI Structure--102=0 !!!"+◊sCR+◊sLF)
			bItm75Errors:=True:C214
		End if 
		
		
		[Bridge MHD NBIS:1]Item76:154:=$Item76
		
		[Bridge MHD NBIS:1]Item94:155:=$Item94
		
		// ****************************************************
		//Calculate Item95 as being 10% of Item94 as suggested in the Coding Guide
		// ****************************************************
		
		[Bridge MHD NBIS:1]Item95:156:=Round:C94((($Item94*0.1)+0.5); 0)
		
		// ****************************************************
		//Calculate Item96 as being 150% of Item94 as suggested in the Coding Guide
		// ****************************************************
		
		[Bridge MHD NBIS:1]Item96:157:=Round:C94((($Item94*1.5)+0.5); 0)
		
		// ****************************************************
		//Input the current year in Item97
		// ****************************************************
		$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10($Item94)
		$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10([Bridge MHD NBIS:1]Item95:156)
		$ExportLine_txt:=$ExportLine_txt+<>sTAB+String:C10([Bridge MHD NBIS:1]Item96:157)
		
		[Bridge MHD NBIS:1]Item97:158:=$curryear
	Else 
		$ExportLine_txt:=$ExportLine_txt+<>sTAB+"Item 75 not calculated !!!"
		ut_Message("BIN : "+[Bridge MHD NBIS:1]BIN:3+" - Item 75 not calculated !!!"+<>sCR+<>sLF)
		bItm75Errors:=True:C214
		[Bridge MHD NBIS:1]Item75A:152:="  "
		[Bridge MHD NBIS:1]Item75B:153:=" "
		[Bridge MHD NBIS:1]Item76:154:=0
		[Bridge MHD NBIS:1]Item94:155:=0
		[Bridge MHD NBIS:1]Item95:156:=0
		[Bridge MHD NBIS:1]Item96:157:=0
		[Bridge MHD NBIS:1]Item97:158:=0
	End if 
	SEND PACKET:C103(ITEM75Report_F; ($ExportLine_txt+<>sCR))
End if   // For if bridge was worked on within last 9 years, Item75 remains blank