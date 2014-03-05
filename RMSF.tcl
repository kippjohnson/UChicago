# Kipp <kippjohnson@uchicago.edu>
# for questions
#
# To run this file, from the TK console
# type "source RMSF.tcl" (without quotes)
# with a trajectory already loaded in VMD
#
# Script calculates RMSF of each 
# backbone CA in your molecule
#
# Set output name below (in quotes)
set outfile [open "2LMN-40-dE22-2.dat" w]
set sel [atomselect top all]
set sel0 [$sel num]
set sel [atomselect top "resid 1 to $sel0 and name CA"]

# Change the number below to change steps that are skipped 
# When calculating RMSF (suggest 5 or 10) {equiv. to "stride"}
set stepsize 10

set nframes [molinfo top get numframes]
set nframes2 [expr $nframes - 1]

# Comment out below line if you do not want a header in output
puts $outfile "Residue \t RMSF"

for {set i 0} {$i < [$sel num]} {incr i} { 
     set rmsf [measure rmsf $sel first 1 last $nframes2 step $stepsize] 
     puts $outfile "[expr {$i+1}] \t [lindex $rmsf $i]" 
} 

close $outfile

# output will be file with two tab-seperated columns
# first column = residue number
# second column = RMSF
#
# the following R code will produce a quick plot
# Just input data file location
#
# par = mfrow(1,1)
# rmsf = read.table("<rmsf.dat-file-location>",header=TRUE, sep="\t")
# plot(rmsf$V1, rmsf$V2, type="l", col="RED", xlab="Residue Number", ylab="RMSF (Å)")
#