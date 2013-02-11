package sdslabs.echo.searching


import org.apache.lucene.store.FSDirectory
import org.apache.lucene.store.Directory
import java.io.File
import org.apache.lucene.search.IndexSearcher
import org.apache.lucene.queryParser.QueryParser
import org.apache.lucene.util.Version
import org.apache.lucene.analysis.standard.StandardAnalyzer
import org.apache.lucene.search.Query
import org.apache.lucene.search.TopDocs
import org.apache.lucene.search.ScoreDoc
import org.apache.lucene.document.Document
import java.util.UUID
import scala.collection.mutable.HashMap
import scala.collection.mutable.Map
import org.apache.lucene.analysis.WhitespaceAnalyzer
import org.apache.lucene.queryParser.MultiFieldQueryParser

class EchoSearching() {

 /* val indexDirectoryMain = "/media/data/echo/IndexDirectoryMain" // index directory with indeices of name, author etc
val indexDirectoryDetails = ""
val dirMain : Directory = FSDirectory.open(new File(indexDirectoryMain))
var dirDetails : Directory = FSDirectory.open(new File(indexDirectoryDetails))
val isMain: IndexSearcher = new IndexSearcher(dirMain)
val isDetails : IndexSearcher = new IndexSearcher(dirDetails)
def search(queryStr: String): Map[Float, UUID] = {
val parser: QueryParser = new QueryParser(Version.LUCENE_33, "contents", new WhitespaceAnalyzer(Version.LUCENE_33));
val query: Query = parser.parse(queryStr);

val hitsMain: TopDocs = isMain.search(query, 100);

val result: Map[Float, UUID] = new HashMap[Float, UUID]()
hitsMain.scoreDocs foreach ( d => {
val docMain: Document = isMain.doc(d.doc)
result += (d.score -> UUID.fromString(docMain.get("id")))

}
)
return result
} */
val indexDirMain = "/home/neeraj/Desktop/Echo/IndexDirectoryName"
val indexDirDetails = "/home/neeraj/Desktop/Echo/IndexDirectoryDetails"
val dirMain : Directory = FSDirectory.open(new File(indexDirMain))
val dirDetails : Directory = FSDirectory.open(new File(indexDirDetails))
val indexSearcherMain : IndexSearcher = new IndexSearcher(dirMain)
val indexSearcherDetails : IndexSearcher = new IndexSearcher(dirDetails)

def search(queryStr : String) : Map[Float, UUID] = {
val fieldsMain = Array("title", "authors", "ISBN_10", "ISBN_13", "subtitle")
val parserMain : MultiFieldQueryParser = new MultiFieldQueryParser(Version.LUCENE_33, fieldsMain, new WhitespaceAnalyzer(Version.LUCENE_33))
val queryMain : Query = parserMain.parse(queryStr)
val hitsMain : TopDocs = indexSearcherMain.search(queryMain, 100)
val results : Map[Float, UUID] = new HashMap[Float, UUID]()
hitsMain.scoreDocs foreach( d => {
val docMain : Document = indexSearcherMain.doc(d.doc)
results += (d.score -> UUID.fromString(docMain.get("title")))
})

val iter : Iterator[UUID] = results.valuesIterator
val list : java.util.List[UUID] = new java.util.ArrayList[UUID]()
while(iter.hasNext) {
list.add(iter.next())
}
val fieldDetails = Array("description", "contents")
val parserDetails : MultiFieldQueryParser = new MultiFieldQueryParser(Version.LUCENE_33, fieldDetails, new WhitespaceAnalyzer(Version.LUCENE_33))
val queryDetails : Query = parserDetails.parse(queryStr)
val hitsDetails : TopDocs = indexSearcherDetails.search(queryDetails, 100)
hitsDetails.scoreDocs foreach( d => {
val docDetails : Document = indexSearcherDetails.doc(d.doc)
if(list.contains(UUID.fromString(docDetails.get("id"))) == false) {
results += (d.score -> UUID.fromString(docDetails.get("title")))
}
})
return results
}
    
}
