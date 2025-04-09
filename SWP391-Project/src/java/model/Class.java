/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import dal.ClassDAO;
import java.util.List;

/**
 *
 * @author FPT
 */
public class Class {
    private int classId;
    private String classCode;
    private String classDetails;
    private int semesterId;
    private int subjectId;
    private int managerId;
    private int status;
    private String gitlabId;
    private String accessToken;

    public Class() {
    }

    public Class(int classId, String classCode, String classDetails, int semesterId, int subjectId, int managerId, int status, String gitlabId, String accessToken) {
        this.classId = classId;
        this.classCode = classCode;
        this.classDetails = classDetails;
        this.semesterId = semesterId;
        this.subjectId = subjectId;
        this.managerId = managerId;
        this.status = status;
        this.gitlabId = gitlabId;
        this.accessToken = accessToken;
    }


    public Class(int classId, String classCode, int semesterId, int subjectId, int managerId, int status) {
        this.classId = classId;
        this.classCode = classCode;
        this.semesterId = semesterId;
        this.subjectId = subjectId;
        this.managerId = managerId;
        this.status = status;
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

    public String getClassDetails() {
        return classDetails;
    }

    public void setClassDetails(String classDetails) {
        this.classDetails = classDetails;
    }

    public int getSemesterId() {
        return semesterId;
    }

    public void setSemesterId(int semesterId) {
        this.semesterId = semesterId;
    }

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public int getManagerId() {
        return managerId;
    }

    public void setManagerId(int managerId) {
        this.managerId = managerId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getGitlabId() {
        return gitlabId;
    }

    public void setGitlabId(String gitlabId) {
        this.gitlabId = gitlabId;
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    @Override
    public String toString() {
        return "Class{" + "classId=" + classId + ", classCode=" + classCode + ", classDetails=" + classDetails + ", semesterId=" + semesterId + ", subjectId=" + subjectId + ", managerId=" + managerId + ", status=" + status + ", gitlabId=" + gitlabId + ", accessToken=" + accessToken + '}';
    }
    
    public List<Class> getAllClasses(){
        ClassDAO classDAO = new ClassDAO();
        return classDAO.getAllClasses();
    }
     
}
