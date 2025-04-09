package util;

import dal.ClassStudentDAO;
import dal.ProjectDAO;
import java.io.File;
import java.io.FileInputStream;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import model.ClassStudent;
import model.Project;

public class ExcelHandler {

    public boolean exportClassStudentListToExcel(List<ClassStudent> students, String className) {
        String baseFilePath = "C:\\Users\\ADMIN\\Downloads\\" + className;
        String filePath = baseFilePath + ".xlsx";

        // Check if the file already exists
        int fileCounter = 1;
        while (new File(filePath).exists()) {
            filePath = baseFilePath + '(' + fileCounter + ')' + ".xlsx";
            fileCounter++;
        }

        try ( Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Students");

            // Header row
            Row headerRow = sheet.createRow(0);
            headerRow.createCell(0).setCellValue("No.");
            headerRow.createCell(1).setCellValue("Class Code");
            headerRow.createCell(2).setCellValue("Group Name");
            headerRow.createCell(3).setCellValue("Project Code");
            headerRow.createCell(4).setCellValue("Student ID");
            headerRow.createCell(5).setCellValue("Student Name");
            headerRow.createCell(6).setCellValue("Is Active");
            headerRow.createCell(7).setCellValue("Note");

            // Data rows
            int count = 0;
            for (int i = 0; i < students.size(); i++) {
                ClassStudent student = students.get(i);
                Row row = sheet.createRow(i + 1); // +1 because header is at row 0
                row.createCell(0).setCellValue(++count);
                row.createCell(1).setCellValue(student.getClassName());
                row.createCell(2).setCellValue(student.getGroupName());
                row.createCell(3).setCellValue(student.getProjectCode());
                row.createCell(4).setCellValue(student.getStudentId());
                row.createCell(5).setCellValue(student.getStudentName());
                row.createCell(6).setCellValue(student.getIsActive() == 1 ? "Active" : "Inactive");
                row.createCell(7).setCellValue(student.getNote());
            }

            // Writing the workbook to the specified file
            try ( FileOutputStream fileOut = new FileOutputStream(filePath)) {
                workbook.write(fileOut);
            }

            return true; // Return true when file export is successful
        } catch (IOException e) {
            e.printStackTrace();  // Log the exception
            return false; // Return false when file export fails
        }
    }

// Similarly, you can apply the same logic to other export methods
    public void importClassStudentFromExcel(String filePath) throws IOException, SQLException {
        ClassStudent classSt = new ClassStudent();
        FileInputStream fis = new FileInputStream(filePath);
        Workbook workbook = new XSSFWorkbook(fis);
        Sheet sheet = workbook.getSheetAt(0); // Get the first sheet
        for (int i = 1; i <= sheet.getLastRowNum(); i++) { // Start from 1 to skip header row
            Row row = sheet.getRow(i);
            int classId = (int) row.getCell(1).getNumericCellValue();
            int studentId = (int) row.getCell(2).getNumericCellValue();
            int groupId = (int) row.getCell(3).getNumericCellValue();
            String groupName = row.getCell(4).getStringCellValue();
            String note = row.getCell(5).getStringCellValue();
            String studentName = row.getCell(6).getStringCellValue();
            int isActive = (int) row.getCell(7).getNumericCellValue();
            classSt.setClassId(classId);
            classSt.setStudentId(studentId);
            classSt.setGroupId(groupId);
            classSt.setGroupName(groupName);
            classSt.setNote(note);
            classSt.setStudentName(studentName);
            classSt.setIsActive(isActive);
            if (!isValidClassRow(row) || !classSt.checkExisted() || !classSt.checkDuplicate()) {
                continue;
            }
            classSt.createNewClassSt();

        }

    }

    public boolean isValidClassRow(Row row) {
        if (row.getCell(0) == null || row.getCell(1) == null || row.getCell(2) == null) {
            return false;
        }

        if (row.getCell(1).getCellType() != CellType.NUMERIC) {
            return false;
        }

        if (row.getCell(2).getCellType() != CellType.NUMERIC) {
            return false;
        }
        if (row.getCell(7).getCellType() != CellType.NUMERIC || (row.getCell(7).getNumericCellValue() != 0 && row.getCell(7).getNumericCellValue() != 1)) {
            return false;
        }

        return true;
    }

    public void importProjectFromExcel(String filePath, int class_id) throws IOException, SQLException {
        Project pro = new Project();
        ProjectDAO dao = new ProjectDAO();
        FileInputStream fis = new FileInputStream(filePath);
        Workbook workbook = new XSSFWorkbook(fis);

        Sheet sheet = workbook.getSheetAt(0); // Get the first sheet
        for (int i = 1; i < sheet.getLastRowNum(); i++) { // Start from 1 to skip header row
            Row row = sheet.getRow(i);
            String group_name = (String) row.getCell(0).getStringCellValue();
            String project_code = (String) row.getCell(1).getStringCellValue();
            String project_en_name = (String) row.getCell(2).getStringCellValue();
            String project_vi_name = (String) row.getCell(3).getStringCellValue();
            String project_descript = (String) row.getCell(4).getStringCellValue();

//            int mentor_id_INT = Integer.parseInt(mentor_id);
//            int co_mentor_id_INT = Integer.parseInt(co_mentor_id);
            pro.setProject_code(project_code);
            pro.setGroup_name(group_name);
            pro.setClass_id(class_id);
            pro.setProject_en_name(project_en_name);
            pro.setProject_vi_name(project_vi_name);
            pro.setProject_descript(project_descript);

            dao.importProExcel(pro);
        }

    }

    public boolean exportTemplateProject() {
        String filePath = "C:\\Users\\ADMIN\\Downloads\\Template.xlsx";

        try ( Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Projects");

            // Header row
            Row headerRow = sheet.createRow(0);
            headerRow.createCell(0).setCellValue("group_name");
            headerRow.createCell(1).setCellValue("project_code");
            headerRow.createCell(2).setCellValue("project_en_name");
            headerRow.createCell(3).setCellValue("project_vi_name");
            headerRow.createCell(4).setCellValue("project_descript");

            // Data rows
            Row row = sheet.createRow(2); // +1 because header is at row 0
            row.createCell(0).setCellValue("");
            row.createCell(1).setCellValue("");
            row.createCell(2).setCellValue("");
            row.createCell(3).setCellValue("");
            row.createCell(4).setCellValue("");

            // Writing the workbook to the specified file
            try ( FileOutputStream fileOut = new FileOutputStream(filePath)) {
                workbook.write(fileOut);
            }

            return true; // Return true when file export is successful
        } catch (IOException e) {
            e.printStackTrace();  // Log the exception
            return false; // Return false when file export fails
        }
    }

    public boolean exportClassProjectListToExcel(List<Project> projects, String className) {
        String filePath = "C:\\Users\\ADMIN\\Downloads\\" + className + ".xlsx";

        try ( Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Projects");

            // Header row
            Row headerRow = sheet.createRow(0);
            headerRow.createCell(0).setCellValue("project_id");
            headerRow.createCell(1).setCellValue("project_code");
            headerRow.createCell(2).setCellValue("project_en_name");
            headerRow.createCell(3).setCellValue("project_vi_name");
            headerRow.createCell(4).setCellValue("project_descript");
            headerRow.createCell(5).setCellValue("status");
            headerRow.createCell(6).setCellValue("class_id");
            headerRow.createCell(7).setCellValue("group_name");
            headerRow.createCell(8).setCellValue("mentor_id");
            headerRow.createCell(9).setCellValue("co_mentor_id");

            // Data rows
            for (int i = 0; i < projects.size(); i++) {
                Project pro = projects.get(i);
                Row row = sheet.createRow(i + 1); // +1 because header is at row 0
                row.createCell(0).setCellValue(pro.getProject_id());
                row.createCell(1).setCellValue(pro.getProject_code());
                row.createCell(2).setCellValue(pro.getProject_en_name());
                row.createCell(3).setCellValue(pro.getProject_vi_name());
                row.createCell(4).setCellValue(pro.getProject_descript());
                row.createCell(5).setCellValue(pro.getStatus());
                row.createCell(6).setCellValue(pro.getClass_id());
                row.createCell(7).setCellValue(pro.getGroup_name());
                row.createCell(8).setCellValue(pro.getMentor_id());
                row.createCell(9).setCellValue(pro.getCo_mentor_id());
            }

            // Writing the workbook to the specified file
            try ( FileOutputStream fileOut = new FileOutputStream(filePath)) {
                workbook.write(fileOut);
            }

            return true; // Return true when file export is successful
        } catch (IOException e) {
            e.printStackTrace();  // Log the exception
            return false; // Return false when file export fails
        }
    }

    public static void main(String[] args) throws IOException, SQLException {
        ExcelHandler ex = new ExcelHandler();
        ClassStudent classSt = new ClassStudent();
        ex.importClassStudentFromExcel("C:\\Users\\ADMIN\\Downloads\\Code.xlsx");
//        List<ClassStudent> listClassSt = classSt.getListClassStudent(1);
////        for(ClassStudent cls : listClassSt){
////            System.out.println(cls);
////        }
//        ex.exportClassStudentListToExcel(listClassSt, "check");
    }
}
