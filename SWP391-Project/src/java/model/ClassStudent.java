/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import dal.ClassStudentDAO;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author Đàm Quang Chiến
 */
public class ClassStudent {

        private int id, classId, studentId, groupId, isActive;
    private String groupName, note, studentName, className, projectCode;

    public ClassStudent() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public int getStudentId() {
        return studentId;
    }

    public String getProjectCode() {
        return projectCode;
    }

    public void setProjectCode(String projectCode) {
        this.projectCode = projectCode;
    }
    
    

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String clasName) {
        this.className = clasName;
    }

    @Override
    public String toString() {
        return "ClassStudent{" + "id=" + id + ", classId=" + classId + ", studentId=" + studentId + ", groupId=" + groupId + ", isActive=" + isActive + ", groupName=" + groupName + ", note=" + note + ", studentName=" + studentName + '}';
    }

    public List<ClassStudent> paginateClassStudent(int index, int classId, String sortType, String sortVal, String sortVal2) {
        ClassStudentDAO classStDAO = new ClassStudentDAO();
        return classStDAO.paginateClassStudent(index, classId, sortType, sortVal, sortVal2);
    }
    
    public List<ClassStudent> searchAndPaginateStudent(int index, int classId, String searchValue) {
        ClassStudentDAO classStDAO = new ClassStudentDAO();
        return classStDAO.searchAndPaginateStudent(index, classId, searchValue);
    }

    public int getTotalClassStudent(int classID, String sortType, String sortVal, String sortVal2) {
        ClassStudentDAO classStDAO = new ClassStudentDAO();
        return classStDAO.getTotalClasStudent(classID, sortType, sortVal, sortVal2);
    }

    public boolean changeStudentStatus(int classStId, int status) {
        ClassStudentDAO classStDAO = new ClassStudentDAO();
        return classStDAO.changeClassStStatus(classStId, status);
    }

    public ClassStudent getClassStById(int id, int projectId) {
        ClassStudentDAO classStDAO = new ClassStudentDAO();
        return classStDAO.getClassStById(id, projectId);
    }
    public List<ClassStudent> getListClassStudent(int classId) {
        ClassStudentDAO classStDAO = new ClassStudentDAO();
        return classStDAO.getListClassStudent(classId);
    }
    public boolean updateClassSt(int classStId, int status, String des) {
        ClassStudentDAO classStDAO = new ClassStudentDAO();
        return classStDAO.updateClassSt(classStId, status, des);
    }
   
    
    public void createNewClassSt() throws SQLException{
        ClassStudentDAO classStDAO = new ClassStudentDAO();
        classStDAO.createNewClassSt(this);
    }
    
    public boolean checkExisted(){
        ClassStudentDAO classStDAO = new ClassStudentDAO();
        return classStDAO.checkClassGroupProjectExist(this.classId, this.groupId, this.studentId);
    }
    
    public boolean checkDuplicate(){
        ClassStudentDAO classStDAO = new ClassStudentDAO();
        return classStDAO.checkClassGroupProjectExist(this.classId, this.groupId, this.studentId);
    }
    

}
