//%attributes = {"invisible":true}
//If (False)
//If (False)
//  `Temp_setItem8
//  `
//  `Method to initialize Item 8 values from Brkey
//
//  ` To be run once only.
//Mods_2005_CM05 
//
//End if 
//
//C_LONGINT($i;$Recs;$total;$Interval)
//C_STRING(15;$Item8)
//C_STRING(3;$Item8Bridgecat;$Item8Owner;$brkeyA)
//C_BOOLEAN($NBI)
//C_STRING(2;$Item22)
//If (Current user="Designer")
//  `Do all Records in  master table
//
//ALL RECORDS([Bridge MHD NBIS])
//
//$Recs:=Records in selection([Bridge MHD NBIS])
//$total:=$Recs
//
//CONFIRM("Generate Item 8 coding for "+String($Recs;"##,##0")+" records ?")
//If (ok=1)
//
//◊ProgressPID:=StartProgress ("Item8Ini";"None";"Initializing Item 8 Fields")
//$Interval:=MaxNum (MinNum (Int($Recs/40);20);2)  ` get an update interval between 2 and 20
//
//FIRST RECORD([Bridge MHD NBIS])
//For ($i;1;$Recs)
//$NBI:=[Bridge MHD NBIS]FHWARecord
//$brkeyA:=Substring([Bridge MHD NBIS]Bridge Key;1;3)
//$Item22:=[Bridge MHD NBIS]Item22
//
//If ($NBI)
//
//  ` ******* Do NBI Bridge *******
//  ` Get Owner
//$item8Owner:=Temp_Brkey2Owner ($brkeyA)
//  `get type
//If ($brkeyA="900")
//$item8bridgecat:="634"
//Else 
//$item8bridgecat:="NBI"
//End if 
//
//Else 
//
//  ` ******* Non-NBI ********     
//  ` get  Owner
//$item8owner:=Temp_Brkey2Owner ($brkeyA)
//If ($item8Owner="")
//  ` did not find anything from bridge key - try Item 22
//$item8Owner:=Temp_Item22_Owner ($item22)
//If ($item8Owner="")
//  ` still nothing, try J char of bridge key only for BRU CUL PED or BLD records
//If (($brkeyA="PED") | ($brkeyA="BLD") | ($brkeyA="BRI") | ($brkeyA="CUL"))
//$item8owner:=Temp_BrkeyJ2Owner (Substring([Bridge MHD NBIS]Bridge Key;7;1))
//End if 
//End if 
//End if 
//
//  ` get Bridge category
//$item8Bridgecat:=Temp_Brkey2Type ($brkeya)
//If ($item8bridgecat="")
//  ` try using bridge length Item 48
//C_REAL($brlength)
//$brlength:=[Bridge MHD NBIS]Item48
//If ($brlength>0)
//Case of 
//: ($brlength<2.4384)
//$item8bridgecat:="CUL"
//: (($brlength>=2.4384) & ($brlength<6.096))
//$item8bridgecat:="BRI"
//: ($brlength>=6.096)
//$item8bridgecat:="NBI"
//If ([Bridge MHD NBIS]Item41="K")
//$item8bridgecat:="CLO"
//End if 
//End case 
//End if 
//End if 
//
//End if 
//
//If ($item8owner="")
//$item8owner:="XXX"
//End if 
//If ($item8bridgecat="")
//$item8bridgecat:="XXX"
//End if 
//
//$Item8:=[Bridge MHD NBIS]BDEPT+[Bridge MHD NBIS]BIN+$Item8Owner+$Item8Bridgecat
//[Bridge MHD NBIS]Item8:=$Item8
//[Bridge MHD NBIS]Item8 BridgeCat:=$Item8Bridgecat
//[Bridge MHD NBIS]Item8 Owner:=$Item8Owner
//
//SAVE RECORD([Bridge MHD NBIS])
//NEXT RECORD([Bridge MHD NBIS])
//If ($i%$Interval=0)
//UpdateProgress ($i;$Recs)
//End if 
//  ` check if we got aborted from the Progress Bar display...
//If (◊Abort=True)
//$total:=$i
//$i:=$Recs+1
//End if 
//
//End for 
//CALL PROCESS(◊ProgressPID)
//ALERT("Item 8 coding set for "+String($total;"##,##0")+" records!")
//End if 
//
//  ` Now do the secondary table
//ALL RECORDS([NBIS Secondary])
//
//$Recs:=Records in selection([NBIS Secondary])
//$total:=$Recs
//
//CONFIRM("Generate Item 8 coding for "+String($Recs;"##,##0")+" secondary records ?")
//If (ok=1)
//
//◊ProgressPID:=StartProgress ("Item8Ini";"None";"Initializing Item 8 Fields")
//FIRST RECORD([NBIS Secondary])
//For ($i;1;$Recs)
//  ` find Item 8 from primary record with same BIN
//RELATE ONE([NBIS Secondary]BIN)
//$Item8:=[Bridge MHD NBIS]Item8
//If ($item8="")
//$Item8:=[NBIS Secondary]BIN+[NBIS Secondary]Bridge Key
//End if 
//  `ALERT("Second BIN "+[NBIS Secondary]BIN+"  New Item 8 from primary : "+$Item8)
//[NBIS Secondary]Item8:=$Item8
//SAVE RECORD([NBIS Secondary])
//NEXT RECORD([NBIS Secondary])
//If ($i%10=0)
//UpdateProgress ($i;$Recs)
//End if 
//  ` check if we got aborted from the Progress Bar display...
//If (◊Abort=True)
//$total:=$i
//$i:=$Recs+1
//End if 
//
//End for 
//CALL PROCESS(◊ProgressPID)
//ALERT("Item 8 coding set for "+String($total;"##,##0")+" secondary records!")
//
//End if 
//
//End if 
//End if 
