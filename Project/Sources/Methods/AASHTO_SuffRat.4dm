//%attributes = {"invisible":true}
//GP AASHTO_SuffRat
//Calculate and return the AASHTO Sufficiency Rating for the current bridge.
If (False:C215)
	//Written by Thomas D. Nee
	
	// Modified 
	//     1-dec-1999 per memo from CSC dated 22-jun-1999
	
	//Modified in Aug and Sept 2000 to match the code from the
	// FHWA's Edit/Update program
	//Modified 3/21/01 by RLV
	//       Round Item51 before using the value in any comparisons
	//      Truncate Item66 before making any comparisons
	
	// Modified by: Costas Manousakis-(Designer)-(3/1/17 15:30:24)
	Mods_2017_03
	//  `use ◊SIA_LoadRtg_63_RF_txt to decide if  InvRating is rating factor or MT
End if 

C_LONGINT:C283($LowestRatng; $Lanes; $n)  //Command Replaced was o_C_INTEGER
C_REAL:C285($0)
C_REAL:C285($A; $B; $C; $D; $E; $F; $G; $H; $I; $J; $K; $X; $Y; $GnH)
C_REAL:C285($S1; $S2; $S3; $S4; $SR)
C_REAL:C285($Width)
C_TEXT:C284($Type)  // Command Replaced was o_C_STRING length was 2

[Bridge MHD NBIS:1]Item67:142:=SET_Item67
[Bridge MHD NBIS:1]Item68:143:=SET_Item68
[Bridge MHD NBIS:1]Item69:144:=SET_Item69
If ([Bridge MHD NBIS:1]Item103:124=False:C215)
	[Bridge MHD NBIS:1]Item70:140:=SET_Item70
End if 

If (False:C215)
	//*** S1 Structural Adequacy and Safety (55% maximum).
	
	//Item 59 Superstructure
	//Item 60 Substructure
	//Note:  Function Num will convert a "?" to zero.
End if 

Case of 
	: (([Bridge MHD NBIS:1]Item59:131="N") | ([Bridge MHD NBIS:1]Item59:131="?"))
		If (([Bridge MHD NBIS:1]Item60:132="N") | ([Bridge MHD NBIS:1]Item60:132="?"))
			//Superstructure and Substructure blank, use Culvert Rating.
			
			//09-07-2000 changes
			// There are five bridges where item 59,60 and 62 are N, 
			// In these cases setting LowestRating=100 instead of taking a
			// num(N) which will give a value of zero
			If ([Bridge MHD NBIS:1]Item62:134#"N")
				$LowestRatng:=Num:C11([Bridge MHD NBIS:1]Item62:134)
			Else 
				$LowestRatng:=100
			End if 
			//End of changes 09-07-2000
			
		Else 
			//Superstructure blank, use Substructure Rating.       
			$LowestRatng:=Num:C11([Bridge MHD NBIS:1]Item60:132)
		End if 
	: (([Bridge MHD NBIS:1]Item60:132="N") | ([Bridge MHD NBIS:1]Item60:132="?"))
		//Substructure blank, use Superstructure Rating.       
		$LowestRatng:=Num:C11([Bridge MHD NBIS:1]Item59:131)
	Else 
		//Use the lowest rating of the two.    
		$LowestRatng:=MinNum(Num:C11([Bridge MHD NBIS:1]Item59:131); Num:C11([Bridge MHD NBIS:1]Item60:132))
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
C_REAL:C285($InvRtg_r)

If (Position:C15([Bridge MHD NBIS:1]Item 65:200; <>SIA_LoadRtg_63_RF_txt)>0)
	$InvRtg_r:=[Bridge MHD NBIS:1]Item66:139*32.4  // if rating factor use factor * 32.4
Else 
	$InvRtg_r:=[Bridge MHD NBIS:1]Item66:139
End if 

If ($InvRtg_r>=32.4)
	$B:=0
Else 
	//3/21/01: Truncating Item66
	//$B:=((32.4-[Bridge MHD NBIS]Item66)^1.5)*0.3254
	$B:=((32.4-Trunc:C95($InvRtg_r; 1))^1.5)*0.3254
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
	: ([Bridge MHD NBIS:1]Item58:130="N")
		$A:=0
	: (Num:C11([Bridge MHD NBIS:1]Item58:130)<=3)
		$A:=5
	: (Num:C11([Bridge MHD NBIS:1]Item58:130)=4)
		$A:=3
	: (Num:C11([Bridge MHD NBIS:1]Item58:130)=5)
		$A:=1
	Else 
		$A:=0
End case 

//Structural Evaluation.
Case of 
	: ([Bridge MHD NBIS:1]Item67:142="N")
		$B:=0
	: (Num:C11([Bridge MHD NBIS:1]Item67:142)<=3)
		$B:=4
	: (Num:C11([Bridge MHD NBIS:1]Item67:142)=4)
		$B:=2
	: (Num:C11([Bridge MHD NBIS:1]Item67:142)=5)
		$B:=1
	Else 
		$B:=0
End case 

//Deck Geometry.
Case of 
	: ([Bridge MHD NBIS:1]Item68:143="N")
		$C:=0
	: (Num:C11([Bridge MHD NBIS:1]Item68:143)<=3)
		$C:=4
	: (Num:C11([Bridge MHD NBIS:1]Item68:143)=4)
		$C:=2
	: (Num:C11([Bridge MHD NBIS:1]Item68:143)=5)
		$C:=1
	Else 
		$C:=0
End case 

//Underclearances.
Case of 
	: ([Bridge MHD NBIS:1]Item69:144="N")
		$D:=0
	: (Num:C11([Bridge MHD NBIS:1]Item69:144)<=3)
		$D:=4
	: (Num:C11([Bridge MHD NBIS:1]Item69:144)=4)
		$D:=2
	: (Num:C11([Bridge MHD NBIS:1]Item69:144)=5)
		$D:=1
	Else 
		$D:=0
End case 

//Waterway Adequacy.
Case of 
	: ([Bridge MHD NBIS:1]Item71:145="N")
		$E:=0
	: (Num:C11([Bridge MHD NBIS:1]Item71:145)<=3)
		$E:=4
	: (Num:C11([Bridge MHD NBIS:1]Item71:145)=4)
		$E:=2
	: (Num:C11([Bridge MHD NBIS:1]Item71:145)=5)
		$E:=1
	Else 
		$E:=0
End case 

//Approach Road Alignment.
Case of 
	: ([Bridge MHD NBIS:1]Item72:146="N")
		$F:=0
	: (Num:C11([Bridge MHD NBIS:1]Item72:146)<=3)
		$F:=4
	: (Num:C11([Bridge MHD NBIS:1]Item72:146)=4)
		$F:=2
	: (Num:C11([Bridge MHD NBIS:1]Item72:146)=5)
		$F:=1
	Else 
		$F:=0
End case 

$J:=$A+$B+$C+$D+$E+$F
$J:=MaxNum(0; $J)
$J:=MinNum(13; $J)


//*** S2.b  Width of Roadway Insufficiency (15% maximum).
//3/21/01 change, adding rounding to item51
//$Width:=[Bridge MHD NBIS]Item51
$Width:=Round:C94([Bridge MHD NBIS:1]Item51:96; 1)
//3/21/01 end of change
// *** change #2 memo 5-27-1999 
//If ($Width<=0)
//    `Bridge width is invalid, try Approach Roadway Width.  
//  $Width:=[Bridge MHD NBIS]Item32
//End if 
// *** end of chg 2
If ($Width<=0)
	//Width is still invalid, use a default value.  
	$Width:=10.9
End if 

$Lanes:=[Bridge MHD NBIS:1]Item28A:86
If ($Lanes<1)
	//Set a valid number of lanes.  
	$Lanes:=MaxNum(1; Round:C94($Width/3.66; 0))
End if 

$X:=[Bridge MHD NBIS:1]Item29:88/$Lanes  //ADT/lane
$Y:=$Width/$Lanes

//Change on 8/29/00: Edit/Update rounds $X and $Y to 1 decimal point
$X:=Round:C94($X; 1)
$Y:=Round:C94($Y; 1)
// End of change 8/29/00


//Approach Roadway Width for non-Culverts.
If (False:C215)
	// *** Change #3  memo 5-27-1999    
	//  : ((Substring([Bridge MHD NBIS]Item43;2;2)="19") & (([Bridge MHD NBIS]Item51+0
	
	//Change 09-07-2000
	// changing(([Bridge MHD NBIS]Item51+0.6)=Round(([Bridge MHD NBIS]Item51+0.6);1))
	//because the computer processor does not give an absolute value for a real number
	//  If rounding is not used and if item51+0.6=item32, it considers the second half
	//of the case statement below to be true, leading to an error.
	
	//   : ((Substring([Bridge MHD NBIS]Item43;2;2)#"19") & (([Bridge MHD NBIS]Item51+
End if 
Case of 
		
	: ((Substring:C12([Bridge MHD NBIS:1]Item43:75; 2; 2)#"19") & (Round:C94(([Bridge MHD NBIS:1]Item51:96+0.6); 1)<[Bridge MHD NBIS:1]Item32:98))
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
If (Num:C11([Bridge MHD NBIS:1]Item100:121)=0)
	//Non-defense.  
	If ([Bridge MHD NBIS:1]Item53:105<4.26)
		$I:=2
	Else 
		$I:=0
	End if 
Else 
	//Defense.
	If ([Bridge MHD NBIS:1]Item53:105<4.87)
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

$A:=15*[Bridge MHD NBIS:1]Item29:88*[Bridge MHD NBIS:1]Item19:91/(320000*$K)


//Change on 8/29/00: Edit/Update rounds $A to 9 decimal point
$A:=Round:C94($A; 9)
// End of change 8/29/00
$A:=MaxNum(0; $A)
$A:=MinNum(15; $A)

If (Num:C11([Bridge MHD NBIS:1]Item100:121)=0)
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
	
	$A:=([Bridge MHD NBIS:1]Item19:91^4)*7.9*(10^(-9))
	
	
	//Change on 8/29/00: Edit/Update rounds $A to 9 decimal point
	$A:=Round:C94($A; 9)
	// End of change 8/29/00
	$A:=MaxNum(0; $A)
	$A:=MinNum(5; $A)
	
	//*** S4.b  Structure Type Reduction (5% maximum).
	$Type:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 2; 2)
	If (($Type="10") | ($Type="12") | ($Type="13") | ($Type="14") | ($Type="15") | ($Type="16") | ($Type="17"))
		$B:=5
	Else 
		$B:=0
	End if 
	
	//*** S4.c  Traffic Safety Features Reduction (3% maximum).
	$n:=0
	If ([Bridge MHD NBIS:1]Item36A:147="0")
		$n:=$n+1
	End if 
	If ([Bridge MHD NBIS:1]Item36B:148="0")
		$n:=$n+1
	End if 
	If ([Bridge MHD NBIS:1]Item36C:149="0")
		$n:=$n+1
	End if 
	If ([Bridge MHD NBIS:1]Item36D:150="0")
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

$0:=Round:C94($SR; 1)