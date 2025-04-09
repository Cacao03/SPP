/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author TRAN DUNG
 */
public class Subject {

    private int subjectId;
    private String subjectCode;
    private String subjectName;
    private int managerID;
    private int isActive;
    private Timestamp updateAt;
    private String description;
    private String timeAllocation;
    private int passGrade;
    
    
    public Subject(int subjectId, String subjectCode, String subjectName, int managerID) {
        this.subjectId = subjectId;
        this.subjectCode = subjectCode;
        this.subjectName = subjectName;
        this.managerID = managerID;
    }

    
    public Subject(String subjectCode, String subjectName, int managerID) {
        this.subjectCode = subjectCode;
        this.subjectName = subjectName;
        this.managerID = managerID; 
    }

    public Subject(int subjectId, String subjectCode, String subjectName, int managerID, int isActive, Timestamp updateAt) {
        this.subjectId = subjectId;
        this.subjectCode = subjectCode;
        this.subjectName = subjectName;
        this.managerID = managerID;
        this.isActive = isActive;
        this.updateAt = updateAt;
    }

    public Subject(int subjectId, String subjectCode, String subjectName, int managerID, int isActive) {
        this.subjectId = subjectId;
        this.subjectCode = subjectCode;
        this.subjectName = subjectName;
        this.managerID = managerID;
        this.isActive = isActive;
    }

    public Subject() {
    }

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public int getManagerID() {
        return managerID;
    }

    public void setManagerID(int managerID) {
        this.managerID = managerID;
    }

    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }

    public Timestamp getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Timestamp updateAt) {
        this.updateAt = updateAt;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTimeAllocation() {
        return timeAllocation;
    }

    public void setTimeAllocation(String timeAllocation) {
        this.timeAllocation = timeAllocation;
    }

    public int getPassGrade() {
        return passGrade;
    }

    public void setPassGrade(int passGrade) {
        this.passGrade = passGrade;
    }

    @Override
    public String toString() {
        return "Subject{" + "subjectId=" + subjectId + ", subjectCode=" + subjectCode + ", subjectName=" + subjectName + ", managerID=" + managerID + ", isActive=" + isActive + ", updateAt=" + updateAt + ", description=" + description + ", timeAllocation=" + timeAllocation + ", passGrade=" + passGrade + '}';
    }

}