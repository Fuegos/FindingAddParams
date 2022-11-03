# Input value. Example 0x5FABFF01
set inputValue 0xD8067FCE

proc printParamHex {nameParam valueParam} {
    puts "$nameParam parameter: [format %X $valueParam]"
}

proc convertHexToDec {hexValue} {
    scan $hexValue %x decValue
    return $decValue
}

proc getBitMask {numBit} {
    return [expr {1 << ($numBit - 1)}]
}

proc getBitsMask {startPoint endPoint} {
    set mask 0
    for {set i $startPoint} {$i <= $endPoint} {incr i} {
        set mask [expr {$mask | [getBitMask $i]}]
    }
    return $mask
}

proc reverseOrderBits {decValue startPoint endPoint} {
    set newValue 0
    for {set i 0} {$i < [expr {(abs($startPoint - $endPoint) + 1) / 2}]} {incr i} {
        set curStartPoint [expr {$startPoint + $i}]
        set curEndPoint [expr {$endPoint - $i}]
        set distBetweenStartAndEnd [expr {abs($curStartPoint - $curEndPoint)}]
        set newValue [expr {
            (($decValue & [getBitMask $curStartPoint]) << $distBetweenStartAndEnd) | $newValue
        }]
        set newValue [expr {
            (($decValue & [getBitMask $curEndPoint]) >> $distBetweenStartAndEnd) | $newValue
        }]
    }
    return [expr {
        ((~[getBitsMask $startPoint $endPoint]) & $decValue) | $newValue
    }]  
}

proc flipBit {decValue numBit} {
    set mask [getBitMask $numBit]
    return [expr {
        ($decValue ^ $mask) & $mask
    }]
}

proc extractBits {decValue startPoint endPoint} {
    return [expr {
        ($decValue & [getBitsMask $startPoint $endPoint]) >> ($startPoint - 1)
    }]
}

# Start process
set inputValueDec [convertHexToDec $inputValue]

set firstParam [extractBits $inputValueDec 9 16]
printParamHex "First" $firstParam

set secondParam [flipBit $inputValueDec 7]
set secondParam [extractBits $secondParam 7 7]
printParamHex "Second" $secondParam

set thirdParam [reverseOrderBits $inputValueDec 17 20]
set thirdParam [extractBits $thirdParam 17 20]
printParamHex "Third" $thirdParam
