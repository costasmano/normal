//%attributes = {"invisible":true}
//  `Temp_FixElmtLDRtgs
//  `Fix fields in table [ElementsSafety] Inv H20, Inv Type 3, Inv 3S2
//  `New coding is to allow 0 (zero) for value.
//  `Not Rated will be coded as -1
//  `So,... Search all Records in [ElementsSafety] and set zero values to -1
//  `To be run once before final release 4.0 of the BMS
//ALL RECORDS([ElementsSafety])
//C_LONGINT($numrecs;$i)
//$numrecs:=Records in selection([ElementsSafety])
//FIRST RECORD([ElementsSafety])
//◊ProgressPID:=StartProgress ("";"None";"Fixing Elmt Recs")
//$Interval:=MaxNum (MinNum (Int($numrecs/40);20);2)  ` get an update interval between 2 and 20
//UpdateProgress (1;$numrecs)  ` start the progress bar...
//For ($i;1;$numrecs)
//
//If ([ElementsSafety]Inv H20=0)
//[ElementsSafety]Inv H20:=-1
//End if 
//If ([ElementsSafety]Inv Type 3=0)
//[ElementsSafety]Inv Type 3:=-1
//End if 
//If ([ElementsSafety]Inv 3S2=0)
//[ElementsSafety]Inv 3S2:=-1
//End if 
//If (Modified record([ElementsSafety]))
//SAVE RECORD([ElementsSafety])
//End if 
//If ($i%$Interval=0)  `Don't slow down things just to display
//UpdateProgress ($i;$numrecs)
//FLUSH BUFFERS
//End if 
//
//NEXT RECORD([ElementsSafety])
//If (◊Abort)
//$i:=$numrecs+1
//End if 
//
//End for 
//CALL PROCESS(◊ProgressPID)