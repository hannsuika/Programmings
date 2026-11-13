Dim voice, a

Set voice = CreateObject("SAPI.SpVoice")
a = InputBox("你想干什么？", "スイカ管家")

voice.Volume = 100

If a <> "" Then
	voice.Speak "小爱同学，"
	WScript.Sleep 500
	voice.Speak a
End If