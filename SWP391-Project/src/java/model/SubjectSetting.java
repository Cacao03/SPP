/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author TRAN DUNG
 */
public class SubjectSetting {

    private int settingId;
    private int subjectId;
    private int settingGroup;
    private String settingName;
    private String settingValue;
    private int displayOrder;
    private String description;

    public SubjectSetting(int settingId, int subjectId, int settingGroup, String settingName, String settingValue, int displayOrder, String description) {
        this.settingId = settingId;
        this.subjectId = subjectId;
        this.settingGroup = settingGroup;
        this.settingName = settingName;
        this.settingValue = settingValue;
        this.displayOrder = displayOrder;
        this.description = description;
    }

    public int getSettingId() {
        return settingId;
    }

    public void setSettingId(int settingId) {
        this.settingId = settingId;
    }

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public int getSettingGroup() {
        return settingGroup;
    }

    public void setSettingGroup(int settingGroup) {
        this.settingGroup = settingGroup;
    }

    public String getSettingName() {
        return settingName;
    }

    public void setSettingName(String settingName) {
        this.settingName = settingName;
    }

    public String getSettingValue() {
        return settingValue;
    }

    public void setSettingValue(String settingValue) {
        this.settingValue = settingValue;
    }

    public int getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(int displayOrder) {
        this.displayOrder = displayOrder;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "SubjectSetting{" + "settingId=" + settingId + ", subjectId=" + subjectId + ", settingGroup=" + settingGroup + ", settingName=" + settingName + ", settingValue=" + settingValue + ", displayOrder=" + displayOrder + ", description=" + description + '}';
    }

    
}
