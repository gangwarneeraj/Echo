package sdslabs.echo.utils



import java.io.File
import org.apache.lucene.document.Document
import org.apache.lucene.document.Field
import java.util.UUID
import java.io.FileReader
import java.io.FileInputStream
import org.apache.pdfbox.pdfparser.PDFParser
import org.apache.pdfbox.cos.COSDocument
import org.apache.pdfbox.util.PDFTextStripper
import org.apache.pdfbox.pdmodel.PDDocument
import sdslabs.echo.indexing._
import org.apache.tika.parser.epub.EpubParser 


/**
 * COMPLETED
 */
class EchoDocument(_file : EchoFileInfo, id: String, map : Map[String, String]) {
  /*docName => document with book name and author name
   * docDetails => document with other book details*/
  val text : String = WhichParser.getText(_file)
  private val echoDoc_Name : Document = new Document()
  private val echoDoc_Details : Document = new Document()
  
  map foreach( pair => {
    if(pair._1 == "subtitle" || pair._1 == "ISBN_13" || pair._1 == "title" || pair._1 == "ISBN_10" || pair._1 == "authors") {
      echoDoc_Name.add(new Field(pair._1, pair._2, Field.Store.YES, Field.Index.ANALYZED))
    } else {
      echoDoc_Details.add(new Field(pair._1, pair._2, Field.Store.NO, Field.Index.ANALYZED)) 
    }   
  })
  
  echoDoc_Name.add(new Field("id", id, Field.Store.YES, Field.Index.NOT_ANALYZED))
  echoDoc_Details.add(new Field("contents", text, Field.Store.NO, Field.Index.ANALYZED))
  echoDoc_Details.add(new Field("id", id, Field.Store.YES, Field.Index.NOT_ANALYZED))
  EchoLogger.info("Created EchoDocument " + id.toString + " of length " + text.length)
  
  def file = _file.getFile()
  def getDocumentDetails: Document = echoDoc_Details
  def getDocumentName : Document = echoDoc_Name
  def docId : String = id
    	
}