//%attributes = {"invisible":true}
// Method: SIA_AASHTO_SuffRat
// Description
// 
// Parameters
// $0 : $SR
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/05/11, 17:15:22
	// ----------------------------------------------------
	
	Mods_2011_10
	// Modified by: Costas Manousakis-(Designer)-(3/29/16 12:18:22)
	Mods_2016_03_bug
	//  `added item 63 to the call for SET_Item70
End if 

C_LONGINT:C283($LowestRatng; $Lanes; $n)  //Command Replaced was o_C_INTEGER
C_REAL:C285($0)
C_REAL:C285($A; $B; $C; $D; $E; $F; $G; $H; $I; $J; $K; $X; $Y; $GnH)
C_REAL:C285($S1; $S2; $S3; $S4; $SR)
C_REAL:C285($Width)
C_TEXT:C284($Type)  // Command Replaced was o_C_STRING length was 2

[BridgeMHDNBISArchive:139]Item67:141:=SIA_SET_Item67([BridgeMHDNBISArchive:139]Item66:138; [BridgeMHDNBISArchive:139]Item29:87; [BridgeMHDNBISArchive:139]Item26:119; [BridgeMHDNBISArchive:139]Item41:140; [BridgeMHDNBISArchive:139]Item75A:151; [BridgeMHDNBISArchive:139]Item43:74; [BridgeMHDNBISArchive:139]Item62:133; [BridgeMHDNBISArchive:139]Item59:130; [BridgeMHDNBISArchive:139]Item60:131)
[BridgeMHDNBISArchive:139]Item68:142:=SIA_SET_Item68([BridgeMHDNBISArchive:139]Item5:58; [BridgeMHDNBISArchive:139]Item26:119; [BridgeMHDNBISArchive:139]Item28A:85; [BridgeMHDNBISArchive:139]Item29:87; [BridgeMHDNBISArchive:139]Item41:140; [BridgeMHDNBISArchive:139]Item49:92; [BridgeMHDNBISArchive:139]Item51:95; [BridgeMHDNBISArchive:139]Item53:104; [BridgeMHDNBISArchive:139]Item75A:151; [BridgeMHDNBISArchive:139]Item102:122)
[BridgeMHDNBISArchive:139]Item69:143:=SIA_SET_Item69([BridgeMHDNBISArchive:139]Item42:84; [BridgeMHDNBISArchive:139]Item54A:106; [BridgeMHDNBISArchive:139]Item55A:109; [BridgeMHDNBISArchive:139]Item41:140; [BridgeMHDNBISArchive:139]Item75A:151; [BridgeMHDNBISArchive:139]BIN:3; [BridgeMHDNBISArchive:139]Item54B:107; [BridgeMHDNBISArchive:139]Item55B:110; [BridgeMHDNBISArchive:139]Item56:111; [BridgeMHDNBISArchive:139]ArchiveReason_s:223; [BridgeMHDNBISArchive:139]ArchiveDate_d:224)
If ([BridgeMHDNBISArchive:139]Item103:123=False:C215)
	[BridgeMHDNBISArchive:139]Item70:139:=SET_Item70([BridgeMHDNBISArchive:139]Item64:136; [BridgeMHDNBISArchive:139]Item 63:196)
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

$0:=Round:C94($SR; 1)