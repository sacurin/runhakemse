#' Based on the function [TMB::gdbsource()]
#'
#' @details Copies files to the `temp` directory and runs gdb
#' with custom startup (`.gdbinit`). This runs python code which loads
#' pcustom printers for the Eigen classes
#'
#' @param file The file name of the R script to debug which runs code from
#' `runHakeassessment.cpp` from within it
#' @param interactive Logical
#'
#' @return If interactive == TRUE, NULL, if interactive == FALSE,
#' the text output from gdb which states the location of the error in the
#' cpp code
gdbpy <- function (file, interactive = FALSE){
  gdb_dir <- "temp"
  if(file.exists(file.path(gdb_dir, file))){
    unlink(file.path(gdb_dir, file), force = TRUE)
  }
  if(file.exists(file.path(gdb_dir, ".gdbinit"))){
    unlink(file.path(gdb_dir, ".gdbinit"), force = TRUE)
  }
  if(file.exists(file.path(gdb_dir, "___init__.py"))){
    unlink(file.path(gdb_dir, "___init__.py"), force = TRUE)
  }
  if(file.exists(file.path(gdb_dir, "printers.py"))){
    unlink(file.path(gdb_dir, "printers.py"), force = TRUE)
  }
  file.copy(file, gdb_dir)
  file.copy(".gdbinit", gdb_dir)
  file.copy("___init__.py", gdb_dir)
  file.copy("printers.py", gdb_dir)

  txt <- c("set breakpoint pending on",
           "b abort",
           paste0("run --vanilla -f ", basename(file)),
           "bt")
  gdb_script_file <-  "gdb_script"
  writeLines(txt, file.path(gdb_dir, gdb_script_file))
  if(interactive){
    cmd <- paste0("cd ", gdb_dir, " & start gdb Rterm -x ", gdb_script_file)
    shell(cmd)
    NULL
  }else{
    cmd <- paste0("cd ", gdb_dir, " & gdb Rterm -x ", gdb_script_file)
    txt <- shell(cmd,
                 intern = TRUE,
                 ignore.stdout = FALSE,
                 ignore.stderr = TRUE)
    attr(txt, "file") <- file
    class(txt) <- "backtrace"
    txt
  }
}
