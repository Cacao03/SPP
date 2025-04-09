/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import dal.SystemSettingDAO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author TRAN DUNG
 */
public class Setting {

    private int settingId;
    private String settingGroup;
    private String settingName;
    private int displayOrder;
    private String description;
    private int isActive;

    public Setting() {
    }

    public Setting(int settingId, String settingGroup, String settingName, String description) {
        this.settingId = settingId;
        this.settingGroup = settingGroup;
        this.settingName = settingName;
        this.description = description;
    }

    public Setting(String settingGroup, String settingName, String description) {
        this.settingGroup = settingGroup;
        this.settingName = settingName;
        this.description = description;
    }

    public Setting(int settingId, String settingGroup, String settingName, int displayOrder, String description, int isActive) {
        this.settingId = settingId;
        this.settingGroup = settingGroup;
        this.settingName = settingName;
        this.displayOrder = displayOrder;
        this.description = description;
        this.isActive = isActive;
    }

    public Setting(String settingGroup, String settingName, int displayOrder, String description) {
        this.settingGroup = settingGroup;
        this.settingName = settingName;
        this.displayOrder = displayOrder;
        this.description = description;
    }

    public int getSettingId() {
        return settingId;
    }

    public void setSettingId(int settingId) {
        this.settingId = settingId;
    }

    public String getSettingGroup() {
        return settingGroup;
    }

    public void setSettingGroup(String settingGroup) {
        this.settingGroup = settingGroup;
    }

    public String getSettingName() {
        return settingName;
    }

    public void setSettingName(String settingName) {
        this.settingName = settingName;
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

    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }

    @Override
    public String toString() {
        return "Setting{" + "settingId=" + settingId + ", settingGroup=" + settingGroup + ", settingName=" + settingName + ", displayOrder=" + displayOrder + ", description=" + description + ", isActive=" + isActive + '}';
    }

    public Setting getSettingByID(int id) {
        SystemSettingDAO settingDAO = new SystemSettingDAO();
        return settingDAO.getSettingbyID(id);
    }

    public int checkSettingActive(int id) {
        SystemSettingDAO settingDAO = new SystemSettingDAO();
        return settingDAO.checkSettingActive(id);
    }

    public List<Setting> getListGroupSetting(int group) {
        SystemSettingDAO settingDAO = new SystemSettingDAO();
        return settingDAO.getListGroupSetting(group);
    }

    public boolean checkDomainExist(String domain) {
        SystemSettingDAO settingDAO = new SystemSettingDAO();
        return settingDAO.checkDomainExist(domain);
    }
}
