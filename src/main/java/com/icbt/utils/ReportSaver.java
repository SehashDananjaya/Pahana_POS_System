package com.icbt.utils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ReportSaver {

    public static void saveResultSetToFile(ResultSet rs, String reportTitle, String fileName) throws IOException, SQLException {
        // Full path on C:/Documents/
        String folderPath = "C:/Documents/";
        File folder = new File(folderPath);
        if (!folder.exists()) {
            folder.mkdirs(); // create folder if it doesn't exist
        }

        String filePath = folderPath + fileName;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            writer.write(reportTitle + "\n");
            writer.write("=".repeat(reportTitle.length()) + "\n\n");

            int columnCount = rs.getMetaData().getColumnCount();

            // Write header
            for (int i = 1; i <= columnCount; i++) {
                writer.write(rs.getMetaData().getColumnLabel(i) + "\t");
            }
            writer.write("\n");
            writer.write("-".repeat(columnCount * 15) + "\n");

            // Write data rows
            rs.beforeFirst(); // move cursor to start
            while (rs.next()) {
                for (int i = 1; i <= columnCount; i++) {
                    writer.write(rs.getString(i) + "\t");
                }
                writer.write("\n");
            }
        }
    }
}
