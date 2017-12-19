# Google Home PC POSH
Control your Windows 10 PC with Google Home (and assistant) using IFTTT and PushBullet - with powershell


Instructions:

1. Setup your Google Home to work as usual
2. Register to PushBullet.com
3. Get PushBullet token from https://www.pushbullet.com/#settings
4. Register to IFTTT.com
5. Add your Google Home assitant to IFTTT (google for instructions if unsure)
6. Create new IFTT applet
  a) This = Google assistant, set your own settings for your command
  b) That = PushBullet push a Note
     1. Title = PSScript
     2. Message = Your executed powershell script as-is. 
        If you want to execute executable, you can use following syntax:
         &"C:\Program Files (x86)\foobar2000\foobar2000.exe" /stop
         Otherwise create your own scriptlet, it will execute it without restrictions with the command
7. Set the PushBullet token in the script on first line
8. Run the PowerShell script (If it won't run by default, type first: Set-ExecutionPolicy -ExecutionPolicy Unrestricted )
9. Talk to your google box with what your defined in 6a
