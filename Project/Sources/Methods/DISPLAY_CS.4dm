//%attributes = {"invisible":true}
//GP DISPLAY_CS
//Copyright © 1996-97, Thomas D. Nee, All Rights Reserved.

//This procedure sets up the new (usually enterable) and old (not enterable)
//Condition State variables to be displayed on a layout.

C_POINTER:C301($pCS; $pOldCS)
C_LONGINT:C283($i)
For ($i; 1; vMaxCSs)
	$pCS:=a_ptr_CS{$i}  //Pointer to enterable object: Condition State i.
	$pOldCS:=a_ptr_OldCS{$i}  //Pointer to object:  Old Condition State i.
	
	If ([BMS Elements:47]Units:6="EA")
		OBJECT SET FORMAT:C236($pCS->; "#,###,##0;")
		OBJECT SET FILTER:C235($pCS->; "&9")
	Else 
		OBJECT SET FORMAT:C236($pCS->; "#,###,##0.0;")
		OBJECT SET FILTER:C235($pCS->; "|PosReals")
	End if 
	
	Case of 
		: (([Cond Units:45]Percent:6) & ([Cond Units:45]Total Quantity:5>0) & (aCS{$i}>=0))
			//The aCS array stores Quantities, convert to Percent of Total.
			$pCS->:=Round:C94(100*(aCS{$i}/[Cond Units:45]Total Quantity:5); 1)
			OBJECT SET FORMAT:C236($pCS->; "##0.0 %;")
			OBJECT SET FILTER:C235($pCS->; "|PosReals")
		: ([BMS Inspections:44]Metric:14 | (aCS{$i}<=0))
			//Display quantity.  This transfers a value of -1 (non-displayable),
			//even if the Total Quantity is zero.
			$pCS->:=Round:C94(aCS{$i}; 1)
		Else 
			$pCS->:=Round:C94(AnglicizeQ(aCS{$i}; [BMS Elements:47]Units:6); 1)
	End case 
	
	OBJECT SET FORMAT:C236($pOldCS->; "#,###,##0.0;")
	Case of 
		: (([Cond Units:45]Percent:6) & (vOldQm>0) & (aOldCS{$i}>=0))
			//The aOldCS array stores Quantities, convert to Percent of Total.
			$pOldCS->:=Round:C94(100*(aOldCS{$i}/vOldQm); 1)
			OBJECT SET FORMAT:C236($pOldCS->; "##0.0 %;")
		: ([BMS Inspections:44]Metric:14 | (aOldCS{$i}<=0))
			//Display quantity.  This transfers a value of -1 (non-displayable),
			//even if the Total Quantity is zero.
			$pOldCS->:=Round:C94(aOldCS{$i}; 1)
		Else 
			$pOldCS->:=Round:C94(AnglicizeQ(aOldCS{$i}; [BMS Elements:47]Units:6); 1)
	End case 
	
	If (aCS{$i}=-1)  //aCS{$i} is -1 if not enterable.
		OBJECT SET ENTERABLE:C238($pCS->; False:C215)
		OBJECT SET RGB COLORS:C628($pCS->; Col_paletteToRGB(Abs:C99(vDispColor)%256); Col_paletteToRGB(Abs:C99(vDispColor)\256))  // **Replaced o OBJECT SET COLOR($pCS->; vDispColor)
	Else 
		OBJECT SET ENTERABLE:C238($pCS->; True:C214)
		OBJECT SET RGB COLORS:C628($pCS->; Col_paletteToRGB(Abs:C99(vEntryColor)%256); Col_paletteToRGB(Abs:C99(vEntryColor)\256))  // **Replaced o OBJECT SET COLOR($pCS->; vEntryColor)
	End if 
	
End for 