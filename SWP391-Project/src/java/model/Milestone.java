/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import dal.MilestoneDAO;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Đàm Quang Chiến
 */
public class Milestone {

    private int id;
    private String name;
    private String descript;
    private Date startDate;
    private Date dueDate;
    private int isActive;
    private int classId;
    private int projectId;
    private Timestamp updateAt;
    private String gitlabId;
    
    
    public Milestone() {
    }

    public String getGitlabId() {
        return gitlabId;
    }

    public void setGitlabId(String gitlabId) {
        this.gitlabId = gitlabId;
    }

    
    
    public Timestamp getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Timestamp updateAt) {
        this.updateAt = updateAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescript() {
        return descript;
    }

    public void setDescript(String descript) {
        this.descript = descript;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public int getProjectId() {
        return projectId;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    @Override
    public String toString() {
        return "Milestone{" + "id=" + id + ", name=" + name + ", descript=" + descript + ", startDate=" + startDate + ", dueDate=" + dueDate + ", isActive=" + isActive + ", classId=" + classId + ", projectId=" + projectId + ", updateAt=" + updateAt + ", gitlabId=" + gitlabId + '}';
    }

 

    public List<Milestone> paginateClassMileStone(int index, int classId, int projectId) {
        MilestoneDAO milestoneDao = new MilestoneDAO();
        return milestoneDao.paginateClassMileStone(index, classId, projectId);
    }
    
    public List<Milestone> searchAndPaginateMilestone(int index, int classId, String searchValue) {
        MilestoneDAO milestoneDao = new MilestoneDAO();
        return milestoneDao.searchAndPaginateMilestone(index, classId, searchValue);
    }
    
    public List<Milestone> filterMilestone(int index, int classId, String type, int value) {
        MilestoneDAO milestoneDao = new MilestoneDAO();
        return milestoneDao.filterMilestone(index, classId, type, value);
    }
    public List<Milestone> getListClassMilestone(int classId){
        MilestoneDAO milestoneDao = new MilestoneDAO();
        return milestoneDao.getListClassMilestone(classId);
    }
    
    public Milestone getMilestoneById(int mileId) {
        MilestoneDAO milestoneDao = new MilestoneDAO();
        return milestoneDao.getMilestoneById(mileId);
    }

    public int getTotalClassMileStones(int classID) {
        MilestoneDAO milestoneDao = new MilestoneDAO();
        return milestoneDao.getTotalClassMileStones(classID);
    }

    public boolean changeMilestoneStatus(int mileId, int status) {
        MilestoneDAO milestoneDao = new MilestoneDAO();
        return milestoneDao.changeMilestoneStatus(mileId, status);
    }

    public boolean checkExisted(String column, String value, int mileId, int classId) {
        MilestoneDAO milestoneDao = new MilestoneDAO();
        return milestoneDao.checkExisted(column, value, mileId, classId);
    }

    public boolean updateMilestone() {
        MilestoneDAO milestoneDao = new MilestoneDAO();
        return milestoneDao.updateMilestone(this);
    }

    public boolean insertMilestone() {
        MilestoneDAO milestoneDao = new MilestoneDAO();
        return milestoneDao.insertMilestone(this);
    }
    
    public boolean insertProjectMilestone() {
        MilestoneDAO milestoneDao = new MilestoneDAO();
        return milestoneDao.insertProjectMilestone(this);
    }
    
    public boolean deleteMilestone(int id) {
        MilestoneDAO milestoneDao = new MilestoneDAO();
        return milestoneDao.deleteMilestone(id);
    }
}
