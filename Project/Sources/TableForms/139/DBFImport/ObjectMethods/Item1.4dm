If (False:C215)
	// created by: costasmanousakis-(Designer)-(2/11/11 15:48:25)
	Mods_2011_02
	
End if 

C_DATE:C307(MHDARCHIVEDATE_D)
C_TEXT:C284(MHDARCHIVEREASON_TXT)

[BridgeMHDNBISArchive:139]ArchiveReason_s:223:=MHDARCHIVEREASON_TXT
[BridgeMHDNBISArchive:139]ArchiveDate_d:224:=MHDARCHIVEDATE_D
[BridgeMHDNBISArchive:139]Item8 BridgeCat:204:=Substring:C12([BridgeMHDNBISArchive:139]Item8:203; 13)
[BridgeMHDNBISArchive:139]Item8 Owner:205:=Substring:C12([BridgeMHDNBISArchive:139]Item8:203; 10; 3)
C_TEXT:C284($BD3_txt)
C_LONGINT:C283($K_L)
$BD3_txt:=Substring:C12([BridgeMHDNBISArchive:139]Item8:203; 1; 3)
$K_L:=Find in array:C230(<>aBDEPT; $BD3_txt)
Case of 
	: (MHDARCHIVEDATE_D<Date:C102("7/1/2010"))
		If ($K_L>0)
			If (<>aOldDist3{$K_L}="")
				[BridgeMHDNBISArchive:139]Item2:59:=<>aDistrict{$K_L}
			Else 
				[BridgeMHDNBISArchive:139]Item2:59:=<>aOldDist3{$K_L}
			End if 
		Else 
			[BridgeMHDNBISArchive:139]Item2:59:="  "
		End if 
	Else 
		[BridgeMHDNBISArchive:139]Item2:59:=<>aDistrict{$K_L}
		
End case 
