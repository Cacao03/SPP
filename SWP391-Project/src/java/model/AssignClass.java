/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import dal.ClassDAO;
import java.util.List;

/**
 *
 * @author Đàm Quang Chiến
 */
public class AssignClass {

    private int classId;
    private String classCode, semesterName, subjectName;
    private String classDetail;
    private int semester;
    private int subject;
    private int manager;
    private int status;
    private String gitLabId;
    private String accessToken;

    public AssignClass() {
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }
    
    

    public String getSemesterName() {
        return semesterName;
    }

    public void setSemesterName(String semesterName) {
        this.semesterName = semesterName;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getGitLabId() {
        return gitLabId;
    }

    public void setGitLabId(String gitLabId) {
        this.gitLabId = gitLabId;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public String getClassCode() {
        return classCode;
    }

    public void setClassCode(String classCode) {
        this.classCode = classCode;
    }

    public String getClassDetail() {
        return classDetail;
    }

    public void setClassDetail(String classDetail) {
        this.classDetail = classDetail;
    }

    public int getSemester() {
        return semester;
    }

    public void setSemester(int semester) {
        this.semester = semester;
    }

    public int getSubject() {
        return subject;
    }

    public void setSubject(int subject) {
        this.subject = subject;
    }

    public int getManager() {
        return manager;
    }

    public void setManager(int manager) {
        this.manager = manager;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "AssignClass{" + "classId=" + classId + ", classCode=" + classCode + ", classDetail=" + classDetail + ", semester=" + semester + ", subject=" + subject + ", manager=" + manager + ", status=" + status + '}';
    }

    public List<AssignClass> paginateClass(int index, int role, int userId) {
        ClassDAO classDao = new ClassDAO();
        return classDao.paginateClass(index, role, userId);
    }

    public int getTotalClass(int role, int userId) {
        ClassDAO classDao = new ClassDAO();
        return classDao.getTotalClass(role, userId);
    }

    public AssignClass getClassInfor(int classId) {
        ClassDAO classDao = new ClassDAO();
        return classDao.getClassInfor(classId);
    }

    public boolean updateGitMethods(String url, int id) {
        ClassDAO classDao = new ClassDAO();
        return classDao.updateGitLabMethods(url, id) == 1;
    }

    public List<AssignClass> searchClass(int index, int role, int userId, String searchValue) {
        ClassDAO classDao = new ClassDAO();
        return classDao.searchAndPaginateClass(index, role, userId, searchValue);
    }

    public List<AssignClass> filterClass(int index, int role, int userId, String filType, int value) {
        ClassDAO classDao = new ClassDAO();
        return classDao.filterClass(index, role, userId, filType, value);
    }

}
