/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import dal.UserDAO;
import java.util.List;

/**
 *
 * @author TRAN DUNG
 */
public class User {

    private int userId;
    private String fullName;
    private String email;
    private String mobile;
    private String password;
    private String avatarUrl;
    private int roleId;
    private String note;
    private int isActive;
    public String accessToken;

    public User(int userId, String fullName, String email, String mobile, String password, String avatarUrl, int roleId, String note, int isActive, String accessToken) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.mobile = mobile;
        this.password = password;
        this.avatarUrl = avatarUrl;
        this.roleId = roleId;
        this.note = note;
        this.isActive = isActive;
        this.accessToken = accessToken;
    }

    public User(String fullName, String email, String mobile, String password, String avatarUrl, int roleId, String note) {
        this.fullName = fullName;
        this.email = email;
        this.mobile = mobile;
        this.password = password;
        this.avatarUrl = avatarUrl;
        this.roleId = roleId;
        this.note = note;
    }

    public User(int userId, String fullName, String email, String mobile, String password, int roleId, String note, int isActive) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.mobile = mobile;
        this.password = password;
        this.roleId = roleId;
        this.note = note;
        this.isActive = isActive;
    }

    public User(int userId, String fullName, String email, String mobile, String password, int roleId, String note) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.mobile = mobile;
        this.password = password;
        this.roleId = roleId;
        this.note = note;
    }

    public User(String fullName, String email, String mobile, String password, int roleId, String note) {
        this.fullName = fullName;
        this.email = email;
        this.mobile = mobile;
        this.password = password;
        this.roleId = roleId;
        this.note = note;
    }
public User(int userId, String fullName, int roleId) {
        this.userId = userId;
        this.fullName = fullName;
        this.roleId = roleId;
    }
    public User(int userId, String fullName, String email, int roleId, int isActive) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.roleId = roleId;
        this.isActive = isActive;
    }

        
    
    public User(int userId, int isActive) {
        this.userId = userId;
        this.isActive = isActive;
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }
 
    public User() {
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }

    @Override
    public String toString() {
        return "User{" + "userId=" + userId + ", fullName=" + fullName + ", email=" + email + ", mobile=" + mobile + ", password=" + password + ", avatarUrl=" + avatarUrl + ", roleId=" + roleId + ", note=" + note + ", isActive=" + isActive + '}';
    }

    

    public boolean createNewUser() {
        UserDAO userDAO = new UserDAO();
        return userDAO.create(this);
    }

    public boolean checkFieldExisted(String column, String value) {
        UserDAO userDAO = new UserDAO();
        return userDAO.checkExisted(column, value);
    }
    

    public User getUserByEmailOrPhone(String column, String value) {
        UserDAO userDAO = new UserDAO();
        return userDAO.getUserByEmailOrPhone(column, value);
    }

    public boolean changePassword(String pass, String account, String mode) {
        UserDAO userDAO = new UserDAO();
        return userDAO.changePassword(pass, account, mode);
    }
    
    public List<User> getListUserNoclass() {
        UserDAO userDAO = new UserDAO();
        return userDAO.getListStudentNoClass();
    }
}
