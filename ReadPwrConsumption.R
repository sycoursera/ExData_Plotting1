#######################################################################
# Read file line by line and select requested records
# SY: 09.01.2015
#######################################################################

ReadPwrConsumption <- function(
  strFilePath,                              # File name/path
  DateFrom,                                 # date-time staring from (including)
  DateTo,                                   # date-time before (not including)
  strTimestampFmt = "%d/%m/%Y %H:%M:%S",    # optional format for parsing date-time
  fScanAll = FALSE                          # check all lines in the file or break after DateTo
)
{
#  browser()

  ok = TRUE
  
  # NOTE: specify tz as "GMT" because the implicit as.POSIXct() conversion used 
  #       in the compare expression may fail with some datetimes (e.g. 25/3/2007;02:00:00) 
  DateFrom = as.POSIXct(DateFrom, tz = "GMT", format = strTimestampFmt)
  DateTo = as.POSIXct(DateTo, tz = "GMT", format = strTimestampFmt)
  
  con = file(strFilePath, "rt")
  # TODO: handle errors and set ok
  
  # Parse header to col names
  # NOTE: read Date and Time as strings by scan(), then convert them to POSIXlt by strptime()
  #       all other fiels consider numeric
  colTypes = list()
  if( ok ){
    Header = readLines( con, n = 1 )
    Header = unlist(strsplit(Header, ";"))
    
    # pre-fill "what" list by our types
    for( FieldName in Header ){
      if( FieldName == "Date" || FieldName == "Time" )
        colTypes = c(colTypes, "")
      else
        colTypes = c(colTypes, 0)
    }
    # set col names
    names(colTypes) = Header;
  }
  
  #pre-create output dataframe
  Data = data.frame(colTypes, stringsAsFactors = FALSE)
  Data = Data[FALSE,]

  while(ok){

    Record = scan( con, what = colTypes, nmax = 1, sep = ";", na.strings = "?", quiet=TRUE)
    # TODO: handle errors and set ok
    
    if( ok ){
      # NOTE: don't know yet how to catch EOF and errors so just check that anything returned
      if(length(Record[[1]]) == 0){
        break
      }else{
        Timestamp = as.POSIXct(paste(Record$Date, Record$Time), tz = "GMT", format = strTimestampFmt)
        if( Timestamp >= DateFrom ){
          if( Timestamp < DateTo){
            # insert record
            # NOTE: explicit convert list Record to data.frame to disable chr->factor conversion and 
            #       correct row.names
            Record = as.data.frame(Record, stringsAsFactors = FALSE)
            row.names(Record) = NULL
            Data = rbind(Data, Record)

          }else{ 
            if( !fScanAll )
              break
          }
        }
      }
    }
  }
  
  # TODO: check the connection is opened
  close(con)
  
  return (Data)
}
