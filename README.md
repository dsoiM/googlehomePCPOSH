# Google Home PC control with PowerShell
Control your Windows 10 PC with Google Home (and assistant) using IFTTT and PushBullet - with PowerShell

Only Windows 10 supported!


Instructions:

1. Setup your Google Home to work as usual
2. Register to PushBullet.com
3. Get PushBullet token from https://www.pushbullet.com/#settings
4. Register to IFTTT.com
5. Add your Google Home assitant to IFTTT (google for instructions if unsure)
6. Create new IFTTT applet
  * This = Google assistant, set your own settings for your command
  * That = PushBullet push a Note
  * Title = PSScript
  * Message = Your executed powershell script as-is. 
    1. If you want to execute executable, you can use following syntax:**&"C:\Program Files (x86)\foobar2000\foobar2000.exe" /stop**
    4. Or test easily with: **Write-Warning "Test PowerShell"**
    3. Otherwise create your own scriptlet, it will execute it
7. Set the PushBullet token in the script on first line
8. Run the PowerShell script (If it won't run by default, type first: Set-ExecutionPolicy -ExecutionPolicy Unrestricted )
9. Talk to your google box with what your defined in 6 "This"
