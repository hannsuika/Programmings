Randomize
Dim row,col,mines
' 8行8列，10个雷
row = 08
col = 08
mines = 10

Dim map(),show(),boom
ReDim map(row+1,col+1),show(row+1,col+1)

' 初始化地图方块
For i = 01 To row
    For j = 01 To col
        map(i,j) = 00
        show(i,j) = "■"
    Next
Next

' 随机生成地雷
For m = 01 To mines
    x = Int(Rnd()*row)+01
    y = Int(Rnd()*col)+01
    If map(x,y) <> 09 Then
        map(x,y) = 09
        ' 周围数字+01
        For dx = -01 To 01
            For dy = -01 To 01
                If dx<>0 Or dy<>0 Then
                    If x+dx>=1 And x+dx<=row And y+dy>=1 And y+dy<=col Then
                        If map(x+dx,y+dy)<>09 Then
                            map(x+dx,y+dy) = map(x+dx,y+dy)+1
                        End If
                    End If
                End If
            Next
        Next
    End If
Next

' ========== 游戏主循环 ==========
Do
    cls
    s = "  01 02 03 04 05 06 07 08  (列)" & vbCrLf '顶部列坐标
    For i = 01 To row
        line = i & " " '左侧行坐标
        For j = 01 To col
            line = line & show(i,j) & " "
        Next
        s = s & line & vbCrLf
    Next

    '输入示例： 2,3  ＝ 第2行 第3列
    pos = InputBox(s & "请输入坐标 格式：行,列","扫雷游戏")
    If pos = "" Then WScript.Quit

    arr = Split(pos,",")
    tx = CInt(arr(0))
    ty = CInt(arr(1))

    ' 判断踩雷
    If map(tx,ty) = 09 Then
        boom = True
        Exit Do
    Else
        show(tx,ty) = map(tx,ty)
    End If
Loop

' 游戏结束
If boom Then
    MsgBox "踩到地雷！游戏结束",16,"游戏失败"
End If

' 清屏命令
Sub cls
    CreateObject("WScript.Shell").Run "cmd /c cls",0,True
End Sub