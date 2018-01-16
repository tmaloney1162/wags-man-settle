import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.usermodel.Row.MissingCellPolicy;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.BufferedInputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.Set;
import java.util.TreeSet;
import java.util.regex.*;

public class ApachePOIExcelReadWagsManSettle {
    public  final static String PROLOG = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\" ?>";
    public  final static String OPEN_START = "<";
    public  final static String OPEN_END = "</";
    public  final static String CLOSE = ">";
    public  final static String NEWLINE = "\n";
    public  final static String INDENT = "\t";

    String delimiter;
    int nfields, nrows;
    String header, rowname, rootname, footerField1, footerField2, footerCopyrightYear;
    String[] fieldnames;
    StringBuffer output = new StringBuffer();
	private Workbook workbook;

    String patternAmpersand = "&";
    String replacementAmpersand = "&amp;";

    // Compile regular expression
    Pattern pattern2 = Pattern.compile(patternAmpersand);
    
    Set<String> treeSet = new TreeSet<>();    
	
    public static void main(String args[]) {
        if (args.length < 2) {
            System.out.println("java ExcelToXML_WK [properties file] [source] [destination]");
            System.exit(1);
        }
        new ApachePOIExcelReadWagsManSettle(args);
    }
    
    
    public ApachePOIExcelReadWagsManSettle(String args[]) {
    
        Properties props = loadProperties(args[0]);
        setParameters(props);
        String source = args[1];
        String outFile = args[2];

    	DataFormatter formatter = new DataFormatter(); 
    	try {
            output.append(header);
            output.append(NEWLINE);
            output.append(OPEN_START + rootname + CLOSE);
            output.append(NEWLINE);
            output.append(OPEN_START + "footerField1" + CLOSE + footerField1 + OPEN_END + "footerField1" + CLOSE + NEWLINE);
            output.append(OPEN_START + "footerField2" + CLOSE + footerField2 + OPEN_END + "footerField2" + CLOSE + NEWLINE);
            output.append(OPEN_START + "footerCopyrightYear" + CLOSE + footerCopyrightYear + OPEN_END + "footerCopyrightYear" + CLOSE + NEWLINE);

            FileInputStream excelFile = new FileInputStream(new File(source));
            workbook = new XSSFWorkbook(excelFile);
            workbook.setMissingCellPolicy(MissingCellPolicy.RETURN_BLANK_AS_NULL);
            Sheet datatypeSheet = workbook.getSheetAt(0);

            int totRows = datatypeSheet.getPhysicalNumberOfRows();
            System.out.println("total rows: " + totRows);

            String dirName  = source.substring(0, source.lastIndexOf("\\"));
            String newDirName = dirName + "\\tmp\\";
            
            mkDir(newDirName);

            
            
            for (int r = 0; r < totRows; r++) {
                Row currentRow = datatypeSheet.getRow(r);
                if (currentRow == null) {
                   System.out.println("Row " + r + " is null");
                	continue;
                 } 

                output.append(INDENT + OPEN_START + rowname + CLOSE + NEWLINE);
            	
                for (int c = 0; c < nfields; c++) {

                    //open element
                    output.append(INDENT + INDENT + OPEN_START + fieldnames[c] + CLOSE);

                    Cell currentCell = currentRow.getCell(c, Row.RETURN_BLANK_AS_NULL);
                    String cellContent = formatter.formatCellValue(currentCell);

                    Matcher matcher2 = pattern2.matcher(cellContent);
                    String modValue = matcher2.replaceAll(replacementAmpersand);

                    cellContent = modValue;

//                    if (fieldnames[c].equalsIgnoreCase("HRSA-ID")) {
                    if (fieldnames[c].equalsIgnoreCase("CoveredEntity")) {
                    	//System.out.println("r:"+r+"  CoveredEntity:"+cellContent);
                    	if (r > 0){
                        	//treeSet.add(Integer.parseInt(cellContent));
                        	treeSet.add(cellContent);
                    	}                    
                    }
                    
                    // System.out.print(cellContent + "	");
                    output.append(cellContent);
                    output.append(OPEN_END + fieldnames[c] + CLOSE + NEWLINE);
                }
                //System.out.println();

                output.append(INDENT + OPEN_END + rowname + CLOSE);
                output.append(NEWLINE);
            }
            
//            output.append(INDENT + OPEN_START + "uniqueHrsaIdGroup" + CLOSE + NEWLINE);
            output.append(INDENT + OPEN_START + "coveredEntityGroup" + CLOSE + NEWLINE);
            
        	for (String str : treeSet) {
//        		output.append(INDENT + INDENT + OPEN_START + "uniqueHrsaId" + CLOSE);        		
        		output.append(INDENT + INDENT + OPEN_START + "coveredEntity" + CLOSE);        		
                output.append(str);
//                output.append(OPEN_END + "uniqueHrsaId" + CLOSE + NEWLINE);
                output.append(OPEN_END + "coveredEntity" + CLOSE + NEWLINE);
                
                //mkDir(inDir);
//                String foName = newDirName + "\\fo\\" + str;
                String hsraIdDirName = newDirName + "\\" + str;
                String foDirName = hsraIdDirName + "\\fo";
                String outputDirName = hsraIdDirName + "\\output";
                mkDir(hsraIdDirName);
                mkDir(foDirName);
                mkDir(outputDirName);

                
        	} 
//            output.append(INDENT + OPEN_END + "uniqueHrsaIdGroup" + CLOSE);
            output.append(INDENT + OPEN_END + "coveredEntityGroup" + CLOSE);
            output.append(NEWLINE);
        	
            output.append(OPEN_END + rootname + CLOSE);
            output.append(NEWLINE);


        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    	
 
    	//System.out.println(output.toString());
    	saveString(outFile, output.toString());
    	
    }

    public void setParameters(Properties props) {
        delimiter = props.getProperty("delimiter");
        rootname = props.getProperty("rootname");
        rowname = props.getProperty("recordname");
        footerField1 = props.getProperty("footerField1");
        footerField2 = props.getProperty("footerField2");
        footerCopyrightYear = props.getProperty("footerCopyrightYear");
        
        String comment = props.getProperty("comment");
        
        header = PROLOG + NEWLINE
        + "<!-- " + comment + " -->" + NEWLINE;
        
        nfields = Integer.parseInt(props.getProperty("fields"));
        
        fieldnames = new String[nfields];
        String fieldref;
        
        for (int field = 0; field < nfields; field++) {
            fieldref = "field" + field;
            fieldnames[field] = props.getProperty(fieldref);
        }
        
        
    }


    public String loadString(String filename) {
        StringBuffer text = new StringBuffer();
        FileInputStream instream;
        BufferedInputStream buffer;
        int readint;
        
        try {
            instream = new FileInputStream(filename);
            buffer = new BufferedInputStream(instream);
            while ((readint = buffer.read()) != -1) {
                text.append( (char) readint);
            }
            buffer.close();
            instream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return text.toString();
    }
    
    
    public void saveString(String filename, String string) {
        try {
            BufferedWriter out = new BufferedWriter(new FileWriter(filename));
            out.write(string);
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public Properties loadProperties(String filename) {
        Properties props = new Properties();
        FileInputStream instream;;
        BufferedInputStream buffer;
        
        try {
            instream = new FileInputStream(filename);
            buffer = new BufferedInputStream(instream);
            props.load(buffer);
            buffer.close();
            instream.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return props;
    }
    
    public String reformatDate(String inDate) {
    	
    	DateFormat fromFormat = new SimpleDateFormat("dd-MMM-yy");
    	fromFormat.setLenient(false);
    	DateFormat toFormat = new SimpleDateFormat("MM/dd/yyyy");
    	toFormat.setLenient(false);
    	Date date;
    	String outDate="";
    	try {
			date = fromFormat.parse(inDate);
	    	outDate=(toFormat.format(date));
		} catch (ParseException e) {
			e.printStackTrace();
		}
    	return outDate;
    }
    
	public static void mkDir(String inDir) {
        File tmpInDir = new File(inDir);

        if (!tmpInDir.exists()) {
            if (tmpInDir.mkdir()) {
                System.out.println(inDir + " - Directory is created!");
            } else {
                System.out.println(inDir + " - Failed to create directory!");
            }
        } else {
        	System.out.println(inDir + " - already exists");
        }
	}

    
    
}


