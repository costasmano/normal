//%attributes = {"invisible":true}
//  `GP TEMP_UpdPlaceCd
//
//  `This procedure was intended to be used once but could be
//  `used again if town, county, or census information ever changes.
//
//  `It updates each BIN's town name and NBIS location items
//  `with the data in the Town Data file.
//
//C_LONGINT($i;$j)
//C_TEXT($text;$file)
//C_TIME($dUpdateRpt)
//$dUpdateRpt:=Create document("")
//$text:="Town Location Update Report"+(2*◊sCR)
//SEND PACKET($dUpdateRpt;$text)
//
//  `First test a small group.
//  `TRACE
//  `SEARCH([Bridge MHD NBIS];[Bridge MHD NBIS]BDEPT="Q0100@")
//
//ALL RECORDS([Bridge MHD NBIS])
//SELECTION TO ARRAY([Bridge MHD NBIS]BIN;$aBIN;[Bridge MHD NBIS]BDEPT;$aBDEPT;[Bridge MHD NBIS]Town Name;$aBTowns)
//SELECTION TO ARRAY([Bridge MHD NBIS]Item2;$aBDistricts;[Bridge MHD NBIS]Item3;$aBCountys;[Bridge MHD NBIS]Item4;$aBPlaces)
//
//ALL RECORDS([Town Data])
//SELECTION TO ARRAY([Town Data]BDEPT Prefix;$aBDP;[Town Data]Town Name;$aTowns)
//SELECTION TO ARRAY([Town Data]District;$aDistricts;[Town Data]County Code;$aCountys;[Town Data]Place_Code;$aPlaces)
//
//$i:=1
//While ($i<=Size of array($aBIN))
//
//$j:=Find in array($aBDP;Substring($aBDEPT{$i};1;3))
//
//$text:=""
//If ($j>0)
//If ($aBTowns{$i}#$aTowns{$j})
//$text:=$text+◊sTab+$aBTowns{$i}+"≠"+$aTowns{$j}
//$aBTowns{$i}:=$aTowns{$j}
//End if 
//If ($aBDistricts{$i}#$aDistricts{$j})
//$text:=$text+◊sTab+$aBDistricts{$i}+"≠"+$aDistricts{$j}
//$aBDistricts{$i}:=$aDistricts{$j}
//End if 
//If ($aBCountys{$i}#$aCountys{$j})
//$text:=$text+◊sTab+$aBCountys{$i}+"≠"+$aCountys{$j}
//$aBCountys{$i}:=$aCountys{$j}
//End if 
//If ($aBPlaces{$i}#$aPlaces{$j})
//$text:=$text+◊sTab+$aBPlaces{$i}+"≠"+$aPlaces{$j}
//$aBPlaces{$i}:=$aPlaces{$j}
//End if 
//Else 
//$text:=$text+◊sTab+"***  Bad BDEPT!? ***"
//End if 
//If ($text#"")
//$text:=String($i)+◊sTab+$aBIN{$i}+◊sTab+$aBDEPT{$i}+$text+◊sCR
//SEND PACKET($dUpdateRpt;$text)
//End if 
//
//$i:=$i+1
//End while 
//
//ARRAY TO SELECTION($aBTowns;[Bridge MHD NBIS]Town Name;$aBDistricts;[Bridge MHD NBIS]Item2;$aBCountys;[Bridge MHD NBIS]Item3;$aBPlaces;[Bridge MHD NBIS]Item4)
//$j:=Records in set("LockedSet")
//If ($j>0)
//USE SET("LockedSet")
//$text:=◊sCR+String($j)+" Locked Records Not Updated"+◊sCR
//SEND PACKET($dUpdateRpt;$text)
//For ($i;1;$j)
//$text:=◊sTab+[Bridge MHD NBIS]BIN+◊sTab+[Bridge MHD NBIS]BDEPT+◊sCR
//SEND PACKET($dUpdateRpt;$text)
//NEXT RECORD([Bridge MHD NBIS])
//End for 
//End if 
//
//CLOSE DOCUMENT($dUpdateRpt)