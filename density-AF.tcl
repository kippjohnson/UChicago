# Kipp Johnson
# 26 Jan 2014
#
# Measures the water density of a PDB system
# Usage: source density.tcl
# Outputs calculations to screen
#
# Can easily measure other densities with modification
# of atom selection and atom weight
#
#

set filename "density-output.tsv"

set file [open $filename w]

set mol top
set num_steps [molinfo $mol get numframes] 

set sel [atomselect top "name OH2 and -25<x and 25>x and -25<y and 25>y and -25<z and 25>z"]

puts $file "Frame \t Density"

for {set i 0} {$i < $num_steps} {incr i} { 

$sel frame $i
$sel update
	
# Get number of water molecules
set molnum [expr [ $sel num]] 
set avogadro [expr 6.02 * pow(10,23)]
set moles [expr $molnum * 1/$avogadro]

# Get mass of H2O
set molmass [expr $moles * 18.0]

# Measure Box Size
set sel0 [measure minmax $sel]

set lowest [lindex $sel0 0]
set highest [lindex $sel0 1]

set negx [expr { abs([string trim [lindex [split [list $lowest] ] 0 ] \{]) }]
set negy [expr { abs([lindex [split [list $lowest] ] 1 ]) }]
set negz [expr { abs([string trim [lindex [split [list $lowest] ] 2 ] \}]) }]

set posx [expr { abs([string trim [lindex [split [list $highest] ] 0 ] \{]) }]
set posy [expr { abs([lindex [split [list $highest] ] 1 ]) }]
set posz [expr { abs([string trim [lindex [split [list $highest] ] 2 ] \}]) }]

set totx [expr {$negx + $posx}]
set toty [expr {$negy + $posy}]
set totz [expr {$negz + $posz}]
 
# Compute Volume
set volumeA3 [expr $totx * $toty * $totz]

set conversion [expr 1.0 * pow(10,24) ]

set volumeC3 [expr $volumeA3 * 1/$conversion]

# Calculate and Print Density

set density [expr $molmass / $volumeC3]

#puts "Num. Water: $molnum"
#puts "Water Mass (g): $molmass"
#puts "Box Dimensions (A): $totx $toty $totz"
#puts "Volume (A^3): $volumeA3"
#puts "Volume (cm^3): $volumeC3"
#puts "------------------------"
#puts "Density: $density g/cm^3"
#puts "------------------------"

puts $file "$i \t $density" 

}

puts "Calculation complete! Values output to $filename"
   