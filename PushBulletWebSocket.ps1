#Set here you access token from Pushbullet https://www.pushbullet.com/#settings "Create access token"
$token = "TOKEN_HERE"

#Set this to "Continue" to get more verbose logs
$verbosepreference = "SilentlyContinue"


Function WaitFor-SocketMessages {
    
    
    #Web API call starts the session and gets a websocket URL to use.
    $url = "wss://stream.pushbullet.com/websocket/$token"

    Try{
        Do{
            $WS = New-Object System.Net.WebSockets.ClientWebSocket                                                
            $CT = New-Object System.Threading.CancellationToken                                                   

            $Conn = $WS.ConnectAsync($url, $CT)                                                  
            While (!$Conn.IsCompleted) { 
                
                Start-Sleep -Milliseconds 100 
            
            }

           write-verbose "Connected to $($url)" 

            $Size = 1024
            $Array = [byte[]] @(,0) * $Size
            $Recv = New-Object System.ArraySegment[byte] -ArgumentList @(,$Array)
            
            While ($WS.State -eq 'Open') {

                $RTM = ""
                Do {
                    $Conn = $WS.ReceiveAsync($Recv, $CT)
                    While (!$Conn.IsCompleted) { 
                    
                        Start-Sleep -Milliseconds 100 }

                    $Recv.Array[0..($Conn.Result.Count - 1)] | ForEach-Object { $RTM = $RTM + [char]$_ }


                } Until ($Conn.Result.Count -lt $Size)

                write-verbose "Response: $RTM" 

                If ($RTM){
                    
                    try {
                     handleMessage (ConvertFrom-Json $RTM)
                    } catch {
                     write-error "Unable to handle message $_"
                    }

                }
            }   
        } Until (!$Conn)

    }Finally{

        If ($WS) { 
            Write-Verbose "Closing websocket"
            $WS.Dispose()
        }

    }

}

function HandleMessage ($msg) {
    switch ($msg) {
        { $_.type -eq "nop"} {write-verbose "ping-pong"}

        { $_.type -eq "tickle" -and $_.subtype -eq "push"} {
          $lastPush = ""
          $lastPush = ((Invoke-WebRequest -Uri "https://api.pushbullet.com/v2/pushes?active=true" -Headers @{'Access-Token' = $token} -Method Get).Content | ConvertFrom-Json).pushes[0]  
          if ($lastPush.title -eq "PSScript") {
              $lastPushID = $lastPush.iden
              $command = $lastPush.body
          
              $deleteresp = Invoke-WebRequest -Uri "https://api.pushbullet.com/v2/pushes/$lastPushID" -Headers @{'Access-Token' = $token} -Method Delete
              Write-Warning "Executing: $command"
              Invoke-Expression $command
           }
        }
    }


}


WaitFor-SocketMessages
