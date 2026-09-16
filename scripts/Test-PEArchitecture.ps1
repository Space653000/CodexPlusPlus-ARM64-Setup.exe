param(
    [Parameter(Mandatory = $true)]
    [string[]]$Path
)

$ErrorActionPreference = 'Stop'

function Get-PeMachine {
    param([Parameter(Mandatory = $true)][string]$File)

    $bytes = [System.IO.File]::ReadAllBytes((Resolve-Path $File))
    if ($bytes.Length -lt 64 -or $bytes[0] -ne 0x4D -or $bytes[1] -ne 0x5A) {
        throw "$File is not a valid PE executable"
    }

    $peOffset = [BitConverter]::ToInt32($bytes, 0x3C)
    if ($peOffset -lt 0 -or ($peOffset + 6) -gt $bytes.Length) {
        throw "$File has an invalid PE header offset"
    }

    if ($bytes[$peOffset] -ne 0x50 -or $bytes[$peOffset + 1] -ne 0x45) {
        throw "$File has no PE signature"
    }

    $machine = [BitConverter]::ToUInt16($bytes, $peOffset + 4)
    switch ($machine) {
        0xAA64 { return 'ARM64' }
        0x8664 { return 'x64' }
        0x014C { return 'x86' }
        default { return ('0x{0:X4}' -f $machine) }
    }
}

$failed = $false
foreach ($file in $Path) {
    $machine = Get-PeMachine -File $file
    Write-Host "$file => $machine"
    if ($machine -ne 'ARM64') {
        Write-Error "Expected native ARM64 but got ${machine}: $file"
        $failed = $true
    }
}

if ($failed) {
    exit 1
}

Write-Host 'PE architecture verification passed: all payload executables are native ARM64.'
