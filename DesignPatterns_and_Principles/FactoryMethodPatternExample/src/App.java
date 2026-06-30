public class App {
    public static void main(String[] args) {

        DocumentFactory pdfFactory = new PdfFactory();
        Document myPdf = pdfFactory.createDocument();
        myPdf.open();

        DocumentFactory excelFactory = new ExcelFactory();
        Document myExcel = excelFactory.createDocument();
        myExcel.open();

        DocumentFactory wordFactory = new WordFactory();
        Document myWord = wordFactory.createDocument();
        myWord.open();
    }
}