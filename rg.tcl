set mol [molinfo top] 
set out [open rg-out.dat w] 
set sel [atomselect top "protein"] 
set frames [molinfo $mol get numframes]
puts "Frames: $frames"

for {set i 0} {$i < $frames} {incr i} { 
    $sel frame $i 
    puts $out "$i [measure rgyr $sel]" 
} 