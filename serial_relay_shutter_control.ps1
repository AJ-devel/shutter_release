param(
        [Parameter()]
        [int]$com_port_number,

        [Parameter()]
        [int]$baud_rate,

        [Parameter()]
        [int]$exposure_time_seconds,

        [Parameter()]
        [int]$number_of_pictures
)



function Open-Shutter {
    param(
        [Parameter()]
        [System.IO.Ports.SerialPort] $port,

        [Parameter()]
        [Byte[]] $open_relay_hex
    )

    $port.open()
    $port.Write($open_relay_hex, 0, $open_relay_hex.Count)

    Write-Host "Shutter open"
    }


function Close-Shutter {
    param(
        [Parameter()]
        [System.IO.Ports.SerialPort] $port,

        [Parameter()]
        [Byte[]] $close_relay_hex
    )

    $port.open()
    $port.Write($close_relay_hex, 0, $close_relay_hex.Count)

    Write-Host "Shutter closed"
    }


$port = New-Object System.IO.Ports.SerialPort("COM$com_port_number", $baud_rate, "None", 8, "One")

# Values for E-3 USB Serial Relay CH340 - This may differ if using a different relay model
[Byte[]] $open_relay_hex = 0xA0,0x01,0x01,0xA2
[Byte[]] $close_relay_hex = 0xA0,0x01,0x00,0xA1


try {
        $i = 0

        While ($number_of_pictures -gt 0)
        {
            $number_of_pictures--

            Open-Shutter $port $open_relay_hex
            Start-Sleep $exposure_time_seconds

            Close-Shutter $port $close_relay_hex

            if ($number_of_pictures -gt 0) {
                Start-Sleep 10
            }

            $i++

        }

        Write-Host "Pictures taken: $i"
        Write-Host "Exposure time minutes: $($i * $exposure_time_seconds / 60)"
}

finally {
    # Always close shutter
    $port = New-Object System.IO.Ports.SerialPort("COM$com_port_number", $baud_rate, "None", 8, "One")
    Close-Shutter $port $close_relay_hex
    $port.close()
}
