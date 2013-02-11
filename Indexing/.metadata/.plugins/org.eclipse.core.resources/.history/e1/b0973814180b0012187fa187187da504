package sdslabs.echo.indexing



import sdslabs.echo.utils.EchoDocument
import org.apache.lucene.document.Document
import org.apache.lucene.document.Field
import org.apache.lucene.analysis.Analyzer
import org.apache.lucene.analysis.standard.StandardAnalyzer
import org.apache.lucene.index.IndexWriter
import org.apache.lucene.store.FSDirectory
import org.apache.lucene.util.Version
import java.io.File
import org.apache.lucene.analysis.WhitespaceAnalyzer
import sdslabs.echo.utils._

class EchoIndexing() {

  val indexDirectoryName : String = Settings.getIndexDirName()
  val indexDirectoryDetails : String = Settings.getIndexDirDetails()
  private val indexDirName : FSDirectory = FSDirectory.open(new File(indexDirectoryName))
  private val writerName: IndexWriter = new IndexWriter(indexDirName, new StandardAnalyzer(Version.LUCENE_33), true, IndexWriter.MaxFieldLength.UNLIMITED)
  private val indexDirDetails : FSDirectory = FSDirectory.open(new File(indexDirectoryDetails))
  private val writerDetails: IndexWriter = new IndexWriter(indexDirDetails, new StandardAnalyzer(Version.LUCENE_33), true, IndexWriter.MaxFieldLength.UNLIMITED)
  
  def indexDocument( doc: EchoDocument){
	//val writer: IndexWriter = new IndexWriter(indexDir, new WhitespaceAnalyzer(Version.LUCENE_33), true, IndexWriter.MaxFieldLength.UNLIMITED)
    EchoLogger.info("Adding document " + doc.file.getName() + " and id " + doc.docId + " to the indexes")
    writerName.addDocument(doc.getDocumentName)
    writerName.commit()
    println("working optimize" + writerName.optimize())
    writerDetails.addDocument(doc.getDocumentDetails)
    writerDetails.commit()
    println("working optimize" + writerDetails.optimize())
    EchoLogger.info("Finished adding document " + doc.file.getName() + " and id " + doc.docId + " to the indexes")
  }
  
}