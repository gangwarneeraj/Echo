package sdslabs.echo.utils

import java.io.File
import java.net.URL
import java.io.OutputStream
import java.io.InputStream
import java.net.HttpURLConnection
import java.io.BufferedOutputStream
import java.io.FileOutputStream

class EchoFileInfo(file : File) {
  var bookName : String = file.getName()
  var fileExtension : String = bookName.split('.').last
  
  def getExtension() : String = fileExtension
  def getBookName() : String = bookName
  def getFile() : File = file
  
  
}