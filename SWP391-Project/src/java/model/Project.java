/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author TRAN DUNG
 */
public class Project {

    private int project_id;
    private int class_id;
    private String project_code;
    private String project_en_name;
    private String project_vi_name;
    private String project_descript;
    private String group_name;
    private int mentor_id;
    private int co_mentor_id;
    private int status;
    private String access_token;
    private String url;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
    

    public String getAccess_token() {
        return access_token;
    }

    public void setAccess_token(String access_token) {
        this.access_token = access_token;
    }
    
    

    public Project(String group_name, int mentor_id) {
        this.group_name = group_name;
        this.mentor_id = mentor_id;
    }

    public Project(int project_id, int class_id, String project_code, String project_en_name, String project_vi_name, String project_descript, String group_name, int mentor_id, int co_mentor_id, int status) {
        this.project_id = project_id;
        this.class_id = class_id;
        this.project_code = project_code;
        this.project_en_name = project_en_name;
        this.project_vi_name = project_vi_name;
        this.project_descript = project_descript;
        this.group_name = group_name;
        this.mentor_id = mentor_id;
        this.co_mentor_id = co_mentor_id;
        this.status = status;
    }
    
    

    public String getGroup_name() {
        return group_name;
    }

    public void setGroup_name(String group_name) {
        this.group_name = group_name;
    }
    
    public Project() {
    }

    

    public int getMentor_id() {
        return mentor_id;
    }

    public void setMentor_id(int mentor_id) {
        this.mentor_id = mentor_id;
    }

    public int getCo_mentor_id() {
        return co_mentor_id;
    }

    public void setCo_mentor_id(int co_mentor_id) {
        this.co_mentor_id = co_mentor_id;
    }

   


    public int getProject_id() {
        return project_id;
    }

    public void setProject_id(int project_id) {
        this.project_id = project_id;
    }

    public int getClass_id() {
        return class_id;
    }

    public void setClass_id(int class_id) {
        this.class_id = class_id;
    }

    public String getProject_code() {
        return project_code;
    }

    public void setProject_code(String project_code) {
        this.project_code = project_code;
    }

    public String getProject_en_name() {
        return project_en_name;
    }

    public void setProject_en_name(String project_en_name) {
        this.project_en_name = project_en_name;
    }

    public String getProject_vi_name() {
        return project_vi_name;
    }

    public void setProject_vi_name(String project_vi_name) {
        this.project_vi_name = project_vi_name;
    }

    public String getProject_descript() {
        return project_descript;
    }

    public void setProject_descript(String project_descript) {
        this.project_descript = project_descript;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Project{" + "project_id=" + project_id + ", class_id=" + class_id + ", project_code=" + project_code + ", project_en_name=" + project_en_name + ", project_vi_name=" + project_vi_name + ", project_descript=" + project_descript + ", status=" + status + '}';
    }

}
