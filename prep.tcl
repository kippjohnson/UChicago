# A convenient script that will prepare the files needed for NAMD minimization
# from an input PDB file
# Kipp, kippjohnson@uchicago.edu
# To run, type "source prep.tcl" in the Tk console

# Set value in quotations below to
# 4 letter PDB code for protein
set pname "2LMN-40-bhcl"

# Run autopsf
set autopsfname "-autopsf"
autopsf -mol 0 -prefix $pname$autopsfname

# Run solvate
# This will put the protein in a box w/ 10A buffering
set solvatename "-solvate"
solvate $pname$autopsfname.psf $pname$autopsfname.pdb -o $pname$solvatename -x 10 -y 10 -z 10 +x 10 +y 10 +z 10 -rotate -rotsel all -rotinc 180

# Run autoionize
# NaCl content = 0.15 mol/L by default
set ionizename "-ionized"
autoionize -psf $pname$solvatename.psf -pdb $pname$solvatename.pdb -sc 0.01 -o $pname$solvatename$ionizename

# Center molecule in box
set centername "-center"
set sel [atomselect top all]
set sel0 [measure center $sel]
set centerx [lindex $sel0 0]
	set nx [expr {- $centerx}]
set centery [lindex $sel0 1]
	set ny [expr {- $centery}]
set centerz [lindex $sel0 2]
	set nz [expr {- $centerz}]

        # Take a look at the original center
	set allthree "$nx $ny $nz"
	puts $allthree
	
$sel moveby "$nx $ny $nz"

# Write/add to VMD center.pdb & center.psf
$sel writepsf $pname$solvatename$ionizename$centername.psf
$sel writepdb $pname$solvatename$ionizename$centername.pdb

mol new $pname$solvatename$ionizename$centername.psf
mol addfile $pname$solvatename$ionizename$centername.pdb

# Restrain the backbone
set sel [atomselect top "name C CA N"]
$sel set beta 10
set sel [atomselect top all]
$sel writepdb $pname$solvatename$ionizename$centername-restrain.pdb

# Measure for PBC
puts "Values for PBC: "
set sel [atomselect top all]
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

puts "X value: $totx\nY value: $toty\nZ value: $totz"

