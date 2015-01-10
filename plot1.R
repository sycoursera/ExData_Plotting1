#options(error = recover)
debugSource("ReadPwrConsumption.R")

# Create new dataset or clear existing
SelectedData = data.frame()

# The date/time format used later for parsing
strTimestampFmt = "%d/%m/%Y %H:%M:%S"

# ----------------------------------------------------------------------
# Load dataset
# ----------------------------------------------------------------------
message(format(Sys.time(), "%d/%m/%Y %H:%M:%OS3"), ": start reading records...")

SelectedData = ReadPwrConsumption("household_power_consumption.txt", 
                                  "01/02/2007 00:00:00", 
                                  "03/02/2007 00:00:00", 
                                  strTimestampFmt, 
                                  fScanAll = FALSE
                                  )

message(format(Sys.time(), "%d/%m/%Y %H:%M:%OS3"), ": records read: ", length(SelectedData[[1]]) )
# ----------------------------------------------------------------------


# ----------------------------------------------------------------------
# Create plot 
# ----------------------------------------------------------------------
source("plots.R")

png("plot1.png")

plot1(SelectedData)

dev.off()

# ----------------------------------------------------------------------
# Copy plot from screen (disabled)
# ----------------------------------------------------------------------
#pngDev = dev.copy(png, file = "plot1.png")
#dev.off(pngDev)
