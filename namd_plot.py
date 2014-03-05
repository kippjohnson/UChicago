#!/usr/local/bin/python

# Usage: ./namd_plot.py <combined-namd-logfile.log>
# Will graph the chosen output from NAMD (1-20); by default
# is set to total energy. Outputs are listed below

# Combined logfiles should just be catted together with
# something like the bash command
# cat log1.log log2.log log3.log >> combined.log

# REQUIRES: matplotlib

import sys
import re
import matplotlib.pyplot as plt


infile = open(sys.argv[1],"r+")

i = 0
a = []
b = []

# Change chosenValue to desired output with key below
#chosenValue = sys.argv[2] #run at command line
chosenValue = 11 #default = total energy

# NAMD outputs 1-20
#ETITLE: TS BOND ANGLE DIHED IMPRP                    [1-5]
#        ELECT VDW BOUNDARY MISC KINETIC              [6-10]
#        TOTAL TEMP POTENTIAL TOTAL3 TEMPAVG          [11-15]
#        PRESSURE GPRESSURE VOLUME PRESSAVG GPRESSAVG [16-20]


for line in infile:
        if line.startswith("ENERGY"):
                lineValues = re.split("\s+", line)
                if lineValues[1] != "":
                    a.append(i)
                    b.append(lineValues[chosenValue])
                    i = i + 1
        else:
            continue

# matplotlib code            
plt.plot(a, b)
plt.show()

# Uncomment to write the values to file
outfile = open("output.dat", "w")
outfile.writelines(["%s\n" % item  for item in b]) 
