//[Dialogs];"TeamMember"
//Set up the two scrollable areas


Case of 
	: (Form event code:C388=On Load:K2:1)
		COPY ARRAY:C226(aInspTeamID; aTempTmID)
		COPY ARRAY:C226(aInspTeam; aTempTeam)
End case 