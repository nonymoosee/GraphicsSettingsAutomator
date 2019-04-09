
	;GoToSettings
	WinMinimizeAll ( )

	MouseClick("Right", 1, 1, 1, 0) ; Right Click On Desktop
	Sleep(1000)
	Local $coordinates = SearchForClick($DisplaySettings, 1) ;Click On Desktop
	ConsoleWrite(@CRLF & $coordinates & @CRLF)
	WinWait("Settings")
	Sleep(1000)
	Local $coordinates = SearchForClick($GraphicsSettings, 1) ;Click On Graphics Settings
	ConsoleWrite(@CRLF & $coordinates & @CRLF)
	Sleep(1000)