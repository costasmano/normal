//%attributes = {"invisible":true}
//procedure: M_NewRemoteBIN
//Copyright © 1998, Albert Leung, All Rights Reserved.

//Create a new BIN record on a remote machine

C_LONGINT:C283(vBIN_Dec)  //The decimal value of the BIN.
C_BOOLEAN:C305(OnServer)

OnServer:=True:C214
FORM SET INPUT:C55([Bridge MHD NBIS:1]; "BDEPT Input")
ADD RECORD:C56([Bridge MHD NBIS:1])
FORM SET INPUT:C55(pFile->; DefInLay)