scan 0x8ABC93F8 %x inputValue

scan 0x0000FF00 %x maskFirstParam 
set firstParam [format %X [expr {($inputValue & $maskFirstParam) >> 8}]]
puts "First parameter: $firstParam"

scan 0x00000040 %x maskSecondParam
set secondParam [format %X [expr { ((($inputValue ^ $maskSecondParam) & $maskSecondParam) >> 6) }]]
puts "Second parameter: $secondParam"

scan 0x00010000 %x maskBit17
scan 0x00020000 %x maskBit18
scan 0x00040000 %x maskBit19
scan 0x00080000 %x maskBit20

set thirdParam 0
set thirdParam [expr { (($inputValue & $maskBit20) >> 3) | $thirdParam }]
set thirdParam [expr { (($inputValue & $maskBit19) >> 1) | $thirdParam }]
set thirdParam [expr { (($inputValue & $maskBit18) << 1) | $thirdParam }]
set thirdParam [expr { (($inputValue & $maskBit17) << 3) | $thirdParam }]
set thirdParam [format %X [expr { $thirdParam >> 16 }]]
puts "Third parameter: $thirdParam"


